
import connection from '../model/Connection.js';

document.addEventListener('DOMContentLoaded', async () => {
    const selector = document.getElementById('opcionEmpresa');

    try {
        // Pedimos la lista de empresas al Backend
        const respuesta = await connection.get('/empresas');
        const empresas = respuesta.data;
        selector.innerHTML = '<option value="" disabled selected>Selecciona una empresa...</option>';
        // Llenamos el menú con las empresas de la base de datos
        empresas.forEach(empresa => {
            const nuevaOpcion = document.createElement('option');
            nuevaOpcion.value = empresa.id_empresa; 
            nuevaOpcion.textContent = empresa.nombre; 
            selector.appendChild(nuevaOpcion);
        });

        console.log("Selector de empresas cargado correctamente.");
    } catch (error) {
        console.error("Error al cargar las empresas:", error);
        selector.innerHTML = '<option value="">Error al cargar empresas</option>';
    }
});

//Validacion contraseña de empresa
const formulario = document.querySelector('.formulario-registro-usuarios');

formulario.addEventListener('submit', async (e) => {
    e.preventDefault();

    //  Capturamos los valores de los inputs (Usando los IDs sugeridos)
    const idEmpresaSeleccionada = document.getElementById('opcionEmpresa').value;
    const nombre = document.getElementById('nombre-usuario').value;
    const correo = document.getElementById('email-usuario').value;
    const contrasenaIngresada = document.getElementById('contrasena-usuario').value;
    const confirmarContrasena = document.getElementById('confirmar-contrasena-usuario').value;

    if (!idEmpresaSeleccionada) {
        alert("Por favor, selecciona la empresa a la que perteneces.");
        return;
    }

    if (contrasenaIngresada !== confirmarContrasena) {
        alert("Las contraseñas no coinciden. Por favor verifícalas.");
        return;
    }
    const datosRegistro = {
        id_empresa: parseInt(idEmpresaSeleccionada), 
        nombre: nombre,
        correo: correo,
        contrasena: contrasenaIngresada 
    };

    try {
        // Enviamos la petición POST
        const respuesta = await connection.post('/usuarios', datosRegistro);
        alert("¡Registro exitoso! Te has vinculado correctamente.");
        formulario.reset(); 
        
    } catch (error) {
        const mensajeError = error.response?.data?.details || 
                             error.response?.data?.error || 
                             "No se pudo completar el registro.";
        
        alert("Error de validación: " + mensajeError);
    }
});