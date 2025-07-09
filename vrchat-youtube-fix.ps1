# yt-dlp-fix.ps1
# This script updates VRChat's copy of yt-dlp,
# then configures it to borrow cookies from your browser.
# Hopefully this will mitigate the yt-dlp video loading issues.

# Paths
$SourceUri = "https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe"
$TargetDir = "$env:USERPROFILE\AppData\LocalLow\VRChat\VRChat\Tools"
$ConfFile = "$TargetDir\yt-dlp.conf"

# Download the latest yt-dlp executable
write-output "Downloading latest yt-dlp..."
Invoke-WebRequest -Uri "$SourceUri" -OutFile "$TargetDir\yt-dlp.exe"
write-output "Updated yt-dlp installed @ $TargetDir\yt-dlp.exe"
write-output ""
write-output "Next, yt-dlp will be configured to borrow cookies from your browser to help bypass youtube's bot detection."

# Prompt for browser selection
$Browser = ""
$Title = "Cookie Source Selection"
$Prompt = "Which browser do you use for watching YouTube?"
$Choices = [System.Management.Automation.Host.ChoiceDescription[]] @("&Chrome", "&Firefox", "&Brave", "&Opera", "Chromiu&m", "&Edge", "&Safari")
$Default = 0
$Choice = $host.UI.PromptForChoice($Title, $Prompt, $Choices, $Default)
switch ($choice) {
    0{$Browser = "chrome"}
    1{$Browser = "firefox"}
    2{$Browser = "brave"}
    3{$Browser = "opera"}
    4{$Browser = "chromium"}
    5{$Browser = "edge"}
    6{$Browser = "safari"}
}

# Write yt-dlp configuration
Set-Content -Path "$ConfFile" -Value "--cookies-from-browser $Browser"

# Reminder
write-output "========================================================="
write-output "  Next Steps:"
write-output "    1. Open $Browser and login to YouTube."
write-output "    2. Rejoin your VRChat world."
write-output "    3. Hopefully videos should work now :P"
write-output "========================================================="
write-output ""
write-output "Press any key to continue..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")


