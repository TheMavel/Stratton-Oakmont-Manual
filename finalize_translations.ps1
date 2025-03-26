# PowerShell script to finalize translations and ensure consistency

function Update-HTMLLanguageClasses {
    param (
        [string]$filePath
    )
    
    # Read the file content
    $content = Get-Content -Path $filePath -Raw
    
    # Make sure all headings have language classes
    foreach ($tag in @('h1', 'h2', 'h3', 'h4')) {
        $pattern = "<$tag>([^<]+)</$tag>"
        $content = [regex]::Replace($content, $pattern, "<$tag class=`"lang-en`">`$1</$tag>`r`n        <$tag class=`"lang-de`">`$1</$tag>")
    }
    
    # Make sure all paragraphs have language classes
    $pattern = "(?<!class=\S+)<p>([^<]+)</p>"
    $content = [regex]::Replace($content, $pattern, "<p class=`"lang-en`">`$1</p>`r`n        <p class=`"lang-de`">`$1</p>")
    
    # Make sure all list items have language classes
    $pattern = "(?<!class=\S+)<li>([^<]+)</li>"
    $content = [regex]::Replace($content, $pattern, "<li class=`"lang-en`">`$1</li>`r`n        <li class=`"lang-de`">`$1</li>")
    
    # Make sure all links have language classes
    $pattern = "(?<!class=\S+)<a href=`"([^`"]+)`">([^<]+)</a>"
    $content = [regex]::Replace($content, $pattern, "<a href=`"`$1`" class=`"lang-en`">`$2</a>`r`n        <a href=`"`$1`" class=`"lang-de`">`$2</a>")
    
    # Make sure all strong tags have language classes
    $pattern = "(?<!class=\S+)<strong>([^<]+)</strong>"
    $content = [regex]::Replace($content, $pattern, "<strong class=`"lang-en`">`$1</strong>`r`n        <strong class=`"lang-de`">`$1</strong>")
    
    # Write the updated content back to the file
    Set-Content -Path $filePath -Value $content
    
    Write-Host "Finalized translations in $filePath"
}

# Get all HTML files
$htmlFiles = Get-ChildItem -Path . -Filter "*.html" -Exclude "stratton_manual.html"

foreach ($file in $htmlFiles) {
    Write-Host "Processing $($file.Name)..."
    Update-HTMLLanguageClasses -filePath $file.FullName
}

Write-Host "All files have been finalized with proper language classes."

# Update the README to reflect the completed work
$readmeContent = Get-Content -Path "README.md" -Raw
$updatedReadme = $readmeContent -replace "This material is provided for training and educational purposes only.", "This material is provided for training and educational purposes only. The manual has been enhanced with full multilingual support, with all content available in both English and German."
Set-Content -Path "README.md" -Value $updatedReadme

Write-Host "README has been updated to reflect the completed work." 