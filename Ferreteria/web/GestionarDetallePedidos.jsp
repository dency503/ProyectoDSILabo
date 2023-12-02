<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <title>Gestionar Detalle Pedido | Ferreteria</title>
    <link rel="stylesheet" href="/Ferreteria/css/style.css">
</head>
<body>
    <div class="container">
        <h1 class="mb-4">Gestionar Detalle Pedido</h1>

        <!-- Add a link or button to add a new DetallePedido -->
        <a href="/Ferreteria/opcionesUsuario/AgregarDetallePedido.jsp" class="btn btn-primary mb-3">
            <i class="fas fa-plus"></i> Agregar Detalle Pedido
        </a>

        <table class="table table-bordered table-striped">
            <thead class="table-dark">
                <tr>
                    <th>ID Detalle Pedido</th>
                    <th>ID Producto</th>
                    <th>Cantidad</th>
                    <th>Precio Unitario</th>
                    <th>Producto</th>
                    <!-- Add more columns if needed -->
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="detallePedido" items="${pedidosList}">
                    <tr>
                        <td><c:out value="${detallePedido.idDetallePedido}" /></td>
                        <td><c:out value="${detallePedido.idProducto}" /></td>
                        <td><c:out value="${detallePedido.cantidad}" /></td>
                        <td><c:out value="${detallePedido.precioUnitario}" /></td>
                        <!-- Assuming Producto has a nombre property -->
                        <td><c:out value="${detallePedido.producto.nombre}" /></td>
                        <!-- Add more columns if needed -->
                        <td>
                            <!-- Add actions, links, or forms for managing DetallePedido -->
                            <form method="post" action="/Ferreteria/opcionesUsuario/ModificarDetallePedido.jsp">
                                <input type="hidden" name="idDetallePedido" value="${detallePedido.idDetallePedido}" />
                                <input type="hidden" name="idProducto" value="${detallePedido.idProducto}" />
                                <input type="hidden" name="cantidad" value="${detallePedido.cantidad}" />
                                <input type="hidden" name="precioUnitario" value="${detallePedido.precioUnitario}" />
                                <!-- Add more hidden inputs if needed -->

                                <button type="submit" class="btn btn-warning">
                                   <i class="fas fa-edit"></i> Modificar
                                </button>
                            </form>

                            <form method="post" action="/Ferreteria/opcionesUsuario/EliminarDetallePedido.jsp">
                                <input type="hidden" name="idDetallePedido" value="${detallePedido.idDetallePedido}" />
                                <input type="hidden" name="idProducto" value="${detallePedido.idProducto}" />
                                <input type="hidden" name="cantidad" value="${detallePedido.cantidad}" />
                                <input type="hidden" name="precioUnitario" value="${detallePedido.precioUnitario}" />
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

        <!-- Add DetallePedido management actions, links, or forms here -->

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
