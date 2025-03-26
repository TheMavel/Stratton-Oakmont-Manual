# Simple script to add language classes to HTML elements
# Run for each file manually to avoid console errors

function Add-LanguageClasses {
    param (
        [string]$filePath
    )
    
    Write-Host "Processing $filePath..."
    
    # Read the file content
    $content = Get-Content -Path $filePath -Raw
    
    # Make sure all h2, h3, h4 elements have language classes
    foreach ($tag in @('h2', 'h3', 'h4')) {
        $pattern = "<$tag>([^<]+)</$tag>"
        if ($content -match $pattern) {
            $content = $content -replace $pattern, "<$tag class=`"lang-en`">`$1</$tag>`r`n        <$tag class=`"lang-de`">`$1</$tag>"
        }
    }
    
    # Make sure all paragraphs have language classes if they don't already
    $pattern = "<p>([^<]+)</p>"
    $content = $content -replace $pattern, "<p class=`"lang-en`">`$1</p>`r`n        <p class=`"lang-de`">`$1</p>"
    
    # Make sure all list items have language classes if they don't already
    $pattern = "<li>([^<]+)</li>"
    $content = $content -replace $pattern, "<li class=`"lang-en`">`$1</li>`r`n        <li class=`"lang-de`">`$1</li>"
    
    # Make sure strong tags have language classes
    $pattern = "<strong>([^<]+)</strong>"
    $content = $content -replace $pattern, "<strong class=`"lang-en`">`$1</strong>`r`n        <strong class=`"lang-de`">`$1</strong>"
    
    # Make sure disclaimer has language classes
    $pattern = "<div class=`"disclaimer`">([^<]+)</div>"
    $content = $content -replace $pattern, "<div class=`"disclaimer lang-en`">`$1</div>`r`n        <div class=`"disclaimer lang-de`">NUR FÜR SCHULUNGSZWECKE</div>"
    
    # Write the updated content back to the file
    Set-Content -Path $filePath -Value $content
    
    Write-Host "Updated $filePath successfully."
}

# Example usage:
# Add-LanguageClasses -filePath "section3_sales_techniques.html" 