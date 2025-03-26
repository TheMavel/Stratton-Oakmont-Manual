# PowerShell script to apply detailed translations from JSON file

# Load the JSON file
$translationsJson = Get-Content -Path "section_translations.json" -Raw | ConvertFrom-Json

# Function to apply translations to a file
function Apply-DetailedTranslations {
    param (
        [string]$filePath,
        [string]$sectionKey
    )
    
    # Get the translations for this section
    $translations = $translationsJson.$sectionKey
    
    if ($null -eq $translations) {
        Write-Host "No translations found for $sectionKey"
        return
    }
    
    # Read the file content
    $content = Get-Content -Path $filePath -Raw
    
    # Apply each translation
    foreach ($key in $translations.PSObject.Properties.Name) {
        $englishText = $key
        $germanText = $translations.$key
        
        # Find the English version and create a pattern to match it
        $pattern = "<p class=`"lang-en`">$([regex]::Escape($englishText))</p>\s*<p class=`"lang-de`">$([regex]::Escape($englishText))</p>"
        
        # Replace with proper translation
        $replacement = "<p class=`"lang-en`">$englishText</p>`r`n        <p class=`"lang-de`">$germanText</p>"
        
        # Apply the replacement
        $content = $content -replace $pattern, $replacement
    }
    
    # Write the updated content back to the file
    Set-Content -Path $filePath -Value $content
    
    Write-Host "Applied detailed translations to $filePath"
}

# Apply translations to specific files
Write-Host "Applying detailed translations..."

Apply-DetailedTranslations -filePath "section1_self_improvement.html" -sectionKey "section1_translations"
Apply-DetailedTranslations -filePath "section2_selling_power.html" -sectionKey "section2_translations"
Apply-DetailedTranslations -filePath "section7_motivation.html" -sectionKey "section7_translations"

Write-Host "Detailed translations applied successfully." 