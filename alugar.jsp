<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="conectar.jsp" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Alugar Espaço</title>
    <script>
        function updateForm() {
            var select = document.getElementById("espaco");
            var selectedOption = select.options[select.selectedIndex];
            var tamanho = selectedOption.getAttribute("data-tamanho");
            var preco = selectedOption.getAttribute("data-preco");

            document.getElementById("tamanho").value = tamanho;
            document.getElementById("precoPorDia").value = preco;
            calculateTotal();
        }

        function calculateTotal() {
            var precoPorDia = parseFloat(document.getElementById("precoPorDia").value);
            var dataInicio = new Date(document.getElementById("dataInicio").value);
            var dataFim = new Date(document.getElementById("dataFim").value);

            if (dataInicio && dataFim && !isNaN(precoPorDia)) {
                var diffTime = Math.abs(dataFim - dataInicio);
                var diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
                var total = diffDays * precoPorDia;
                document.getElementById("valorTotal").value = total.toFixed(2);
            }
        }
    </script>
</head>
<body>
    <header>
        <h1>Alugar Espaço</h1>
    </header>
    <main>
        <form id="alugarForm" method="post" action="processAluguel.jsp">
            <label for="espaco">Nome:</label>
            <select id="espaco" name="espaco" onchange="updateForm()" required>
                <option value="" disabled selected>Selecione um espaço</option>
                <%
                    Connection conn = (Connection) session.getAttribute("conn");
                    Statement stmt = (Statement) session.getAttribute("stmt");
                    ResultSet rs = null;

                    if (conn != null && stmt != null) {
                        try {
                            String query = "SELECT id, nome, tamanho, preco_por_dia FROM espacos";
                            rs = stmt.executeQuery(query);

                            while (rs.next()) {
                                int id = rs.getInt("id");
                                String nome = rs.getString("nome");
                                String tamanho = rs.getString("tamanho");
                                double precoPorDia = rs.getDouble("preco_por_dia");
                                out.println("<option value='" + id + "' data-tamanho='" + tamanho + "' data-preco='" + precoPorDia + "'>" + nome + "</option>");
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        } finally {
                            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                        }
                    } else {
                        out.println("<option disabled>Conexão com o banco de dados não estabelecida.</option>");
                    }
                %>
            </select>

            <label for="tamanho">Tamanho:</label>
            <input type="text" id="tamanho" name="tamanho" readonly>

            <label for="precoPorDia">Preço por Dia:</label>
            <input type="text" id="precoPorDia" name="precoPorDia" readonly>

            <label for="dataInicio">Data de Início:</label>
            <input type="date" id="dataInicio" name="dataInicio" onchange="calculateTotal()" required>

            <label for="dataFim">Data de Término:</label>
            <input type="date" id="dataFim" name="dataFim" onchange="calculateTotal()" required>

            <label for="valorTotal">Valor Total:</label>
            <input type="text" id="valorTotal" name="valorTotal" readonly>

            <button type="submit">Alugar</button>
        </form>
    </main>
</body>
</html>