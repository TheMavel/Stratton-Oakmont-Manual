# PowerShell script to add language classes to all content in HTML files
# This creates proper language switching functionality for all text content

function Add-LanguageClasses {
    param (
        [string]$content
    )
    
    # Process headings (h1, h2, h3, h4)
    foreach ($h in @("h1", "h2", "h3", "h4")) {
        $regex = "<$h>([^<]+)</$h>"
        $matches = [regex]::Matches($content, $regex)
        foreach ($match in $matches) {
            $original = $match.Value
            $text = $match.Groups[1].Value
            
            # Create English and German versions
            $replacement = "<$h class=`"lang-en`">$text</$h>`n        <$h class=`"lang-de`">$text</$h>"
            $content = $content -replace [regex]::Escape($original), $replacement
        }
    }
    
    # Process paragraphs
    $regex = "<p>([^<]+)</p>"
    $matches = [regex]::Matches($content, $regex)
    foreach ($match in $matches) {
        $original = $match.Value
        $text = $match.Groups[1].Value
        
        # Skip if already has a class
        if ($original -match "class=") {
            continue
        }
        
        # Create English and German versions
        $replacement = "<p class=`"lang-en`">$text</p>`n        <p class=`"lang-de`">$text</p>"
        $content = $content -replace [regex]::Escape($original), $replacement
    }
    
    # Process list items
    $regex = "<li>([^<]*(?:<(?!\/li>)[^<]*)*)<\/li>"
    $matches = [regex]::Matches($content, $regex)
    foreach ($match in $matches) {
        $original = $match.Value
        $innerContent = $match.Groups[1].Value
        
        # Skip if already has a class
        if ($original -match "class=") {
            continue
        }
        
        # For simple list items without nested elements
        if (-not ($innerContent -match "<p|<ul|<ol|<div")) {
            $replacement = "<li class=`"lang-en`">$innerContent</li>`n        <li class=`"lang-de`">$innerContent</li>"
            $content = $content -replace [regex]::Escape($original), $replacement
        }
        # For list items with paragraphs
        elseif ($innerContent -match "<p>([^<]+)</p>") {
            $newInnerContent = $innerContent -replace "<p>([^<]+)</p>", "<p class=`"lang-en`">`$1</p>`n            <p class=`"lang-de`">`$1</p>"
            $replacement = "<li>$newInnerContent</li>"
            $content = $content -replace [regex]::Escape($original), $replacement
        }
    }
    
    # Process a tags (for nav links)
    $regex = "<a href=`"([^`"]+)`">([^<]+)</a>"
    $matches = [regex]::Matches($content, $regex)
    foreach ($match in $matches) {
        $original = $match.Value
        $href = $match.Groups[1].Value
        $text = $match.Groups[2].Value
        
        # Skip if already has a class
        if ($original -match "class=") {
            continue
        }
        
        # Create English and German versions
        $replacement = "<a href=`"$href`" class=`"lang-en`">$text</a>`n        <a href=`"$href`" class=`"lang-de`">$text</a>"
        $content = $content -replace [regex]::Escape($original), $replacement
    }
    
    # Process strong tags
    $regex = "<strong>([^<]+)</strong>"
    $matches = [regex]::Matches($content, $regex)
    foreach ($match in $matches) {
        $original = $match.Value
        $text = $match.Groups[1].Value
        
        # Skip if parent already has a class
        if ($original -match "class=") {
            continue
        }
        
        # Create English and German versions
        $replacement = "<strong class=`"lang-en`">$text</strong>`n        <strong class=`"lang-de`">$text</strong>"
        $content = $content -replace [regex]::Escape($original), $replacement
    }
    
    return $content
}

# Get all HTML files except index.html
$htmlFiles = Get-ChildItem -Path . -Filter "*.html" -Exclude "index.html", "stratton_manual.html"

foreach ($file in $htmlFiles) {
    Write-Host "Processing $($file.Name)..."
    
    # Read the file content
    $content = Get-Content -Path $file.FullName -Raw
    
    # Add language classes
    $updatedContent = Add-LanguageClasses -content $content
    
    # Write the updated content back to the file
    Set-Content -Path $file.FullName -Value $updatedContent
    
    Write-Host "Updated $($file.Name) successfully."
}

Write-Host "All files have been updated with proper language classes." 