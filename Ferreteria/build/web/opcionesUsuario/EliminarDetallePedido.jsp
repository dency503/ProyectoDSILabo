<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <title>Eliminar Detalle Pedido | Ferreteria</title>
    <link rel="stylesheet" href="/Ferreteria/css/style.css">
</head>
<body>
    <div class="container">
        <h1 class="mb-4">Eliminar Detalle Pedido</h1>

        <div class="card">
            <div class="card-body">
                <p><strong>ID Detalle Pedido:</strong> ${param.idDetallePedido}</p>
                <p><strong>ID Producto:</strong> ${param.idProducto}</p>
                <p><strong>Cantidad:</strong> ${param.cantidad}</p>
                <p><strong>Precio Unitario:</strong> ${param.precioUnitario}</p>
                <!-- Assuming Producto has a nombre property -->
                <p><strong>Producto:</strong> ${param.producto.nombre}</p>
                <!-- Add more details as needed -->

                <form method="post" action="/Ferreteria/ServletPrincipal?accion=EliminarDetallePedido">
                    <input type="hidden" name="idDetallePedido" value="${param.idDetallePedido}" />
                    <!-- Add more hidden input fields if needed -->

                    <button type="submit" class="btn btn-danger">
                        <i class="fas fa-trash-alt"></i> Confirmar Eliminación
                    </button>
                </form>
            </div>
        </div>

        <button class="btn btn-secondary mt-3" onclick="regresar()">
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
