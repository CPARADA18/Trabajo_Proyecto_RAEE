import connection from '../model/Connection.js';

const formulario = document.querySelector('.formulario-registro-artefactos');

formulario.addEventListener('submit', async (e) => {
    e.preventDefault();

    const botonPresionado = e.submitter;
    
    if (botonPresionado.classList.contains('boton-enviar')) {
        await registrarArtefacto();
    } else if (botonPresionado.classList.contains('boton-Certificado')) {
        alert("La generación de certificados estará disponible próximamente.");
    }
});

async function registrarArtefacto() {
    const usuarioString = localStorage.getItem('usuario');
    
    if (!usuarioString) {
        alert("Tu sesión ha expirado. Por favor, vuelve a ingresar.");
        window.location.href = "Ingreso-Clientes.html";
        return;
    }

    const usuario = JSON.parse(usuarioString);

    // Captura de datos 
    const datos = {
        tipo: document.getElementById('tipo').value.trim(),
        peso: parseFloat(document.getElementById('peso').value),
        categoria: document.getElementById('opciones').options[document.getElementById('opciones').selectedIndex].text,
        estado: document.getElementById('estado').value.trim(),
        id_empresa: parseInt(usuario.id_empresa) 
    };

    if (isNaN(datos.peso)) {
        alert("Por favor, ingresa un peso válido.");
        return;
    }

    console.log("Intentando registrar en la DB:", datos);

    try {
        // Enviamos la petición POST al backend
        const respuesta = await connection.post('/artefactos', datos);

        if (respuesta.status === 201 || respuesta.status === 200) {
            alert("¡Artefacto registrado exitosamente en la base de datos!");
            formulario.reset(); 
        }
    } catch (error) {
        console.error("Error al registrar:", error);
        
        const mensajeDetallado = error.response?.data?.details || error.response?.data?.error || "Error de conexión";
        
        alert("No se pudo registrar: " + mensajeDetallado);
    }
}