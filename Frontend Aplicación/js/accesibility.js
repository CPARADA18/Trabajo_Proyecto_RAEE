(() => {
    const btnAumentar = document.querySelector("#aumentarFuente");
    const btnDisminuir = document.querySelector("#disminuirFuente");
    const btnContraste = document.querySelector("#contraste");

    let tamañoBaseRem = 1; // Tamaño base de la fuente en rem (1rem = 16px por defecto)
    let contrasteActivo = false;

    // Función para aplicar el tamaño de fuente a la raíz del documento (elemento html)
    const aplicarTamañoFuente = () => {
        document.documentElement.style.fontSize = `${tamañoBaseRem}rem`;
    };

    // Aplicar el tamaño de fuente inicial al cargar la página
    aplicarTamañoFuente();

    if (btnAumentar && btnDisminuir && btnContraste) {
        btnAumentar.addEventListener("click", () => {
            if (tamañoBaseRem < 1.5) { // Límite superior para el aumento 
                tamañoBaseRem += 0.1; // Aumento
                aplicarTamañoFuente();
            }
        });

        btnDisminuir.addEventListener("click", () => {
            if (tamañoBaseRem > 0.7) { // Límite inferior para la disminución 
                tamañoBaseRem -= 0.1; // Disminución
                aplicarTamañoFuente();
            }
        });

        btnContraste.addEventListener("click", () => {
            contrasteActivo = !contrasteActivo;
            document.body.classList.toggle("modo-contraste", contrasteActivo);
        });
    }
})();
