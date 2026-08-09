
(function () {
    //  Obtenemos los datos del usuario desde el almacenamiento local
    const usuarioLocalStorage = localStorage.getItem('usuario');
    const correoAdminAutorizado = "info@servicioandino.com";

    // Verificamos si existe un usuario logueado
    if (!usuarioLocalStorage) {
        alert("Acceso denegado: Debes iniciar sesión primero.");
        window.location.href = "Ingreso-Clientes.html";
        return; 
    }

    try {
        const usuario = JSON.parse(usuarioLocalStorage);

       //Comparación y autorización de ususario
        if (usuario.correo.toLowerCase() !== correoAdminAutorizado.toLowerCase()) {
            alert("Acceso Restringido: Solo el administrador del Centro Andino puede ver las recepciones.");
            window.location.href = "../index.html"; 
        }
        
        console.log("Acceso administrativo concedido para:", usuario.correo);

    } catch (error) {
        console.error("Error en la validación de seguridad:", error);
        localStorage.clear();
        window.location.href = "Ingreso-Clientes.html";
    }
})();