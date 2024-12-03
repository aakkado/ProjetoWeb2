function toggleForms() {
    if (document.title === "Login") {
        // Redireciona para a página de registro
        window.location.href = 'cadastro.jsp?action=signup';
    } else {
        // Redireciona para a página de login
        window.location.href = 'login.jsp?action=login';
    }
}

// Função para obter parâmetros da URL
function getUrlParameter(name) {
    name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
    var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
    var results = regex.exec(location.search);
    return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
}

// Executa uma ação específica quando a página é carregada, dependendo da URL
window.onload = function() {
    if (getUrlParameter('action') === 'signup') {
        document.title = "Sign Up";
        document.getElementById('loginForm').classList.add('hidden');
        document.getElementById('registerForm').classList.remove('hidden');
        document.getElementById('loginLabel').classList.add('hidden');
        document.getElementById('signupLabel').classList.remove('hidden');
    }
};
