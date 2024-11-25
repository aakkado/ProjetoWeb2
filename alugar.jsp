<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alugar Espaço</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <header>
        <h1>Alugar Espaço</h1>
    </header>
    <main>
        <form id="alugarForm">
            <label for="espaco">Espaço:</label>
            <select id="espaco" name="espaco" required>
                <!-- Opções de espaços -->
            </select>

            <label for="dataInicio">Data de Início:</label>
            <input type="date" id="dataInicio" name="dataInicio" required>

            <label for="dataFim">Data de Término:</label>
            <input type="date" id="dataFim" name="dataFim" required>

            <p id="precoTotal">Preço Total: R$0,00</p>

            <button type="submit">Alugar</button>
        </form>
    </main>
    <script src="script.js"></script>
</body>
</html>