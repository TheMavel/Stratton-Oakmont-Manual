# PowerShell script to translate content from English to German

# Common translations dictionary
$translations = @{
    # Navigation
    "Home" = "Startseite"
    "Self Improvement" = "Selbstverbesserung"
    "Selling Power" = "Verkaufskraft"
    "Sales Techniques" = "Verkaufstechniken"
    "Best Practices" = "Bewährte Methoden"
    "Special Situations" = "Besondere Situationen"
    "Special Handling Situations" = "Besondere Handhabungssituationen"
    "Motivation and Mindset" = "Motivation und Denkweise"
    "Phone Skills" = "Telefonkompetenzen"
    "Resources" = "Ressourcen"
    "Back to Home" = "Zurück zur Startseite"
    "Next" = "Weiter"
    "Download Original PDF" = "Original PDF herunterladen"
    
    # Common section titles
    "Napoleon Hill's Principles" = "Napoleon Hills Prinzipien"
    "Personal Experience" = "Persönliche Erfahrung"
    "Rising to Carnegie's Challenge" = "Carnegies Herausforderung annehmen"
    "Hill's Principles of Success" = "Hills Prinzipien des Erfolgs"
    "Carl May's Strategy for Winning" = "Carl Mays Strategie zum Gewinnen"
    "And winning... and winning" = "Und gewinnen... und gewinnen"
    "The Power of Hunger" = "Die Kraft des Hungers"
    "Growth Through Adversity" = "Wachstum durch Widrigkeiten"
    "Winners Manifesto" = "Manifest der Gewinner"
    "Mind Power" = "Mentale Stärke"
    "An Insight Into Becoming a Better Sales Professional" = "Ein Einblick, wie man ein besserer Vertriebsprofi wird"
    "The Anatomy of Success" = "Die Anatomie des Erfolgs"
    
    # Common phrases
    "FOR TRAINING PURPOSES ONLY" = "NUR FÜR SCHULUNGSZWECKE"
    "By:" = "Von:"
    "Managing Director" = "Geschäftsführender Direktor"
    
    # Common headings
    "Introduction" = "Einleitung"
    "Table of Contents" = "Inhaltsverzeichnis"
    
    # Important success principles
    "Develop definiteness of purpose." = "Entwickle Zielstrebigkeit."
    'Establish a "mastermind alliance"' = 'Gründe eine "Mastermind-Allianz"'
    "Develop a positive mental attitude." = "Entwickle eine positive mentale Einstellung."
    "Enforce self-discipline:" = "Stärke deine Selbstdisziplin:"
    "Think accurately." = "Denke genau."
    "Inspire teamwork." = "Inspiriere Teamarbeit."
    "Learn from adversity-and learn from defeat." = "Lerne aus Widrigkeiten und lerne aus Niederlagen."
    "Accept yourself and your worth." = "Akzeptiere dich selbst und deinen Wert."
    "Develop and maintain a positive attitude." = "Entwickle und pflege eine positive Einstellung."
    "Be creative." = "Sei kreativ."
    "Don't fear failure." = "Fürchte dich nicht vor dem Scheitern."
    "Live by positive values." = "Lebe nach positiven Werten."
    "Set goals." = "Setze dir Ziele."
    "Visualize your way to success." = "Visualisiere deinen Weg zum Erfolg."
    "Work hard at working with others." = "Arbeite hart daran, mit anderen zusammenzuarbeiten."
    "Do it now." = "Tu es jetzt."
}

function Replace-GermanPlaceholders {
    param (
        [string]$content
    )
    
    # Find all German placeholders
    $germanPattern = '<([a-z][a-z0-9]*)\s+class="lang-de">([^<]+)</\1>'
    $matches = [regex]::Matches($content, $germanPattern)
    
    foreach ($match in $matches) {
        $originalGerman = $match.Value
        $tag = $match.Groups[1].Value
        $text = $match.Groups[2].Value
        
        # Check if text exists in our translation dictionary
        if ($translations.ContainsKey($text)) {
            $germanText = $translations[$text]
            $replacement = "<$tag class=`"lang-de`">$germanText</$tag>"
            $content = $content -replace [regex]::Escape($originalGerman), $replacement
        }
    }
    
    return $content
}

# Get all HTML files
$htmlFiles = Get-ChildItem -Path . -Filter "*.html" -Exclude "stratton_manual.html"

foreach ($file in $htmlFiles) {
    Write-Host "Translating $($file.Name)..."
    
    # Read the file content
    $content = Get-Content -Path $file.FullName -Raw
    
    # Replace German placeholders with translations
    $updatedContent = Replace-GermanPlaceholders -content $content
    
    # Write the updated content back to the file
    Set-Content -Path $file.FullName -Value $updatedContent
    
    Write-Host "Translated $($file.Name) successfully."
}

Write-Host "All files have been translated where possible." 