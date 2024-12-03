function toggleForms() {
    if (document.title === "Login") {
        window.location.href = 'register.jsp?action=signup';
    } else {
        window.location.href = 'login.jsp?action=login';
    }
}

function getUrlParameter(name) {
    name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
    var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
    var results = regex.exec(location.search);
    return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
}

window.onload = function() {
    if (getUrlParameter('action') === 'signup') {
        document.title = "Sign Up";
        document.getElementById('loginForm').classList.add('hidden');
        document.getElementById('registerForm').classList.remove('hidden');
        document.getElementById('loginLabel').classList.add('hidden');
        document.getElementById('signupLabel').classList.remove('hidden');
    }
};
