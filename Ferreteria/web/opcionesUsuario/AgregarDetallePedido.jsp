<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <title>Agregar Detalle Pedido | Ferreteria</title>
    <link rel="stylesheet" href="/Ferreteria/css/style.css">
</head>
<body>
    <div class="container">
        <h1 class="mb-4">Agregar Detalle Pedido</h1>

        <form method="post" action="/Ferreteria/ServletPrincipal?accion=AgregarDetallePedido">
            <div class="mb-3">
                <label for="idProducto" class="form-label">ID Producto:</label>
                <input type="text" class="form-control" id="idProducto" name="idProducto" required>
            </div>
            <div class="mb-3">
                <label for="cantidad" class="form-label">Cantidad:</label>
                <input type="text" class="form-control" id="cantidad" name="cantidad" required>
            </div>
            <div class="mb-3">
                <label for="precioUnitario" class="form-label">Precio Unitario:</label>
                <input type="text" class="form-control" id="precioUnitario" name="precioUnitario" required>
            </div>

            <!-- Assuming Producto has a nombre property -->
            <!-- You might want to display a dropdown or another input for selecting the product -->

            <!-- Add more input fields if needed -->

            <button type="submit" class="btn btn-primary">
                <i class="fas fa-plus"></i> Agregar Detalle Pedido
            </button>
        </form>

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
