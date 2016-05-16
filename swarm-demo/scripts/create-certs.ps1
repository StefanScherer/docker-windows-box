$Global:PathToOpenSSL = "C:\Program Files\Git\mingw64\bin\openssl.exe"
$Global:caPasskey = "pass:p@ssw0rd"

$Global:caFile = ($keyPath + "ca.pem")
$Global:caKayFile = ($keyPath + "ca-key.pem")
$Global:keyPath = "c:\myDockerKeys\"

function RunSSLCmd {
Param(
  [Parameter(Mandatory=$True)]
  [String[]] $OpenSSLArguments
)

    $processInfo = New-Object System.Diagnostics.ProcessStartInfo
    $processInfo.FileName = $Global:PathToOpenSSL
    $processInfo.RedirectStandardError = $true
    $processInfo.RedirectStandardOutput = $true
    $processInfo.UseShellExecute = $false
    $processInfo.Arguments = $OpenSSLArguments

    $process = New-Object System.Diagnostics.Process
    $process.StartInfo = $processInfo
    $process.Start() | Out-Null
    $process.WaitForExit()
    $stdout = $process.StandardOutput.ReadToEnd()

    if ($process.ExitCode -ne 0)
    {
        $errorString= $process.StandardError.ReadToEnd()
        Write-Error "OpenSSL Returned Nonzero results: $process.ExitCode"
        Write-Error "OpenSSL Error Out:  $errorString"
        thrown "OpenSSL Returned Nonzero results: $process.ExitCode"
    }
}

function New-OpenSSLCertAuth{
    Write-Host "Creating Certificate Authority Keys"

    if (Get-Item $Global:keyPath -ErrorAction SilentlyContinue)
    {
        Write-Error "Key directory exists"
        throw "Key directory exisits"
    }
    else
    {
        New-Item -p $keyPath -ItemType Directory | Out-Null
    }

    Write-Host "-Createing CA private key"
    #generate CA private keys
    $openSSLCmd = @("genrsa", "-aes256", "-passout", $Global:caPasskey, "-out", $Global:caKayFile,  "4096" )
    RunSSLCmd -OpenSSLArguments $openSSLCmd

    Write-Host "-Createing CA public key"
    #generate CA public keys
    $subLine = "/C=US/ST=Washington/L=Redmond/O=./OU=."   #CommonName?
    $openSSLCmd = @("req", "-subj", $subLine, "-new", "-x509", "-days", "365", "-passin", $Global:caPasskey, "-key", $Global:caKayFile, "-sha256", "-out", $Global:caFile)
    RunSSLCmd -OpenSSLArguments $openSSLCmd

    Write-Host "-Certificate Authority Keys Generated"
}

function New-ServerKeyandCert {
Param(
  [String]
  $serverName = $env:COMPUTERNAME,

  [Parameter(Mandatory=$True)]
  [String[]]
  $serverIPAddresses,

  [String]
  $serverKeyFile = ($Global:keyPath + $serverName + "_server-key.pem"),

  [String]
  $serverCSRFile = ($Global:keyPath + $serverName + "_server.csr"),

  [String]
  $serverCert = ($Global:keyPath + $serverName + "_server-cert.pem"),

  [String]
  $openSSLExtFile = ($Global:keyPath + "extfile.cnf")
)
    Write-Host "Creating Server Key and Certifcate"

    Write-Host "-Verifying CA Keys"
    if (!(Get-Item $Global:caFile -ErrorAction SilentlyContinue))
    {
        Write-Error "CA Public Key Not Found"
        throw "CA Public Key Not Found"
    }

    if (!(Get-Item $Global:caKayFile -ErrorAction SilentlyContinue))
    {
        Write-Error "CA Private Key Not Found"
        throw "CA Private Key Not Found"
    }

    Write-Host "-Createing Server key"
    #create a server key
    $openSSLCmd =   @("genrsa", "-out", $serverKeyFile, "4096")
    RunSSLCmd -OpenSSLArguments $openSSLCmd

    Write-Host "-Createing Server certificate request"
    #create certificate signing request
    $subLine = ("/CN='" + $serverName + "'/")

    $openSSLCmd =  @("req", "-subj", $subLine, "-sha256", "-new", "-key", $serverKeyFile, "-out",  $serverCSRFile )
    RunSSLCmd -OpenSSLArguments $openSSLCmd

    Write-Host "-Createing extended key use extention file"
    #created a extendedkeyusage file and sign the public key with our CA
    "subjectAltName = " | Out-File -FilePath $openSSLExtFile -NoNewline -Encoding ascii

    for ($c = 0; $c -lt $serverIPAddresses.count; $c++)
    {
        ("IP:" + $serverIPAddresses[$c]) | Out-File -FilePath $openSSLExtFile -Append -NoNewline -Encoding ascii
        if (($c + 1) -lt $serverIPAddresses.count) { "," | Out-File -FilePath $openSSLExtFile -Append -NoNewline -Encoding ascii}
    }

    Write-Host "-Signing Server request and generating certificate"
    #sign the public key with our CA
    $openSSLCmd =  @("x509", "-req", "-days", "365", "-passin", $Global:caPasskey, "-sha256", "-in",  $serverCSRFile, "-CA", $Global:caFile, "-CAkey", $Global:caKayFile, "-CAcreateserial",  "-out", $serverCert, "-extfile", $openSSLExtFile)
    RunSSLCmd -OpenSSLArguments $openSSLCmd

    Write-Host "-Clening up extention file and cerficate request file"
    #Remove Client ExtFile
    Remove-Item $openSSLExtFile
    Remove-Item $serverCSRFile

    Write-Host "-Done Creating Server Certifcates!"
}

function New-ClientKeyandCert {
Param(
  [String]
    $clientKeyFile = ($Global:keyPath + "key.pem"),

  [String]
  $clientCSRFile = ($Global:keyPath + "client.csr"),

  [String]
  $clientCert = ($Global:keyPath + "cert.pem"),

  [String]
  $openSSLExtFile = ($Global:keyPath + "extfile.cnf")
)
    Write-Host "Creating Client Key and Certifcate"

    Write-Host "-Verifying CA Keys"
    if (!(Get-Item $Global:caFile -ErrorAction SilentlyContinue))
    {
        Write-Error "CA Public Key Not Found"
        throw "CA Public Key Not Found"
    }

    if (!(Get-Item $Global:caKayFile -ErrorAction SilentlyContinue))
    {
        Write-Error "CA Private Key Not Found"
        throw "CA Private Key Not Found"
    }

    Write-Host "-Createing client key"
    #create a client key
    $openSSLCmd = @("genrsa", "-passout", $Global:caPasskey, "-out", $clientKeyFile, "4096")
    RunSSLCmd -OpenSSLArguments $openSSLCmd

    Write-Host "-Createing cient certificate request"
    #create certificate signing request
    $openSSLCmd =  @("req", "-subj", "/CN=client", "-new",  "-passin", $Global:caPasskey, "-key", $clientKeyFile, "-out",  $clientCSRFile)
    RunSSLCmd -OpenSSLArguments $openSSLCmd

    Write-Host "-Createing extended key use extention file"
    #created a extendedkeyusage file and sign the public key with our CA
    "extendedKeyUsage = clientAuth" | Out-File -FilePath $openSSLExtFile -NoNewline -Encoding ascii

    Write-Host "-Signing client request and generating certificate"
    $openSSLCmd =  @("x509", "-req", "-days", "365", "-passin", $Global:caPasskey, "-sha256", "-in",  $clientCSRFile, "-CA", $Global:caFile, "-CAkey", $Global:caKayFile, "-CAcreateserial",  "-out", $clientCert, "-extfile", $openSSLExtFile)
    RunSSLCmd -OpenSSLArguments $openSSLCmd

    Write-Host "-Clening up extention file and cerficate request file"
    #Remove Client ExtFile
    Remove-Item $openSSLExtFile
    Remove-Item $clientCSRFile

    Write-Host "-Done Creating Client Certifcates!"
}

$serverIPs = @()

$ips = Get-NetIPAddress -AddressFamily IPv4
for ($c = 0; $c -lt $ips.count; $c++)
{
    $serverIPs += $ips[$c].IPAddress
}
