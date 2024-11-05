<%-- Home page da aplicação para aluguel de espaços para a ong natureza viva --%>
<%-- A aplicação deverá ser responsível e contar com acessibilidade --%>
<%-- Inserir a logo (./static/images/logo.png) no icone da página e posicionalo no header e colocar opções de acessibilidade (ex: alt) --%>
<%-- O arquivo de estilo encontra-se em ./static/styles/home.css --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
    <link rel="stylesheet" href="./static/styles/home.css">
    <link rel="icon" href="./static/images/logo.png">
</head>
<body>
    <header>
        <img src="./static/images/logoWithoutBackground.png" alt="Logo da ONG Natureza Viva. Um conjunto de três folhas com a legenda: ONG Natureza Viva">
        <nav>
            <ul>
                <li><a href="./login.jsp">Login</a></li>
                <li><a href="./register.jsp">Registrar</a></li>
            </ul>
        </nav>
    </header>
    <main>
        <section>
            <h1>Alugue um espaço para a sua festa e ajude a natureza</h1>
            <p>Alugue um espaço para a sua festa e ajude a natureza</p>
            <a href="./login.jsp">Alugar</a>
        </section>
        <%-- Image carousel (slider) de imagens de exemplo de espaços (espaco1.jpg, espaco2.jpg, espaco3.webp, espaco4.avif) --%>
        <%-- para fazer o slider funcionar é preciso de js? --%>
        <script src="./static/scripts/slider.js"></script>
        <section>
            <div class="slideshow-container">

                <!-- Full-width images with number and caption text -->
                <div class="mySlides fade">
                  <div class="numbertext">1 / 4</div>
                  <img src="./static/images/espacos/espaco1.jpg" style="width:70%">
                  <div class="text">Caption Text</div>
                </div>
              
                <div class="mySlides fade">
                  <div class="numbertext">2 / 4</div>
                  <img src="./static/images/espacos/espaco2.jpg" style="width:70%">
                  <div class="text">Caption Two</div>
                </div>
              
                <div class="mySlides fade">
                  <div class="numbertext">3 / 4</div>
                  <img src="./static/images/espacos/espaco3.webp" style="width:70%">
                  <div class="text">Caption Three</div>
                </div>

                <div class="mySlides fade">
                    <div class="numbertext">4 / 4</div>
                    <img src="./static/images/espacos/espaco4.avif" style="width:70%">
                    <div class="text">Caption Three</div>
                  </div>
              
                <!-- Next and previous buttons -->
                <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
                <a class="next" onclick="plusSlides(1)">&#10095;</a>
              </div>
              <br>
              
              <!-- The dots/circles -->
              <div style="text-align:center">
                <span class="dot" onclick="currentSlide(1)"></span>
                <span class="dot" onclick="currentSlide(2)"></span>
                <span class="dot" onclick="currentSlide(3)"></span>
                <span class="dot" onclick="currentSlide(4)"></span>
              </div>
        </section>
    </main>
    <footer>
        <p>ONG Natureza Viva</p>
    </footer>
</body>
</html>