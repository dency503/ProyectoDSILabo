<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <title>Gestionar Pedidos | Ferreteria</title>
        <style>
            body {
                background-color: #f8f9fa;
            }

            .container {
                background-color: #ffffff;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                padding: 20px;
                margin-top: 50px;
            }

            h1 {
                color: #343a40;
            }

            table {
                width: 100%;
                margin-top: 20px;
            }

            th, td {
                padding: 10px;
                text-align: center;
            }

            .btn-primary,
            .btn-danger {
                margin-right: 5px;
            }

            .btn {
                font-size: 14px;
            }

            .btn i {
                margin-right: 5px;
            }

            .btn-primary {
                background-color: #007bff;
                border-color: #007bff;
            }

            .btn-danger {
                background-color: #dc3545;
                border-color: #dc3545;
            }

            .btn-primary:hover,
            .btn-primary:focus {
                background-color: #0056b3;
                border-color: #0056b3;
            }

            .btn-danger:hover,
            .btn-danger:focus {
                background-color: #c82333;
                border-color: #bd2130;
            }

            .btn-primary i,
            .btn-danger i {
                color: #ffffff;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Gestionar Pedidos</h1>
            <a href="/Ferreteria/opcionesUsuario/AgregarPedido.jsp" class="btn btn-primary mb-3">
                <i class="fas fa-plus"></i> Agregar Compra
            </a>

            <table class="table table-bordered table-striped">
                <thead class="table-dark">
                    <tr>
                        <th>ID Pedido</th>
                        <th>Proveedor</th>
                        <th>Empleado</th>
                        <th>Fecha</th>
                        <th>Costo Total</th>
                        <th>Detalle Pedido</th>
                        <th>Acciones</th>
                        <!-- Puedes agregar más columnas según tus necesidades -->
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="pedido" items="${pedidosList}">
                        <tr>
                            <td>${pedido.idPedido}</td>
                            <td>${pedido.nombreProveedor}</td>
                            <td>${pedido.nombreEmpleado}</td>
                            <td>${pedido.fecha}</td>
                            <td>${pedido.costoTotal}</td>
                            <td><button class="btn btn-link" type="button" data-bs-toggle="collapse" data-bs-target="#details${pedido.idPedido}" aria-expanded="false" aria-controls="details${pedido.idPedido}">
                                    Detalles del pedido
                                </button>

                                <div class="collapse mt-2" id="details${pedido.idPedido}">
                                    <h4>Detalles del pedido:</h4>
                                    <ul class="list-group">
                                        <c:forEach var="detalle" items="${pedido.detallePedidos}">
                                            <li class="list-group-item">
                                                <p>
                                                    ${detalle.cantidad}x ${detalle.producto.nombre} 
                                                    Subtotal: ${detalle.cantidad * detalle.precioUnitario}
                                                    <!-- Add more details as needed -->
                                                </p>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div></td>
                                <td><a href="/Ferreteria/ServletPrincipal?accion=MostrarComprasPorId&idCompra=${pedido.idPedido}" class="btn btn-primary btn-sm">
                                    <i class="fas fa-pencil-alt"></i> Modificar
                                </a>


                                <!-- Eliminación de Compra -->
                                <form method="post" action="opcionesUsuario/EliminarPedido.jsp">
                                    <input type="hidden" name="idCompra" value="${compra.idCompra}" />
                                    <input type="hidden" name="idProveedor" value="${compra.idProveedor}" />
                                    <input type="hidden" name="idEmpleado" value="${compra.idEmpleado}" />
                                    <input type="hidden" name="fechaCompra" value="${compra.fechaCompra}" />
                                    <input type="hidden" name="montoCompra" value="${compra.montoCompra}" />
                                    <!-- Agrega más atributos según sea necesario -->

                                    <button type="submit" class="btn btn-danger btn-sm">
                                        <i class="fas fa-trash-alt"></i> Eliminar
                                    </button></form><td>
                            <!-- Puedes agregar más columnas según tus necesidades -->
                        </tr>
                    </c:forEach>
                </tbody>
                <button class="btn btn-primary" onclick="regresar()">Regresar</button>
            </table>
             <button class="btn btn-primary" onclick="regresar()">
            <i class="fas fa-arrow-left"></i> Regresar
        </button>
        </div>

        <!-- Agrega tus scripts personalizados aquí -->

       
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
        <!-- Agrega tus scripts, como Bootstrap y otras dependencias aquí -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>

    </body>
</html>
