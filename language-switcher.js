// Language switching functionality
function switchLanguage(lang) {
    document.documentElement.lang = lang;
    document.querySelectorAll('.language-btn').forEach(btn => {
        btn.classList.remove('active');
        if (btn.getAttribute('data-lang') === lang) {
            btn.classList.add('active');
        }
    });
    localStorage.setItem('preferred-language', lang);
}

document.addEventListener('DOMContentLoaded', function() {
    const savedLang = localStorage.getItem('preferred-language');
    if (savedLang) {
        switchLanguage(savedLang);
    }
    
    // Check if inside iframe and notify parent
    if (window.parent !== window) {
        window.parent.postMessage({ action: 'getLanguage' }, '*');
    }
});

// Listen for messages from the parent window
window.addEventListener('message', function(event) {
    if (event.data && event.data.action === 'switchLanguage') {
        switchLanguage(event.data.lang);
    }
}); 