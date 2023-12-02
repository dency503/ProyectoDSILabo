<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <title>Gestionar Detalle Ventas | Ferreteria</title>
        <link rel="stylesheet" href="/Ferreteria/css/style.css">
    </head>
    <body>
        <div class="container">
            <h1 class="mb-4">Gestionar Detalle Ventas</h1>
            <a href="/Ferreteria/opcionesUsuario/AgregarDetalleVenta.jsp" class="btn btn-primary mb-3">
                <i class="fas fa-plus"></i> Agregar Detalle Venta
            </a>
            <table class="table table-bordered table-striped">
                <thead class="table-dark">
                    <tr>
                        <th>ID Detalle Venta</th>
                        <th>Venta</th>
                        <th>Producto</th>
                        <th>Cantidad</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <<c:forEach var="detalleVenta" items="${ventasDetalleList}">
                    <tr>
                        <td>${detalleVenta.idDetalleVenta}</td>
                        <td>${detalleVenta.venta}</td>
                        <td>${detalleVenta.producto.nombre}</td>
                        <td>${detalleVenta.cantidad}</td>
                        <td>
                            <!-- Add your actions or links here, e.g., modify or delete -->
                            <form method="post" action="/Ferreteria/opcionesUsuario/ModificarDetalleVenta.jsp">
                                <input type="hidden" name="idDetalleVenta" value="${detalleVenta.idDetalleVenta}" />
                                <input type="hidden" name="venta" value="${detalleVenta.venta}" />
                                <input type="hidden" name="idProducto" value="${detalleVenta.producto.idProducto}" />
                                <input type="hidden" name="producto" value="${detalleVenta.producto.nombre}" />
                                <input type="hidden" name="cantidad" value="${detalleVenta.cantidad}" />
                                <!-- Add more hidden inputs if needed -->

                                <button type="submit" class="btn btn-warning">
                                    <i class="fas fa-pencil-alt"></i> Modificar
                                </button>
                            </form>
                            <form method="post" action="/Ferreteria/opcionesUsuario/EliminarDetalleVenta.jsp">
                                <input type="hidden" name="idDetalleVenta" value="${detalleVenta.idDetalleVenta}" />
                                <input type="hidden" name="venta" value="${detalleVenta.venta}" />
                                <input type="hidden" name="idProducto" value="${detalleVenta.producto.idProducto}" />
                                <input type="hidden" name="producto" value="${detalleVenta.producto.nombre}" />
                                <input type="hidden" name="cantidad" value="${detalleVenta.cantidad}" />
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

            <!-- Add more sales management actions, links, or forms here -->

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
