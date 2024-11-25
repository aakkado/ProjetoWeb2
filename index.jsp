<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
                <li><a href="./login.jsp?action=signup">Registrar</a></li>
            </ul>
        </nav>
    </header>
    <main>
        <section>
            <h1>Alugue um espaço para a sua festa e ajude a natureza</h1>
            <p>Alugue um espaço para a sua festa e ajude a natureza</p>
            <a href="./login.jsp">Alugar</a>
        </section>
        <section>
            <div class="slideshow-container">

                <!-- Full-width images with number and caption text -->
                <div class="mySlides fade">
                  <img src="./static/images/espacos/espaco1.jpg" style="width:70%">
                </div>
              
                <div class="mySlides fade">
                  <img src="./static/images/espacos/espaco2.jpg" style="width:70%">
                </div>
              
                <div class="mySlides fade">
                  <img src="./static/images/espacos/espaco3.webp" style="width:70%">
                </div>

                <div class="mySlides fade">
                    <img src="./static/images/espacos/espaco4.avif" style="width:70%">
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
    <script src="./static/scripts/slider.js"></script>
</body>
</html>