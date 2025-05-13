
const token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3NDcwMTU5NjAsImV4cCI6MTc0NzAxOTU2MCwiZGF0YSI6eyJ1c2VyX2lkIjoxMjMsInJvbGUiOiJhZG1pbiJ9fQ.yCJouIBZmDqkGpW5sH1sEteW76frksJwdDTYEfXPZ7w';

document.addEventListener('DOMContentLoaded', () => {

    fetch('http://localhost:8080/api/ventas/lista', {
        method: 'GET',
        headers: {
            'Authorization': `Bearer ${token}`,
            'Content-Type': 'application/json'
        }
    })
    .then(response => {
        if (!response.ok) {
            throw new Error(`Error HTTP: ${response.status}`);
        }
        return response.json();
    })
    .then(data => {
        // Cargar lista de ventas
        const listaVentas = document.getElementById('lista-ventas');
        listaVentas.innerHTML = '';

            if (data.lista_ventas && data.lista_ventas.length > 0) {
                data.lista_ventas.forEach(venta => {
                    const row = document.createElement('tr');
                    row.innerHTML = `
                                <td>${venta.venta_id}</td>
                                <td>${venta.nombre_producto}</td>
                                <td>${venta.cantidad_vendida}</td>
                                <td>${venta.numero_mesa}</td>
                                <td>${venta.empleado}</td>
                                <td>$${parseFloat(venta.total_venta).toFixed(2)}</td>
                            `;
                    listaVentas.appendChild(row);
                });
            } else {
                listaVentas.innerHTML = '<tr><td colspan="6" class="text-center">No hay ventas disponibles</td></tr>';
            }

        })
        .catch(error => {
            console.error('Error al obtener datos:', error);
            document.getElementById('lista-ventas').innerHTML = 
                '<tr><td colspan="6" class="text-center">Error al cargar los datos: ' + error.message + '</td></tr>';
        });
});