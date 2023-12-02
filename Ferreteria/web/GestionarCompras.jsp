<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <title>Gestionar Compras | Ferreteria</title>
          <link rel="stylesheet" href="/Ferreteria/css/style.css">
    </head>
    <body>
        <div class="container">
            <h1 class="mb-4">Gestionar Compras</h1>

            <a href="/Ferreteria?accion=AgregarCompra" class="btn btn-primary mb-3">
                <i class="fas fa-plus"></i> Agregar Compra
            </a>

            <table class="table table-bordered table-striped">
                <thead class="table-dark">
                    <tr>
                        <th>ID Compra</th>
                        <th>Proveedor</th>
                        <th>Empleado</th>
                        <th>Fecha Compra</th>
                        <th>Monto Compra</th>
                        <th>Detalle Compra</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="compra" items="${comprasList}">
                        <tr>
                            <td><c:out value="${compra.idCompra}" /></td>
                            <td><c:out value="${compra.nombreProveedor}" /></td>
                            <td><c:out value="${compra.nombreEmpleado}" /></td>
                            <td><c:out value="${compra.fechaCompra}" /></td>
                            <td><c:out value="${compra.montoCompra}" /></td>
                            <td >
                                <button class="btn btn-link" type="button" data-bs-toggle="collapse" data-bs-target="#details${compra.idCompra}" aria-expanded="false" aria-controls="details${compra.idCompra}">
                                    Detalles de la Compra
                                </button>

                                <div class="collapse mt-2" id="details${compra.idCompra}">
                                    <h4>Detalles de la Compra:</h4>
                                    <ul class="list-group">
                                        <c:forEach var="detalle" items="${compra.detalleCompra}">
                                            <li class="list-group-item">
                                                <p>
                                                    ${detalle.cantidad}x ${detalle.producto.nombre} 
                                                    Subtotal: ${detalle.cantidad * detalle.precioUnitario}
                                                    <!-- Add more details as needed -->
                                                </p>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </td>
                            <td>


                                <a href="/Ferreteria/ServletPrincipal?accion=MostrarComprasPorId&idCompra=${compra.idCompra}" class="btn btn-warning">
                                    <i class="fas fa-pencil-alt"></i> Modificar
                                </a>


                                <!-- Eliminación de Compra -->
                                <form method="post" action="opcionesUsuario/EliminarCompra.jsp">
                                    <input type="hidden" name="idCompra" value="${compra.idCompra}" />
                                    <input type="hidden" name="nombreProveedor" value="${compra.nombreProveedor}" />
                                    <input type="hidden" name="nombreEmpleado" value="${compra.nombreEmpleado}" />
                                    <input type="hidden" name="fechaCompra" value="${compra.fechaCompra}" />
                                    <input type="hidden" name="montoCompra" value="${compra.montoCompra}" />
                                    <!-- Agrega más atributos según sea necesario -->

                                    <button type="submit" class="btn btn-danger">
                                        <i class="fas fa-trash-alt"></i> Eliminar
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <!-- Add purchase management actions, links, or forms here -->

            <button class="btn btn-primary" onclick="regresar()">
                <i class="fas fa-arrow-left"></i> Regresar
            </button>
        </div>

        <!-- Include your Bootstrap JS link and any other necessary scripts -->

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>

        <script>
                function regresar() {
                    window.history.back();
                }

                function enviarFormulario(e) {
                    e.preventDefault(); // Evita la acción predeterminada del formulario

                    // Obtener los detalles de la compra actual
                    var detallesCompra = [];

                    // Recorrer los detalles y agregarlos al array

            <c:forEach var="detalle" items="${compra.detalleCompra}">

                    detallesCompra.push({
                        cantidad: ${parseInt(detalle.cantidad)},
                        productoNombre: '${detalle.producto.nombre}',
                        subtotal: ${parseFloat(detalle.cantidad) * parseFloat(detalle.precioUnitario)}

                    });
            </c:forEach>

                    // Serializar el array a formato JSON
                    var detallesJSON = JSON.stringify(detallesCompra);
                    console.log(detallesCompra);

                    // Establecer el valor en el campo oculto
                    document.getElementById('detallesCompra').value = detallesJSON;

                    // Enviar el formulario
                    // document.getElementById('modificarCompraForm').submit();
                }
        </script>
    </body>
</html>
