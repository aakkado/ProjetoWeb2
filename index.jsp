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
                    <img src="./static/images/espacos/espaco1.jpg" style="width:70%" alt="Espaço amplo de salão decorado para um evento formal. Há várias mesas redondas cobertas com toalhas brancas, dispostas com louças, copos e arranjos florais em tons de rosa e branco no centro. Cadeiras elegantes cercam as mesas e velas decorativas estão dispostas em candelabros. O ambiente possui janelas grandes que permitem a entrada de luz natural, com paredes claras e iluminação suave, transmitindo elegância e sofisticação.">
                </div>
                
                <div class="mySlides fade">
                    <img src="./static/images/espacos/espaco2.jpg" style="width:70%" alt="Salão de beleza moderno e iluminado. O espaço possui cadeiras giratórias em tons neutros dispostas em frente a espelhos grandes, com bancadas de madeira clara equipadas com produtos de beleza. O chão é de madeira polida, refletindo a luz natural que entra pelas janelas amplas. Há plantas decorativas em vasos e iluminação moderna no teto, criando um ambiente limpo, organizado e convidativo.">
                </div>
                
                <div class="mySlides fade">
                    <img src="./static/images/espacos/espaco3.webp" style="width:70%" alt="Espaço aberto e minimalista com decoração em tons claros e estilo moderno. O ambiente possui mesas de madeira com cadeiras brancas dobráveis organizadas para pequenos grupos. Ao fundo, há uma área de cozinha com prateleiras de madeira, pendentes decorativos de palha e plantas em vasos. O chão de cimento e as paredes brancas são destacados pela entrada de luz natural, transmitindo um estilo simples, funcional e acolhedor.">
                </div>
                
                <div class="mySlides fade">
                    <img src="./static/images/espacos/espaco4.avif" style="width:70%" alt="Espaço contemporâneo com mesas de madeira clara e cadeiras simples organizadas em fileiras, sugerindo um ambiente de café ou coworking. Há iluminação aconchegante com lâmpadas suspensas e janelas amplas que deixam o ambiente bem iluminado. Prateleiras com vasos de plantas e decoração minimalista em tons neutros complementam o espaço moderno e acolhedor.">
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