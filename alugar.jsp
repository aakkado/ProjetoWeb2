<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="static/styles/alugar.css">
    <link rel="icon" href="./static/images/logo.png">
    <title>Alugar Espaço</title>
</head>
<body>
    <header>
        <h1>Alugar Espaço</h1>
    </header>
    <main>
        <form id="alugarForm" method="post">
            <label for="espaco">Espaço:</label>
            <select id="espaco" name="espaco" required>
                <%
                    // Database connection
                    String url = "jdbc:mysql://localhost:3306/naturezaViva";
                    String user = "root";
                    String password = "";
                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection(url, user, password);
                        stmt = conn.createStatement();
                        String query = "SELECT id, nome, preco_por_dia FROM espacos";
                        rs = stmt.executeQuery(query);

                        while (rs.next()) {
                            int id = rs.getInt("id");
                            String nome = rs.getString("nome");
                            double precoPorDia = rs.getDouble("preco_por_dia");
                            out.println("<option value='" + id + "' data-preco='" + precoPorDia + "'>" + nome + "</option>");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                %>
            </select>

            <label for="dataInicio">Data de Início:</label>
            <input type="date" id="dataInicio" name="dataInicio" required>

            <label for="dataFim">Data de Término:</label>
            <input type="date" id="dataFim" name="dataFim" required>

            <p id="precoTotal">Preço Total: R$0,00</p>

            <button type="submit">Alugar</button>
        </form>
    </main>
    <script>
        document.getElementById('alugarForm').addEventListener('submit', function(event) {
            event.preventDefault();
            const espaco = document.getElementById('espaco');
            const dataInicio = document.getElementById('dataInicio').value;
            const dataFim = document.getElementById('dataFim').value;
            const precoPorDia = espaco.options[espaco.selectedIndex].getAttribute('data-preco');

            if (new Date(dataInicio) > new Date(dataFim)) {
                alert('Data de Início deve ser anterior à Data de Término.');
                return;
            }

            const diffTime = Math.abs(new Date(dataFim) - new Date(dataInicio));
            const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24)) + 1;
            const precoTotal = diffDays * precoPorDia;

            document.getElementById('precoTotal').innerText = 'Preço Total: R$' + precoTotal.toFixed(2);

            // Here you can add AJAX call to validate availability and submit the form
        });
    </script>
</body>
</html>