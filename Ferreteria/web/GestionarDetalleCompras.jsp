<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <title>Gestionar Detalle Compras | Ferreteria</title>
    <link rel="stylesheet" href="/Ferreteria/css/style.css">
</head>
<body>
    <div class="container">
        <h1 class="mb-4">Gestionar Detalle Compras</h1>

        <!-- Add a link or button to add a new DetalleCompra -->
        <a href="/Ferreteria?accion=AgregarDetalleCompra" class="btn btn-primary mb-3">
            <i class="fas fa-plus"></i> Agregar Detalle Compra
        </a>

        <table class="table table-bordered table-striped">
            <thead class="table-dark">
                <tr>
                    <th>ID Detalle Compra</th>
                    <th>ID Compra</th>
                    <th>ID Producto</th>
                    <th>Cantidad</th>
                    <th>Precio Unitario</th>
                    <th>Producto</th>
                    <!-- Add more columns if needed -->
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="detalleCompra" items="${comprasDetalleList}">
                    <tr>
                        <td><c:out value="${detalleCompra.idDetalleCompra}" /></td>
                        <td><c:out value="${detalleCompra.idCompra}" /></td>
                        <td><c:out value="${detalleCompra.idProducto}" /></td>
                        <td><c:out value="${detalleCompra.cantidad}" /></td>
                        <td><c:out value="${detalleCompra.precioUnitario}" /></td>
                        <!-- Assuming Producto has a nombre property -->
                        <td><c:out value="${detalleCompra.producto.nombre}" /></td>
                        <!-- Add more columns if needed -->
                        <td>
                            <!-- Add actions, links, or forms for managing DetalleCompra -->
                            <a href="/Ferreteria/ServletPrincipal?accion=ModificarDetalleCompra&idDetalleCompra=${detalleCompra.idDetalleCompra}" class="btn btn-warning">
                                <i class="fas fa-pencil-alt"></i> Modificar
                            </a>

                            <form method="post" action="/Ferreteria/opcionesUsuario/EliminarDetalleCompra.jsp">
                                <input type="hidden" name="idDetalleCompra" value="${detalleCompra.idDetalleCompra}" />
                                <input type="hidden" name="idCompra" value="${detalleCompra.idCompra}" />
                                <input type="hidden" name="idProducto" value="${detalleCompra.idProducto}" />
                                <input type="hidden" name="cantidad" value="${detalleCompra.cantidad}" />
                                <input type="hidden" name="precioUnitario" value="${detalleCompra.precioUnitario}" />
                                <!-- Add more hidden inputs if needed -->

                                <button type="submit" class="btn btn-danger">
                                    <i class="fas fa-trash-alt"></i> Eliminar
                                </button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- Add DetalleCompra management actions, links, or forms here -->

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
    </script>
</body>
</html>
