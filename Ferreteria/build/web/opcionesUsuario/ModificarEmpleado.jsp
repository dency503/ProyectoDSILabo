<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Modificar Empleado | Ferreteria</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha384-f52b50b1b2ee31e2d0c9966981b5b6b95b7c181c6651852022f2a2f3eb6dd455" crossorigin="anonymous">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <link rel="stylesheet" href="/Ferreteria/css/style.css">
    </head>
    <body>
        <div class="container mt-5">
            <h1 class="mb-4">Modificar Empleado <i class="fas fa-user-edit"></i></h1>

            <form action="/Ferreteria/ServletPrincipal?accion=ModificarEmpleado" method="post"> <!-- Modify the action attribute with the appropriate Servlet URL -->
                <div class="form-group">
                    <label for="idEmpleado">ID:</label>
                    <input type="text" class="form-control" id="idEmpleado" name="idEmpleado" value="<c:out value="${param.idEmpleado}" />" readonly>
                </div>
                <div class="form-group">
                    <label for="dui">DUI:</label>
                    <input type="text" class="form-control" id="dui" name="dui" value="<c:out value="${param.dui}" />">
                </div>
                <div class="form-group">
                    <label for="isss">ISSS:</label>
                    <input type="text" class="form-control" id="isss" name="isss" value="<c:out value="${param.isss}" />">
                </div>
                <div class="form-group">
                    <label for="nombres">Nombres:</label>
                    <input type="text" class="form-control" id="nombres" name="nombres" value="<c:out value="${param.nombres}" />">
                </div>
                <div class="form-group">
                    <label for="apellidos">Apellidos:</label>
                    <input type="text" class="form-control" id="apellidos" name="apellidos" value="<c:out value="${param.apellidos}" />">
                </div>
                <div class="form-group">
                    <label for="fechaNacimiento">Fecha de Nacimiento:</label>
                    <input type="date" class="form-control" id="fechaNacimiento" name="fechaNacimiento" required max="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" value="<c:out value="${param.fechaNacEmpleado}"  />">
                </div>
                <div class="form-group">
                    <label for="telefono">Teléfono:</label>
                    <input type="text" class="form-control" id="telefono" name="telefono" value="<c:out value="${param.telefono}" />">
                </div>
                <div class="form-group">
                    <label for="correo">Correo:</label>
                    <input type="email" class="form-control" id="correo" name="correo" value="<c:out value="${param.correo}" />">
                </div>
                <div class="form-group">
                    <label for="idCargo">ID Cargo:</label>
                    <select class="form-control" id="cargo" name="idCargo" data-id-cargo="${param.idCargo}"  required>

                    </select>
                </div>
                <div class="form-group">
                    <label for="idDireccion">ID de Dirección:</label>
                    <input type="text" class="form-control" id="idDireccion" name="idDireccion" value="<c:out value="${param.idDireccion}" />">
                </div>

                <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                <button type="button" class="btn btn-secondary" onclick="regresar()">Regresar</button>
            </form>
        </div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        <script>

                    (function () {
                        // Evitar variables globales
                        function regresar() {
                            window.history.back();
                        }

                        function cargoOptions(elementId, data) {
                            // Lógica para llenar las opciones de un elemento de selección
                            var selectElement = document.getElementById(elementId);
                            selectElement.innerHTML = '<option value="">Seleccione una opción</option>';

                            // Llenar opciones desde los datos proporcionados
                            data.forEach(function (item) {
                                var option = document.createElement('option');
                                option.value = item.idCargo;
                                option.text = item.cargoNombre;
                                selectElement.appendChild(option);
                            });
                        }

                        function fetchEmployeeAndSupplierData() {
                            // Lógica para obtener datos de empleados y proveedores mediante AJAX
                            $.getJSON('/Ferreteria?accion=ObtenerCargos')
                                    .done(function (supplierData) {
                                        cargoOptions('cargo', supplierData);
                                var idCargo = $("#cargo").data("id-cargo");
                                
                        $("#cargo").val(parseInt(idCargo, 10));
                                    })
                                    .fail(function (jqXHR, textStatus, errorThrown) {
                                        console.error('Error al obtener datos: ' + textStatus, errorThrown);
                                    });
                        }

                        document.addEventListener('DOMContentLoaded', function () {
                            fetchEmployeeAndSupplierData();
                        });

                    })();

        </script>

    </body>
</html>
