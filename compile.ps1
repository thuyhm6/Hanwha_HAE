# Compiles all Java sources under src/ into WebRoot/WEB-INF/classes using javac directly.
# Bypasses the VS Code Java Language Server build, which has proven unreliable for this
# legacy (non-Maven/Gradle) project: "Clean Java Language Server Workspace" wipes the
# output folder but does not reliably finish rebuilding it.

$ErrorActionPreference = "Stop"

$jdk = "C:\Program Files\Java\jdk1.8.0_231\bin\javac.exe"
$proj = $PSScriptRoot
$outDir = "$proj/WebRoot/WEB-INF/classes" -replace '\\','/'

New-Item -ItemType Directory -Force -Path $outDir | Out-Null

$libJars = Get-ChildItem "$proj\WebRoot\WEB-INF\lib\*.jar" -File | ForEach-Object { $_.FullName -replace '\\','/' }
$tomcatJars = @(
  "D:/Java/apache-tomcat/lib/el-api.jar",
  "D:/Java/apache-tomcat/lib/jsp-api.jar",
  "D:/Java/apache-tomcat/lib/ojdbc14.jar",
  "D:/Java/apache-tomcat/lib/servlet-api.jar"
)
$cp = (($tomcatJars + $libJars) -join ";")

$tmp = New-Item -ItemType Directory -Force -Path "$env:TEMP\hanwha_hae_build"
$utf8NoBom = New-Object System.Text.UTF8Encoding $false

$optsFile = "$tmp\javac_opts.txt"
[System.IO.File]::WriteAllLines($optsFile, @(
  "-encoding UTF-8"
  "-nowarn"
  "-g"
  "-d ""$outDir"""
  "-cp ""$cp"""
), $utf8NoBom)

$sourcesFile = "$tmp\sources.txt"
$sourceLines = Get-ChildItem "$proj\src" -Recurse -Filter *.java | ForEach-Object { '"' + ($_.FullName -replace '\\','/') + '"' }
[System.IO.File]::WriteAllLines($sourcesFile, $sourceLines, $utf8NoBom)

& $jdk "@$optsFile" "@$sourcesFile"
if ($LASTEXITCODE -ne 0) {
    Write-Error "javac failed with exit code $LASTEXITCODE"
    exit $LASTEXITCODE
}

$count = (Get-ChildItem $outDir -Recurse -Filter *.class | Measure-Object).Count
Write-Host "Compiled OK - $count class files in WebRoot/WEB-INF/classes"
