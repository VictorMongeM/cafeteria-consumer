
const token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE3NDcxMDIyMDN9.sLhG8O3zxgd-vN2T4wxvYHnRv9nQ6UuuQr8_ghcqaM0';

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
        return response.text();
    })
    .then(xmlString => {
            // **** CAMBIO CLAVE: Parsear la cadena XML ****
            const parser = new DOMParser();
            const xmlDoc = parser.parseFromString(xmlString, 'text/xml'); // O 'application/xml'

            // Verificar si hubo errores al parsear el XML
            if (xmlDoc.getElementsByTagName('parsererror').length > 0) {
                // Intenta obtener más detalles del error si están disponibles en el XML de error
                const errorElement = xmlDoc.getElementsByTagName('parsererror')[0];
                const errorText = errorElement ? errorElement.textContent : 'Error desconocido al parsear XML';
                throw new Error('Error al parsear la respuesta XML: ' + errorText);
            }

            // **** CAMBIO CLAVE: Extraer los datos del documento XML ****
            // Aquí necesitas adaptar los selectores ('venta', 'venta_id', etc.)
            // a la estructura exacta de tu XML.
            // Por ejemplo, si tu XML es así:
            /*
            <lista_ventas>
            <venta>
                <venta_id>1</venta_id>
                <nombre_producto>Cafe</nombre_producto>
                <cantidad_vendida>2</cantidad_vendida>
                <numero_mesa>5</numero_mesa>
                <empleado>Juan</empleado>
                <total_venta>4.50</total_venta>
            </venta>
            <venta>
                ...
            </venta>
            </lista_ventas>
            */
            const ventaElements = xmlDoc.querySelectorAll('venta'); // Selecciona todos los elementos <venta>

            const listaVentasData = [];
            ventaElements.forEach(ventaElement => {
                const venta = {
                    // Usamos querySelector en cada elemento <venta> para encontrar sus hijos
                    // y .textContent para obtener el texto dentro de ellos.
                    // Usamos el operador ?. (optional chaining) y || '' para manejar casos
                    // donde un elemento hijo pueda faltar y evitar errores.
                    venta_id: ventaElement.querySelector('venta_id')?.textContent || '',
                    nombre_producto: ventaElement.querySelector('nombre_producto')?.textContent || '',
                    cantidad_vendida: ventaElement.querySelector('cantidad_vendida')?.textContent || '',
                    numero_mesa: ventaElement.querySelector('numero_mesa')?.textContent || '',
                    empleado: ventaElement.querySelector('empleado')?.textContent || '',
                    total_venta: ventaElement.querySelector('total_venta')?.textContent || ''
                };
                listaVentasData.push(venta);
            });

            // Ahora 'listaVentasData' es un array de objetos JavaScript, similar a
            // lo que hubieras obtenido con response.json(), y puedes usar la lógica
            // original para mostrar los datos.
            return listaVentasData; // Pasa el array al siguiente .then
        })
        .then(data => { // 'data' aquí es el array de objetos que creamos en el paso anterior
            // Cargar lista de ventas - Esta parte puede permanecer prácticamente igual
            const listaVentas = document.getElementById('lista-ventas');
            listaVentas.innerHTML = ''; // Limpiar la tabla

            if (data && data.length > 0) {
                data.forEach(venta => {
                    const row = document.createElement('tr');
                    row.innerHTML = `
                        <td>${venta.venta_id}</td>
                        <td>${venta.nombre_producto}</td>
                        <td>${venta.cantidad_vendida}</td>
                        <td>${venta.numero_mesa}</td>
                        <td>${venta.empleado}</td>
                        <td>$${parseFloat(venta.total_venta || '0').toFixed(2)}</td>
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