<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Cadastro de Espaços</title>
    <link rel="stylesheet" href="static/styles/cadastro.css">
    <link rel="icon" href="./static/images/logo.png">
</head>
<body>
    <header>
        <img src="static/images/logoWithoutBackground.png" alt="Logo da ONG Natureza Viva">
    </header>
    <main>
        <h1>Cadastro de Espaços para Aluguel</h1>
        <form id="registerSpaceForm" action="registerSpace.jsp" method="post">
            <div>
                <label for="spaceName">Nome do Espaço:</label>
                <input type="text" id="spaceName" name="spaceName" placeholder="Nome do espaço" required aria-required="true">
            </div>
            <div>
                <label for="rentalValue">Valor do Aluguel (por período):</label>
                <input type="number" id="rentalValue" name="rentalValue" placeholder="Valor do aluguel" required aria-required="true">
            </div>
            <div>
                <label for="location">Local:</label>
                <input type="text" id="location" name="location" placeholder="Local do espaço" required aria-required="true">
            </div>
            <div>
                <label for="size">Tamanho:</label>
                <input type="text" id="size" name="size" placeholder="Tamanho do espaço" required aria-required="true">
            </div>
            <button type="submit">Cadastrar Espaço</button>
        </form>
    </main>
    <footer>
        <p>ONG Natureza Viva</p>
    </footer>
</body>
</html>