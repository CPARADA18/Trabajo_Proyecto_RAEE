import connection from '../model/Connection.js';


document.addEventListener('DOMContentLoaded', async () => {
    const selector = document.getElementById('opcionEmpresa');
    
    try {
        // Obtenemos la lista de empresas para el selector
        const respuesta = await connection.get('/empresas');
        
        selector.innerHTML = '<option value="" disabled selected>Selecciona tu empresa...</option>';
        
        if (respuesta.data && respuesta.data.length > 0) {
            respuesta.data.forEach(empresa => {
                const op = document.createElement('option');
                op.value = empresa.id_empresa; 
                op.textContent = empresa.nombre;
                selector.appendChild(op);
            });
        }
    } catch (error) {
        console.error("Error cargando empresas:", error);
    }
});

// Envio de formulairo
document.addEventListener('submit', async (e) => {
    e.preventDefault(); 
    
    // Capturamos los valores de los inputs
    const id_empresa = document.getElementById('opcionEmpresa').value;
    const correo = document.getElementById('usuario').value.trim();
    const contrasena_empresa = document.getElementById('contraseña').value.trim();
    
    // Login de administradir
    const correoAdmin = "info@servicioandino.com";
    const passAdmin = "ingreso.2026"; 

    try {
        // Validacion ususario administrador 
        if (correo.toLowerCase() === correoAdmin.toLowerCase()) {
            if (contrasena_empresa !== passAdmin) {
                alert("Contraseña administrativa incorrecta.");
                return; 
            }
        }

        const respuesta = await connection.post('/login-usuario', {
            id_empresa,
            correo,
            contrasena_empresa
        });

        if (respuesta.status === 200) {
            alert("¡Login Exitoso!");
            
            // Guardamos el token y datos del usuario
            localStorage.setItem('token', respuesta.data.token);
            localStorage.setItem('usuario', JSON.stringify(respuesta.data.usuario));
            
            // 3. REDIRECCIÓN SEGÚN EL CORREO
            if (correo.toLowerCase() === correoAdmin.toLowerCase()) {
                console.log("Acceso de Administrador Confirmado.");
                window.location.href = "Recepciones.html"; 
            } else {
                console.log("Acceso de Cliente Confirmado.");
                window.location.href = "Registro-Elementos.html";
            }
        }
    } catch (error) {
        console.error("Error en login:", error);
        const mensajeError = error.response?.data?.error || "Error de conexión con el servidor";
        alert("Atención: " + mensajeError);
    }
});