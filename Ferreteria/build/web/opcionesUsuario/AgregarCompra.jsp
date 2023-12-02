<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Agregar Compra | Ferreteria</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">


           <link rel="stylesheet" href="/Ferreteria/css/style.css">
    </head>
    <body>
        <div class="container">
            <h1 class="mb-4">Agregar Compra</h1>

            <form method="post" action="/Ferreteria/ServletPrincipal?accion=AgregarCompras" onsubmit="prepareAndSubmit(event)">
                <!-- Input fields for adding a new purchase -->
                <div class="mb-3">
                    <label for="proveedor" class="form-label">Proveedor</label>
                    <select class="form-select" id="proveedor" name="proveedor" required>
                        <!-- Options will be populated dynamically through JavaScript -->
                    </select>
                </div>

                <div class="mb-3">
                    <label for="empleado" class="form-label">Empleado</label>
                    <select class="form-select" id="empleado" name="empleado" required>
                        <!-- Options will be populated dynamically through JavaScript -->
                    </select>
                </div>

                <div class="mb-3">
                    <label for="fechaCompra" class="form-label">Fecha de Compra</label>
                    <!-- Change type to date and add pattern attribute for a specific format -->
                    <input type="date" class="form-control" id="fechaCompra" name="fechaCompra" required pattern="\d{4}-\d{2}-\d{2}">
                </div>
                <!-- Inside the form for adding a new purchase -->
                <input type="hidden" id="productosArray" name="productos[]">
                <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#productoModal">
                    <i class="fas fa-plus"></i> Agregar Producto
                </button>

                <!-- Display the added products and quantities -->
                <div id="productosAgregados">
                    <!-- Display added products and quantities here -->
                </div>
                <!-- Add more input fields for other purchase attributes as needed -->

                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Agregar Compra
                </button>
            </form>
            <div class="modal fade" id="productoModal" tabindex="-1" aria-labelledby="productoModalLabel" aria-hidden="true">
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
                                <input type="number" class="form-control" id="cantidad" name="cantidad" min="1" required>
                            </div>
                            <div class="mb-3">
                                <label for="precioUnitarioModal" class="form-label">Precio Unitario</label>
                                <input type="text" class="form-control" id="precioUnitario" name="precioUnitario" >
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
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        <script
            src="https://code.jquery.com/jquery-3.7.1.min.js"
            integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
        crossorigin="anonymous"></script>

        <script>
                // Function to populate options in the select elements

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
                            var nuevoProducto = {id: productoId, cantidad: cantidad,precioUnitario: precioUnitario};
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
                    var selectElement = $("#" + elementId);
                    selectElement.empty();

                    // Add a default option if needed
                    selectElement.append('<option value="">Seleciona una opcion</option>');

                    // Populate options from JSON data
                    $.each(data, function (index, item) {
                        selectElement.append('<option value="' + item.id + '">' + item.nombre + '</option>');
                    });
                }
                function setDefaultDate() {
                    var today = new Date();
                    var dd = String(today.getDate()).padStart(2, '0');
                    var mm = String(today.getMonth() + 1).padStart(2, '0'); // January is 0!
                    var yyyy = today.getFullYear();

                    var formattedDate = yyyy + '-' + mm + '-' + dd;

                    // Set the default value of the date field
                    $('#fechaCompra').val(formattedDate);
                }
                function productoOptions(data) {
                    var selectElement = $("#producto");
                    selectElement.empty();

                    // Add a default option if needed
                    selectElement.append('<option value="">Seleccione un producto</option>');

                    // Populate options from the Product data
                    $.each(data, function (index, item) {
                        selectElement.append('<option value="' + item.id + '">' + item.nombre + '</option>');
                    });
                }

                // Function to fetch employee and supplier data
                function fetchEmployeeAndSupplierData() {
                    // Use AJAX to get employee data
                    $.getJSON('http://localhost:8080/Ferreteria?accion=ObtenerEmpleados', function (employeeData) {
                        populateOptions('empleado', employeeData);
                    });

                    // Use AJAX to get supplier data
                    $.getJSON('/Ferreteria?accion=ObtenerProveedores', function (supplierData) {
                        populateOptions('proveedor', supplierData);
                    });
                    $.getJSON('/Ferreteria?accion=ObtenerProductos', function (supplierData) {
                        productoOptions(supplierData);
                    });
                }

                // Call the function when the page is ready
                $(document).ready(function () {
                    fetchEmployeeAndSupplierData();
                    setDefaultDate();

                });

                function regresar() {
                    window.history.back();
                }
        </script>
    </body>
</html>
