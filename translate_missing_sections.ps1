# PowerShell script to translate missing sections

function Apply-SectionTranslations {
    param (
        [string]$filePath,
        [hashtable]$translations
    )
    
    Write-Host "Processing $filePath..."
    
    # Read the file content
    $content = Get-Content -Path $filePath -Raw
    
    # Apply each translation
    foreach ($key in $translations.Keys) {
        $englishText = $key
        $germanText = $translations[$key]
        
        # Replace the content
        $content = $content -replace [regex]::Escape($englishText), $germanText
    }
    
    # Write the updated content back to the file
    Set-Content -Path $filePath -Value $content
    
    Write-Host "Successfully translated $filePath"
}

# Add translations for section3_sales_techniques.html
$section3Translations = @{
    # Headings and navigation
    "<h1 class=`"lang-de`">Stratton Oakmont Sales Training Manual</h1>" = "<h1 class=`"lang-de`">Stratton Oakmont Schulungshandbuch für Vertrieb</h1>"
    "<p class=`"lang-de`">Sales Techniques</p>" = "<p class=`"lang-de`">Verkaufstechniken</p>"
    "<a href=`"section2_selling_power.html`" class=`"lang-de`">← Back to Selling Power</a>" = "<a href=`"section2_selling_power.html`" class=`"lang-de`">← Zurück zu Verkaufskraft</a>"
    "<a href=`"section4_best_practices.html`" class=`"lang-de`">Next: Best Practices →</a>" = "<a href=`"section4_best_practices.html`" class=`"lang-de`">Weiter: Bewährte Methoden →</a>"
    
    # Section titles
    "<h2 class=`"lang-de`">Effective Sales Communication</h2>" = "<h2 class=`"lang-de`">Effektive Verkaufskommunikation</h2>"
    "<h2 class=`"lang-de`">Building Rapport</h2>" = "<h2 class=`"lang-de`">Vertrauensaufbau</h2>"
    "<h2 class=`"lang-de`">Understanding Customer Psychology</h2>" = "<h2 class=`"lang-de`">Kundenpsychologie verstehen</h2>"
    "<h2 class=`"lang-de`">Handling Objections</h2>" = "<h2 class=`"lang-de`">Umgang mit Einwänden</h2>"
    "<h2 class=`"lang-de`">Closing Techniques</h2>" = "<h2 class=`"lang-de`">Abschlusstechniken</h2>"
    
    # Footer
    "<div class=`"disclaimer lang-de`">FOR TRAINING PURPOSES ONLY</div>" = "<div class=`"disclaimer lang-de`">NUR FÜR SCHULUNGSZWECKE</div>"
}

# Add translations for section4_best_practices.html
$section4Translations = @{
    # Headings and navigation
    "<h1 class=`"lang-de`">Stratton Oakmont Sales Training Manual</h1>" = "<h1 class=`"lang-de`">Stratton Oakmont Schulungshandbuch für Vertrieb</h1>"
    "<p class=`"lang-de`">Best Practices</p>" = "<p class=`"lang-de`">Bewährte Methoden</p>"
    "<a href=`"section3_sales_techniques.html`" class=`"lang-de`">← Back to Sales Techniques</a>" = "<a href=`"section3_sales_techniques.html`" class=`"lang-de`">← Zurück zu Verkaufstechniken</a>"
    "<a href=`"section5_special_situations.html`" class=`"lang-de`">Next: Special Situations →</a>" = "<a href=`"section5_special_situations.html`" class=`"lang-de`">Weiter: Besondere Situationen →</a>"
    
    # Section titles
    "<h2 class=`"lang-de`">Daily Routine for Success</h2>" = "<h2 class=`"lang-de`">Tägliche Routine für Erfolg</h2>"
    "<h2 class=`"lang-de`">Follow-up Systems</h2>" = "<h2 class=`"lang-de`">Nachverfolgungssysteme</h2>"
    "<h2 class=`"lang-de`">Documentation Practices</h2>" = "<h2 class=`"lang-de`">Dokumentationspraktiken</h2>"
    "<h2 class=`"lang-de`">Time Management</h2>" = "<h2 class=`"lang-de`">Zeitmanagement</h2>"
    
    # Footer
    "<div class=`"disclaimer lang-de`">FOR TRAINING PURPOSES ONLY</div>" = "<div class=`"disclaimer lang-de`">NUR FÜR SCHULUNGSZWECKE</div>"
}

# Add translations for section5_special_situations.html
$section5Translations = @{
    # Headings and navigation
    "<h1 class=`"lang-de`">Stratton Oakmont Sales Training Manual</h1>" = "<h1 class=`"lang-de`">Stratton Oakmont Schulungshandbuch für Vertrieb</h1>"
    "<p class=`"lang-de`">Special Situations</p>" = "<p class=`"lang-de`">Besondere Situationen</p>"
    "<a href=`"section4_best_practices.html`" class=`"lang-de`">← Back to Best Practices</a>" = "<a href=`"section4_best_practices.html`" class=`"lang-de`">← Zurück zu Bewährte Methoden</a>"
    "<a href=`"section6_special_handling.html`" class=`"lang-de`">Next: Special Handling Situations →</a>" = "<a href=`"section6_special_handling.html`" class=`"lang-de`">Weiter: Besondere Handhabungssituationen →</a>"
    
    # Section titles
    "<h2 class=`"lang-de`">Dealing with Difficult Clients</h2>" = "<h2 class=`"lang-de`">Umgang mit schwierigen Kunden</h2>"
    "<h2 class=`"lang-de`">High-Net-Worth Individuals</h2>" = "<h2 class=`"lang-de`">Vermögende Privatpersonen</h2>"
    
    # Footer
    "<div class=`"disclaimer lang-de`">FOR TRAINING PURPOSES ONLY</div>" = "<div class=`"disclaimer lang-de`">NUR FÜR SCHULUNGSZWECKE</div>"
}

# Add translations for section6_special_handling.html
$section6Translations = @{
    # Headings and navigation
    "<h1 class=`"lang-de`">Stratton Oakmont Sales Training Manual</h1>" = "<h1 class=`"lang-de`">Stratton Oakmont Schulungshandbuch für Vertrieb</h1>"
    "<p class=`"lang-de`">Special Handling Situations</p>" = "<p class=`"lang-de`">Besondere Handhabungssituationen</p>"
    "<a href=`"section5_special_situations.html`" class=`"lang-de`">← Back to Special Situations</a>" = "<a href=`"section5_special_situations.html`" class=`"lang-de`">← Zurück zu Besondere Situationen</a>"
    "<a href=`"section7_motivation.html`" class=`"lang-de`">Next: Motivation and Mindset →</a>" = "<a href=`"section7_motivation.html`" class=`"lang-de`">Weiter: Motivation und Denkweise →</a>"
    
    # Section titles
    "<h2 class=`"lang-de`">Handling Complicated Orders</h2>" = "<h2 class=`"lang-de`">Umgang mit komplizierten Aufträgen</h2>"
    "<h2 class=`"lang-de`">Customer Complaint Resolution</h2>" = "<h2 class=`"lang-de`">Lösung von Kundenbeschwerden</h2>"
    "<h2 class=`"lang-de`">Regulatory Considerations</h2>" = "<h2 class=`"lang-de`">Regulatorische Überlegungen</h2>"
    
    # Footer
    "<div class=`"disclaimer lang-de`">FOR TRAINING PURPOSES ONLY</div>" = "<div class=`"disclaimer lang-de`">NUR FÜR SCHULUNGSZWECKE</div>"
}

# Add translations for section8_phone_skills.html
$section8Translations = @{
    # Headings and navigation
    "<h1 class=`"lang-de`">Stratton Oakmont Sales Training Manual</h1>" = "<h1 class=`"lang-de`">Stratton Oakmont Schulungshandbuch für Vertrieb</h1>"
    "<p class=`"lang-de`">Phone Skills</p>" = "<p class=`"lang-de`">Telefonkompetenzen</p>"
    "<a href=`"section7_motivation.html`" class=`"lang-de`">← Back to Motivation and Mindset</a>" = "<a href=`"section7_motivation.html`" class=`"lang-de`">← Zurück zu Motivation und Denkweise</a>"
    "<a href=`"section9_resources.html`" class=`"lang-de`">Next: Resources →</a>" = "<a href=`"section9_resources.html`" class=`"lang-de`">Weiter: Ressourcen →</a>"
    
    # Section titles
    "<h2 class=`"lang-de`">Effective Cold Calling</h2>" = "<h2 class=`"lang-de`">Effektive Kaltakquise</h2>"
    "<h2 class=`"lang-de`">The Art of Voice Control</h2>" = "<h2 class=`"lang-de`">Die Kunst der Stimmkontrolle</h2>"
    "<h2 class=`"lang-de`">Qualifying Leads Over the Phone</h2>" = "<h2 class=`"lang-de`">Qualifizierung von Leads am Telefon</h2>"
    
    # Footer
    "<div class=`"disclaimer lang-de`">FOR TRAINING PURPOSES ONLY</div>" = "<div class=`"disclaimer lang-de`">NUR FÜR SCHULUNGSZWECKE</div>"
}

# Add translations for section9_resources.html
$section9Translations = @{
    # Headings and navigation
    "<h1 class=`"lang-de`">Stratton Oakmont Sales Training Manual</h1>" = "<h1 class=`"lang-de`">Stratton Oakmont Schulungshandbuch für Vertrieb</h1>"
    "<p class=`"lang-de`">Resources</p>" = "<p class=`"lang-de`">Ressourcen</p>"
    "<a href=`"section8_phone_skills.html`" class=`"lang-de`">← Back to Phone Skills</a>" = "<a href=`"section8_phone_skills.html`" class=`"lang-de`">← Zurück zu Telefonkompetenzen</a>"
    "<a href=`"index.html`" class=`"lang-de`">Back to Home →</a>" = "<a href=`"index.html`" class=`"lang-de`">Zurück zur Startseite →</a>"
    
    # Section titles
    "<h2 class=`"lang-de`">Recommended Reading</h2>" = "<h2 class=`"lang-de`">Empfohlene Lektüre</h2>"
    "<h2 class=`"lang-de`">Sales Scripts and Templates</h2>" = "<h2 class=`"lang-de`">Verkaufsskripte und Vorlagen</h2>"
    "<h2 class=`"lang-de`">Industry Glossary</h2>" = "<h2 class=`"lang-de`">Branchenglossar</h2>"
    
    # Footer
    "<div class=`"disclaimer lang-de`">FOR TRAINING PURPOSES ONLY</div>" = "<div class=`"disclaimer lang-de`">NUR FÜR SCHULUNGSZWECKE</div>"
}

# Apply translations to files
if (Test-Path "section3_sales_techniques.html") {
    Apply-SectionTranslations -filePath "section3_sales_techniques.html" -translations $section3Translations
}

if (Test-Path "section4_best_practices.html") {
    Apply-SectionTranslations -filePath "section4_best_practices.html" -translations $section4Translations
}

if (Test-Path "section5_special_situations.html") {
    Apply-SectionTranslations -filePath "section5_special_situations.html" -translations $section5Translations
}

if (Test-Path "section6_special_handling.html") {
    Apply-SectionTranslations -filePath "section6_special_handling.html" -translations $section6Translations
}

if (Test-Path "section8_phone_skills.html") {
    Apply-SectionTranslations -filePath "section8_phone_skills.html" -translations $section8Translations
}

if (Test-Path "section9_resources.html") {
    Apply-SectionTranslations -filePath "section9_resources.html" -translations $section9Translations
}

Write-Host "All missing translations have been applied." 