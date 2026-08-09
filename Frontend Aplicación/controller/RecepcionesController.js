
import connection from '../model/Connection.js';

document.addEventListener('DOMContentLoaded', async () => {
    const tablaBody = document.querySelector('.tabla-datos tbody');

    if (!tablaBody) {
        console.error("No se encontró el cuerpo de la tabla (.tabla-datos tbody)");
        return;
    }
    try {
        console.log("Cargando registros de la base de datos...");  
        //  Backend trae todos los artefactos
        const respuesta = await connection.get('/artefactos');
        const artefactos = respuesta.data;
        //Limpiar 
        tablaBody.innerHTML = '';

        // Validar si hay datos
        if (artefactos.length === 0) {
            tablaBody.innerHTML = '<tr><td colspan="6">No hay artefactos registrados actualmente.</td></tr>';
            return;
        }

        // Recorrer los datos y crear las filas
        artefactos.forEach(art => {
            const fila = document.createElement('tr');
            
            // Estructura basada en la base de datos 
            fila.innerHTML = `
                <td>${art.id_artefacto}</td>
                <td>${art.tipo}</td>
                <td>${new Date().toLocaleDateString()}</td> <td>${art.id_usuario || 'Admin'}</td>
                <td>${art.id_empresa}</td>
                <td>
                    <select class="select-estado" onchange="cambiarEstado(${art.id_artefacto}, this.value)">
                        <option value="Eliminado" ${art.estado === 'Eliminado' ? 'selected' : ''}>Eliminado</option>
                        <option value="En proceso de reciclaje" ${art.estado === 'En proceso de reciclaje' ? 'selected' : ''}>En proceso</option>
                        <option value="Activo" ${art.estado === 'Activo' ? 'selected' : ''}>Activo</option>
                    </select>
                </td>
            `;
            tablaBody.appendChild(fila);
        });

        console.log("Tabla de recepciones actualizada con éxito.");

    } catch (error) {
        console.error("Error al obtener los artefactos:", error);
        alert("Error al conectar con la base de datos para cargar las recepciones.");
    }
});

/**
 * Admin cambia de "Eliminado" a "Activo"
 */
window.cambiarEstado = async (id, nuevoEstado) => {
    try {
        const confirmacion = confirm(`¿Deseas cambiar el estado del artefacto #${id} a "${nuevoEstado}"?`);
        
        if (confirmacion) {
            await connection.put(`/artefactos/${id}`, { estado: nuevoEstado });
            alert("Estado actualizado correctamente en la base de datos.");
        }
    } catch (error) {
        console.error("Error al actualizar estado:", error);
        alert("No se pudo actualizar el estado. Verifica la conexión.");
    }
};