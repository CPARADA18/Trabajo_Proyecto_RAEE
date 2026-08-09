
import connection from '../model/Connection.js';

document.addEventListener('DOMContentLoaded', () => {
    const formulario = document.querySelector('.formulario-registro-empresas');

    if (formulario) {
        formulario.addEventListener('submit', async (e) => {
            e.preventDefault();

            const datosEmpresa = {
                nombre: document.getElementById('nombre')?.value,
                nit: document.getElementById('nit')?.value,
                correo: document.getElementById('email')?.value,
                telefono: document.getElementById('telefono')?.value,
                ciudad: document.getElementById('ciudad')?.value,
                contrasena: document.getElementById('contrasena')?.value,
                estado:'Pendiente'
            };
            const confirmPass = document.getElementById('confirmar-contrasena')?.value;
            if (datosEmpresa.contrasena !== confirmPass) {
                alert('Las contraseñas no coinciden');
                return;
            }
            try {
                const respuesta = await connection.post('/empresas', datosEmpresa);    
                alert('¡Empresa registrada con éxito!');
                console.log('Respuesta:', respuesta.data);
                formulario.reset(); 

            } catch (error) {
                console.error('Error:', error);
                const mensaje = error.response?.data?.message || 'Error de conexión';
                alert('Hubo un problema: ' + mensaje);
            }
        });
    }
});