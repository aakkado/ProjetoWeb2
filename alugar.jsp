<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.StringWriter, java.io.PrintWriter" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Realizar Aluguel</title>
    <link rel="stylesheet" href="static/styles/alugar.css">
    <link rel="icon" href="./static/images/logo.png">
    <script>
        function hideMessage() {
            const messageElement = document.getElementById("message");
            if (messageElement) {
                messageElement.style.opacity = '1';
                setTimeout(() => {
                    messageElement.style.opacity = '0';
                }, 2000);
                setTimeout(() => {
                    messageElement.style.display = 'none';
                }, 3000);
            }
        }

        function updateDetails() {
            const espacoSelect = document.getElementById("espacoId");
            const selectedOption = espacoSelect.options[espacoSelect.selectedIndex];
            const valorDiario = selectedOption.getAttribute("data-valor");
            const local = selectedOption.getAttribute("data-local");
            const tamanho = selectedOption.getAttribute("data-tamanho");
            document.getElementById("local").value = local || "";
            document.getElementById("tamanho").value = tamanho || "";
            document.getElementById("valorDiario").value = valorDiario || "";
            calculateFinalValue();
        }

        function calculateFinalValue() {
            // Recuperar e converter o valor diário para número
            const valorDiario = parseFloat(document.getElementById("valorDiario").value.trim()) || 0;
            const inicioStr = document.getElementById("periodoInicio").value;
            const fimStr = document.getElementById("periodoFim").value;

            if (inicioStr && fimStr) {
                const inicio = new Date(inicioStr);
                const fim = new Date(fimStr);

                if (fim > inicio) {
                    const diffTime = fim - inicio; // Diferença em milissegundos
                    const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24)); // Converter para dias

                    const valorFinal = valorDiario * diffDays;

                    // Atualizar os campos de saída
                    document.getElementById("valorFinal").value = `R$ ${valorFinal.toFixed(2)}`;
                    document.getElementById("calculatedValue").value = valorFinal.toFixed(2);
                } else {
                    document.getElementById("valorFinal").value = "Período inválido";
                    document.getElementById("calculatedValue").value = "";
                }
            } else {
                document.getElementById("valorFinal").value = "Preencha os campos de data";
                document.getElementById("calculatedValue").value = "";
            }
        }


    </script>
</head>
<body onload="hideMessage()">
    <header>
        <button id="logoutButton" onclick="window.location.href='logout.jsp'">Logout</button>
        <img src="static/images/logoWithoutBackground.png" alt="Logo da ONG Natureza Viva">
    </header>
    <main>
        <h1>Realizar Aluguel</h1>

        <form id="rentalForm" action="alugar.jsp" method="post">
            <div>
                <label for="espacoId">Espaço:</label>
                <select id="espacoId" name="espacoId" required aria-required="true" onchange="updateDetails()">
                    <option value="">Selecione um espaço</option>
                    <%@ include file="conectar.jsp" %>
                    <%
                        PreparedStatement pst = null;
                        ResultSet rs = null;
                        try {
                            String query = 
                                "SELECT e.espaco_id, e.nome_espaco, e.valor_aluguel, e.local, e.tamanho " +
                                "FROM espacos e " +
                                "LEFT JOIN alugueis a ON e.espaco_id = a.espaco_id " +
                                "WHERE a.espaco_id IS NULL";
                            pst = con.prepareStatement(query);
                            rs = pst.executeQuery();
                            while (rs.next()) {
                                int espacoId = rs.getInt("espaco_id");
                                String nomeEspaco = rs.getString("nome_espaco");
                                double valorAluguel = rs.getDouble("valor_aluguel");
                                String local = rs.getString("local");
                                String tamanho = rs.getString("tamanho");
                                out.println("<option value='" + espacoId + "' " +
                                    "data-valor='" + valorAluguel + "' " +
                                    "data-local='" + local + "' " +
                                    "data-tamanho='" + tamanho + "'>" +
                                    nomeEspaco + "</option>");
                            }
                        } catch (Exception e) {
                            out.println("Erro ao buscar espaços: " + e.getMessage() + "<br>");
                        } finally {
                            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                            if (pst != null) try { pst.close(); } catch (SQLException ignore) {}
                        }
                    %>
                </select>
            </div>
            <div>
                <label for="local">Local:</label>
                <input type="text" id="local" readonly>
            </div>
            <div>
                <label for="tamanho">Tamanho:</label>
                <input type="text" id="tamanho" readonly>
            </div>
            <div>
                <label for="valorDiario">Valor Diário:</label>
                <input type="number" id="valorDiario" readonly>
            </div>
            <div>
                <label for="periodoInicio">Período de Início:</label>
                <input type="datetime-local" id="periodoInicio" name="periodoInicio" required aria-required="true" onchange="calculateFinalValue()" oninput="calculateFinalValue()">
            </div>
            <div>
                <label for="periodoFim">Período de Fim:</label>
                <input type="datetime-local" id="periodoFim" name="periodoFim" required aria-required="true" onchange="calculateFinalValue()" oninput="calculateFinalValue()">
            </div>
            <div>
                <label for="valorFinal">Valor Final:</label>
                <input type="text" id="valorFinal" readonly>
            </div>
            <div>
                <label for="metodoPagamento">Método de Pagamento:</label>
                <select id="metodoPagamento" name="metodoPagamento" required aria-required="true">
                    <option value="Cartão de Crédito">Cartão de Crédito</option>
                    <option value="Boleto Bancário">Boleto Bancário</option>
                    <option value="Transferência Bancária">Transferência Bancária</option>
                </select>
            </div>
            <button type="submit">Confirmar Aluguel</button>
            <input type="hidden" id="calculatedValue" name="valorFinal">
            <a href="./alugel.jsp">Ver Alugueis</a>
        </form>
        <%
            String message = "";
            boolean isSubmitted = "POST".equalsIgnoreCase(request.getMethod());
            if (isSubmitted) {
                String espacoId = request.getParameter("espacoId");
                String periodoInicio = request.getParameter("periodoInicio");
                String periodoFim = request.getParameter("periodoFim");
                String metodoPagamento = request.getParameter("metodoPagamento");
                String valorFinal = request.getParameter("valorFinal");
                int usuarioId = (Integer) session.getAttribute("usuario_id");
                if (espacoId != null && periodoInicio != null && periodoFim != null && metodoPagamento != null) {
                    PreparedStatement pstInsert = null;
                    try {
                        String queryInsert = 
                            "INSERT INTO alugueis (usuario_id, espaco_id, valor_final, metodo_pagamento, periodo_inicio, periodo_fim) " +
                            "VALUES (?, ?, ?, ?, ?, ?)";
                        pstInsert = con.prepareStatement(queryInsert);
                        pstInsert.setInt(1, usuarioId);
                        pstInsert.setInt(2, Integer.parseInt(espacoId));
                        pstInsert.setDouble(3, Double.parseDouble(valorFinal));
                        pstInsert.setString(4, metodoPagamento);
                        pstInsert.setString(5, periodoInicio);
                        pstInsert.setString(6, periodoFim);
                        int result = pstInsert.executeUpdate();
                        message = result > 0 ? "Aluguel realizado com sucesso!" : "Erro ao realizar aluguel.";
                    } catch (Exception e) {
                        message = "Erro: " + e.getMessage();
                    } finally {
                        if (pstInsert != null) try { pstInsert.close(); } catch (SQLException ignore) {}
                    }
                } else {
                    message = "Preencha todos os campos!";
                }
            }
        %>
        <div id="message" class="<%= message.isEmpty() ? "" : "show" %>">
            <%= message %>
        </div>
    </main>
</body>
</html>
