<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

    <head>
        <meta charset="UTF-8">
        <title>Modificar Compra | Ferreteria</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
              integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
            <link rel="stylesheet" href="/Ferreteria/css/style.css">
    </head>

    <body>
        <div class="container mt-5">
            <h1 class="mb-4">Modificar Compra <i class="fas fa-shopping-cart"></i></h1>

            <form method="post" action="/Ferreteria/ServletPrincipal?accion=ModificarCompra"
                  onsubmit="prepareAndSubmit(event)">

                <c:forEach var="compra" items="${comprasList}">
                    <div class="mb-3">
                        <label for="proveedor" class="form-label">Proveedor</label>
                        <select class="form-select" id="proveedor" name="proveedor" data-id-proveedor="${compra.idProveedor}" required>
                            <!-- Options will be populated dynamically through JavaScript -->
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="empleado" class="form-label">Empleado</label>
                        <select class="form-select" id="empleado" name="empleado" data-id-empleado="${compra.idEmpleado}" required>
                            <!-- Options will be populated dynamically through JavaScript -->
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="fechaCompra" class="form-label">Fecha de Compra</label>
                        <!-- Change type to date and add pattern attribute for a specific format -->
                        <input type="date" class="form-control" id="fechaCompra" name="fechaCompra" required
                               pattern="\d{4}-\d{2}-\d{2}">
                    </div>

                    <!-- Inside the form for modifying a purchase -->

                    <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#productoModal">
                        <i class="fas fa-plus"></i> Agregar Producto
                    </button>

                    <!-- Display the added products and quantities -->
                    <div id="productosAgregados">
                        <h2>Detalles de la Compra</h2>
                        <ul>

                            <c:forEach var="detalle" items="${compra.detalleCompra}">
                                <li>
                                    ${detalle.cantidad}x ${detalle.producto.nombre} - Subtotal: ${detalle.cantidad * detalle.precioUnitario}
                                    <button type="button" class="btn btn-warning btn-sm" onclick="editarProducto(${detalle.producto.idProducto})">
                                        <i class="fas fa-edit"></i> Editar
                                    </button>
                                    <button type="button" class="btn btn-danger btn-sm" onclick="eliminarProducto(${detalle.producto.idProducto})">
                                        <i class="fas fa-trash-alt"></i> Eliminar
                                    </button>
                                </li>
                            </c:forEach>
                            <input type="text" id="productosArray" name="productos[]" value="${productosArray}" />
                        </ul>

                    </div>
                    <!-- Add more input fields for other purchase attributes as needed -->

                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-check"></i> Guardar Cambios
                    </button>
                </c:forEach>
            </form>

            <div class="modal fade" id="productoModal" tabindex="-1" aria-labelledby="productoModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="productoModalLabel">Agregar Producto</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="producto" class="form-label">Producto</label>
                                <select class="form-select" id="producto" name="producto">
                                    <!-- Options will be populated dynamically through JavaScript -->
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="cantidadModal" class="form-label">Cantidad</label>
                                <input type="number" class="form-control" id="cantidad" name="cantidad" min="1"
                                       required>
                            </div>
                            <div class="mb-3">
                                <label for="precioUnitarioModal" class="form-label">Precio Unitario</label>
                                <input type="text" class="form-control" id="precioUnitario" name="precioUnitario">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                            <button type="button" class="btn btn-success" onclick="agregarProducto()">Agregar</button>
                        </div>
                    </div>
                </div>
            </div>

            <button class="btn btn-primary mt-3" onclick="regresar()">
                <i class="fas fa-arrow-left"></i> Regresar
            </button>
        </div>

        <!-- Include your Bootstrap JS link and any other necessary scripts -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

        <script>
                function prepareAndSubmit(event) {
                    // Lï¿½gica adicional antes de enviar el formulario, si es necesario
                    // ...

                    // Puedes agregar mï¿½s lï¿½gica segï¿½n tus necesidades antes de enviar el formulario

                    // Envï¿½a el formulario
                    return true;
                }
                var productosArray = [];

            <c:forEach var="detalle" items="${compra.detalleCompra}">
                var producto = {
                    id: ${detalle.producto.idProducto},
                    cantidad: ${detalle.cantidad},
                    precioUnitario: ${detalle.precioUnitario}
                };
              
                var total = producto.precioUnitario * producto.cantidad;

                // Add the selected product, quantity, and unit price to the display
                var productoHTML = '<p>' +  producto.cantidad + 'x '+ ' - Precio Unitario: ' + producto.precioUnitario + ' - Total: ' + total + '</p>';
                $("#productosAgregados").append(productoHTML);
                // Utilizamos las propiedades del objeto producto en lugar de variables separadas.
                var nuevoProducto = {id: producto.id, cantidad: producto.cantidad, precioUnitario: producto.precioUnitario};

                var productosArray = $("#productosArray").val();

                // Parseamos el valor existente de productosArray como un objeto JSON.
                productosArray = productosArray ? JSON.parse(productosArray) : [];

                // Añadimos el nuevo producto al array productosArray.
                productosArray.push(nuevoProducto);

                // Actualizamos el valor del campo de entrada con el nuevo valor de productosArray.
                $("#productosArray").val(JSON.stringify(productosArray));

                // Añadimos el producto actual al array productosArray.
                productosArray.push(producto);
            </c:forEach>


                function agregarProducto() {
                    var productoId = $("#producto").val();
                    var productoNombre = $("#producto option:selected").text();
                    var cantidad = $("#cantidad").val();
                    var precioUnitario = $("#precioUnitario").val();
                    // Fetch product data to get the price
                    $.getJSON('/Ferreteria?accion=ObtenerProductos', function (productData) {
                        var selectedProduct = productData.find(product => product.id === parseInt(productoId, 10));

                        // Validate that a product is selected and quantity is entered
                        if (selectedProduct && cantidad) {
                            // Calculate unit price
                            var precioUnitario = selectedProduct.precio;
                            var total = precioUnitario * cantidad;

                            // Add the selected product, quantity, and unit price to the display
                            var productoHTML = '<p>' + cantidad + 'x ' + productoNombre + ' - Precio Unitario: ' + precioUnitario + ' - Total: ' + total + '</p>';
                            $("#productosAgregados").append(productoHTML);

                            // Update the unit price input field
                            $("#precioUnitario").val("");

                            // Clear the input fields
                            $("#producto").val('');
                            $("#cantidad").val('');

                            // Add the product and quantity to the hidden field value
                            var productosArray = $("#productosArray").val();
                            var nuevoProducto = {id: productoId, cantidad: cantidad, precioUnitario: precioUnitario};
                            productosArray = productosArray ? JSON.parse(productosArray) : [];
                            productosArray.push(nuevoProducto);
                            $("#productosArray").val(JSON.stringify(productosArray));

                            $('#productoModal').modal('hide');
                        } else {
                            alert('Por favor, selecciona un producto e introduce una cantidad.');
                        }
                    })
                            .fail(function (jqxhr, textStatus, error) {
                                var err = textStatus + ', ' + error;
                                console.error('Product Request Failed: ' + err);
                            });
                }
                function populateOptions(elementId, data) {
                    // Lï¿½gica para llenar las opciones de un elemento de selecciï¿½n
                    var selectElement = $("#" + elementId);
                    selectElement.empty();
                    selectElement.append('<option value="">Seleccione una opcion</option>');

                    // Llenar opciones desde los datos proporcionados
                    $.each(data, function (index, item) {
                        selectElement.append('<option value="' + item.id + '">' + item.nombre + '</option>');
                    });
                }

                function setDefaultDate() {
                    // Lï¿½gica para establecer la fecha predeterminada
                    var today = new Date();
                    var dd = String(today.getDate()).padStart(2, '0');
                    var mm = String(today.getMonth() + 1).padStart(2, '0');
                    var yyyy = today.getFullYear();
                    var formattedDate = yyyy + '-' + mm + '-' + dd;

                    // Establecer el valor predeterminado del campo de fecha
                    $('#fechaCompra').val(formattedDate);
                }

                function fetchEmployeeAndSupplierData() {
                    // Logica para obtener datos de empleados y proveedores mediante AJAX
                    $.getJSON('/Ferreteria?accion=ObtenerEmpleados', function (employeeData) {
                        populateOptions('empleado', employeeData);

                        // Set the value of #empleado after populating options
                        var idEmpleado = $("#empleado").data("id-empleado");
                        $("#empleado").val(parseInt(idEmpleado, 10));
                    });

                    $.getJSON('/Ferreteria?accion=ObtenerProveedores', function (supplierData) {
                        populateOptions('proveedor', supplierData);

                        // Set the value of #proveedor after populating options
                        var idProveedor = $("#proveedor").data("id-proveedor");
                        $("#proveedor").val(parseInt(idProveedor, 10));
                    });


                    $.getJSON('/Ferreteria?accion=ObtenerProductos', function (productData) {
                        // Lï¿½gica para llenar las opciones de productos
                        productoOptions(productData);
                    });
                }

                // Funcion para opciones de productos
                function productoOptions(data) {
                    var selectElement = $("#producto");
                    selectElement.empty();
                    selectElement.append('<option value="">Seleccione un producto</option>');

                    $.each(data, function (index, item) {
                        selectElement.append('<option value="' + item.id + '">' + item.nombre + '</option>');
                    });
                }
                function editarProducto(productoId) {
                    // Implementa la lógica para editar el producto con el ID proporcionado
                    // Puedes abrir un modal para editar la cantidad, precio, etc.
                    alert("Implementa la lógica de edición para el producto con ID: " + productoId);
                }

                function eliminarProducto(productoId) {
                    // Implementa la lógica para eliminar el producto con el ID proporcionado
                    // Puedes confirmar la eliminación con un cuadro de diálogo y enviar la solicitud al servidor
                    var confirmarEliminar = confirm("¿Seguro que quieres eliminar este producto?");
                    if (confirmarEliminar) {
                        // Lógica para eliminar el producto (puedes enviar una solicitud AJAX al servidor)
                        alert("Implementa la lógica de eliminación para el producto con ID: " + productoId);
                    }
                }

                // Llamar a la funciï¿½n cuando la pï¿½gina estï¿½ lista
                $(document).ready(function () {
                    fetchEmployeeAndSupplierData();
                    setDefaultDate();




                });

                function regresar() {
                    // Funciï¿½n para regresar a la pï¿½gina anterior
                    window.history.back();
                }
        </script>
    </body>

</html>