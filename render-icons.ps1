# Check for inkscape
If (-Not (Get-Command "inkscape" -ErrorAction SilentlyContinue)) {
    Throw "Couldn't find inkscape"
}

Write-Host "Exporting web favicon"
inkscape --export-filename "src/kaiteki/web/favicon.png" --export-type="png" "assets/icons/windows/kaiteki-small.svg" >$null

Write-Host "Exporting web PWA icons"
inkscape --export-filename "src/kaiteki/web/icons/Icon-192.png" --export-type="png" -w 192 -h 192 "assets/icons/windows/kaiteki-small.svg" >$null
inkscape --export-filename "src/kaiteki/web/icons/Icon-512.png" --export-type="png" -w 512 -h 512 "assets/icons/windows/kaiteki-small.svg" >$null

Write-Host ""
Write-Host "Please note that Android icons cannot be rendered over a script. Use Android Studio to generate Android icons."