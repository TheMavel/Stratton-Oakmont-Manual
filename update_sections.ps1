# PowerShell script to update all section files with language switching capability
$sectionFiles = Get-ChildItem -Path . -Filter "section*.html" -Exclude "section1_self_improvement.html", "section7_motivation.html"

# Define translations
$translations = @{
    "Selling Power" = "Verkaufskraft"
    "Sales Techniques" = "Verkaufstechniken"
    "Best Practices" = "Bewährte Methoden"
    "Special Situations" = "Besondere Situationen"
    "Special Handling Situations" = "Besondere Handhabungssituationen"
    "Motivation and Mindset" = "Motivation und Denkweise"
    "Phone Skills" = "Telefonkompetenzen"
    "Resources" = "Ressourcen"
    "Next: Selling Power →" = "Weiter: Verkaufskraft →"
    "Next: Sales Techniques →" = "Weiter: Verkaufstechniken →"
    "Next: Best Practices →" = "Weiter: Bewährte Methoden →"
    "Next: Special Situations →" = "Weiter: Besondere Situationen →"
    "Next: Special Handling Situations →" = "Weiter: Besondere Handhabungssituationen →"
    "Next: Motivation and Mindset →" = "Weiter: Motivation und Denkweise →"
    "Next: Phone Skills →" = "Weiter: Telefonkompetenzen →"
    "Next: Resources →" = "Weiter: Ressourcen →"
    "← Back to Home" = "← Zurück zur Startseite"
    "← Back to Selling Power" = "← Zurück zu Verkaufskraft"
    "← Back to Sales Techniques" = "← Zurück zu Verkaufstechniken"
    "← Back to Best Practices" = "← Zurück zu Bewährte Methoden"
    "← Back to Special Situations" = "← Zurück zu Besondere Situationen"
    "← Back to Special Handling Situations" = "← Zurück zu Besondere Handhabungssituationen"
    "← Back to Motivation and Mindset" = "← Zurück zu Motivation und Denkweise"
    "← Back to Phone Skills" = "← Zurück zu Telefonkompetenzen"
}

foreach ($file in $sectionFiles) {
    Write-Host "Processing $($file.Name)..."
    
    # Read the file content
    $content = Get-Content -Path $file.FullName -Raw
    
    # Add language-switcher.js
    $content = $content -replace '<link rel="stylesheet" href="styles.css">', '<link rel="stylesheet" href="styles.css">' + "`r`n" + '    <script src="language-switcher.js"></script>'
    
    # Add language selector buttons
    $languageSelector = @"
    <div class="language-selector">
        <button class="language-btn active" data-lang="en" onclick="switchLanguage('en')">EN</button>
        <button class="language-btn" data-lang="de" onclick="switchLanguage('de')">DE</button>
    </div>

"@
    $content = $content -replace '<body>', "<body>`r`n$languageSelector"
    
    # Update header with language classes
    $content = $content -replace '<h1>Stratton Oakmont Sales Training Manual</h1>', '<h1 class="lang-en">Stratton Oakmont Sales Training Manual</h1>' + "`r`n" + '        <h1 class="lang-de">Stratton Oakmont Schulungshandbuch für Vertrieb</h1>'
    
    # Get the section title from the original content
    $titleMatch = [regex]::Match($content, '<p>([^<]+)</p>\s*</header>')
    if ($titleMatch.Success) {
        $englishTitle = $titleMatch.Groups[1].Value
        $germanTitle = $translations[$englishTitle]
        if (-not $germanTitle) {
            $germanTitle = "[DE: $englishTitle]"
        }
        
        $content = $content -replace '<p>([^<]+)</p>\s*</header>', '<p class="lang-en">$1</p>' + "`r`n" + '        <p class="lang-de">' + $germanTitle + '</p>' + "`r`n" + '    </header>'
    }
    
    # Add PDF download link
    $pdfDownload = @"
    <p><a href="StrattonOakmont95_qf7EDgcEQg6c6CXJFq1U.pdf" download class="pdf-download lang-en">Download Original PDF</a>
    <a href="StrattonOakmont95_qf7EDgcEQg6c6CXJFq1U.pdf" download class="pdf-download lang-de">Original PDF herunterladen</a></p>
"@
    $content = $content -replace '</header>\s*<div class="navigation">[^<]+</div>', '</header>' + "`r`n" + '    <div class="navigation">' + "`r`n" + '        <a href="index.html" class="lang-en">← Back to Home</a>' + "`r`n" + '        <a href="index.html" class="lang-de">← Zurück zur Startseite</a>' + "`r`n" + "    </div>`r`n`r`n    $pdfDownload"
    
    # Update navigation links with language classes
    $navMatches = [regex]::Matches($content, '<a href="([^"]+)">([^<]+)</a>')
    foreach ($match in $navMatches) {
        $href = $match.Groups[1].Value
        $text = $match.Groups[2].Value
        $germanText = $translations[$text]
        if (-not $germanText) {
            $germanText = "[DE: $text]"
        }
        
        $newLink = '<a href="' + $href + '" class="lang-en">' + $text + '</a>' + "`r`n" + '        <a href="' + $href + '" class="lang-de">' + $germanText + '</a>'
        $content = $content -replace [regex]::Escape($match.Value), $newLink
    }
    
    # Update section headings with language classes
    $h2Matches = [regex]::Matches($content, '<h2>([^<]+)</h2>')
    foreach ($match in $h2Matches) {
        $text = $match.Groups[1].Value
        $germanText = $translations[$text]
        if (-not $germanText) {
            $germanText = "[DE: $text]"
        }
        
        $newHeading = '<h2 class="lang-en">' + $text + '</h2>' + "`r`n" + '        <h2 class="lang-de">' + $germanText + '</h2>'
        $content = $content -replace [regex]::Escape($match.Value), $newHeading
    }
    
    # Update footer disclaimer with language classes
    $content = $content -replace '<div class="disclaimer">FOR TRAINING PURPOSES ONLY</div>', '<div class="disclaimer lang-en">FOR TRAINING PURPOSES ONLY</div>' + "`r`n" + '        <div class="disclaimer lang-de">NUR FÜR SCHULUNGSZWECKE</div>'
    
    # Write the updated content back to the file
    Set-Content -Path $file.FullName -Value $content
    
    Write-Host "Updated $($file.Name) successfully."
}

Write-Host "All section files have been updated with language switching capability." 