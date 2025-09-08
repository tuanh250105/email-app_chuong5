# Đường dẫn Tomcat
$TomcatPath = "D:\BaiTap\Nam3\LTWeb\Chuong5\apache-tomcat-9.0.108"

# Thư mục project
$ProjectPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$SrcPath = Join-Path $ProjectPath "src\java"
$BinPath = Join-Path $ProjectPath "bin"
$LibPath = Join-Path $ProjectPath "lib"
$WebPath = Join-Path $ProjectPath "web"

# 1. Xóa bin cũ và tạo lại
if (Test-Path $BinPath) { Remove-Item -Recurse -Force $BinPath }
New-Item -ItemType Directory -Force -Path $BinPath | Out-Null

# 2. Gom classpath từ lib/*.jar
$JarFiles = Get-ChildItem -Recurse $LibPath -Filter *.jar | ForEach-Object { $_.FullName }
$Jars = $JarFiles -join ";"

# 3. Lấy danh sách source file
$SourceFiles = Get-ChildItem -Recurse $SrcPath -Filter *.java | ForEach-Object { $_.FullName }

Write-Host "Compiling Java sources..."
javac -cp "$Jars" -d "$BinPath" $SourceFiles

# 4. Copy class vào WEB-INF\classes
$ClassesPath = Join-Path $WebPath "WEB-INF\classes"
if (Test-Path $ClassesPath) { Remove-Item -Recurse -Force $ClassesPath }
New-Item -ItemType Directory -Force -Path $ClassesPath | Out-Null
Copy-Item -Recurse "$BinPath\*" $ClassesPath

# 5. Deploy vào Tomcat\webapps
$DeployPath = Join-Path $TomcatPath "webapps\ch05_ex2_email"
if (Test-Path $DeployPath) { Remove-Item -Recurse -Force $DeployPath }
Copy-Item -Recurse $WebPath $DeployPath

Write-Host "✅ Build & deploy hoàn tất!"
Write-Host "👉 Truy cập: http://localhost:8080/ch05_ex2_email/emailList"
