# Vérifie si le répertoire de sauvegarde existe
$savePath = "C:\Temp"
if (-Not (Test-Path $savePath)) {
    New-Item -ItemType Directory -Path $savePath
}

# Fonction pour prendre une capture d'écran
Function Take-Screenshot {
    $fileName = [System.IO.Path]::Combine($savePath, ("screenshot_" + (Get-Date -Format "yyyyMMddHHmmss") + ".png"))
    Add-Type -AssemblyName System.Windows.Forms
    $screen = [System.Windows.Forms.Screen]::PrimaryScreen
    $width = $screen.Bounds.Width
    $height = $screen.Bounds.Height
    $bmp = New-Object System.Drawing.Bitmap $width, $height
    $graphics = [System.Drawing.Graphics]::FromImage($bmp)
    $graphics.CopyFromScreen(0, 0, 0, 0, $bmp.Size)
    $bmp.Save($fileName)
}

# Ouvrir Chrome et aller sur Google
Start-Process "chrome.exe" "https://www.google.com"

# Attendre 10 secondes
Start-Sleep -Seconds 10

# Prendre la première capture d'écran
Take-Screenshot

# Boucle pour prendre des captures d'écran toutes les 10 minutes
while ($true) {
    # Attendre 10 minutes
    Start-Sleep -Seconds 600

    # Prendre une capture d'écran
    Take-Screenshot
}
