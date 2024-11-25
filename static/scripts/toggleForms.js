function toggleForms() {
    var loginForm = document.getElementById('loginForm');
    var registerForm = document.getElementById('registerForm');
    var loginLabel = document.getElementById('loginLabel');
    var signupLabel = document.getElementById('signupLabel');
    
    loginForm.classList.toggle('hidden');
    registerForm.classList.toggle('hidden');
    loginLabel.classList.toggle('hidden');
    signupLabel.classList.toggle('hidden');

    // Alterna o título da página
    if (document.title === "Login") {
        document.title = "Sign Up";
    } else {
        document.title = "Login";
    }
}

// Função para ler os parâmetros da URL
function getUrlParameter(name) {
    name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
    var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
    var results = regex.exec(location.search);
    return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
}

// Exibe o formulário de cadastro se o parâmetro action=signup estiver presente
window.onload = function() {
    if (getUrlParameter('action') === 'signup') {
        toggleForms(); // Alterna para o formulário de cadastro
    }
};
