<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Agregar DetalleVenta | Ferreteria</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="/Ferreteria/css/style.css">
</head>
<body>
    <div class="container mt-5">
        <h1 class="mb-4">Agregar DetalleVenta</h1>

        <form method="post" action="/Ferreteria/?accion=AgregarDetalleVenta">
            <div class="mb-3">
                <label for="venta" class="form-label">Venta:</label>
                <input type="text" class="form-control" id="venta" name="venta" required>
            </div>

            <div class="mb-3">
                <label for="idProducto" class="form-label">ID Producto:</label>
                <input type="text" class="form-control" id="idProducto" name="idProducto" required>
            </div>

            <div class="mb-3">
                <label for="cantidad" class="form-label">Cantidad:</label>
                <input type="text" class="form-control" id="cantidad" name="cantidad" required>
            </div>

            <!-- Add more input fields for other details if needed -->

            <button type="submit" class="btn btn-primary">
                <i class="fas fa-plus"></i> Agregar DetalleVenta
            </button>
        </form>

        <a href="#" onclick="regresar()" class="btn btn-secondary mt-3">
            <i class="fas fa-arrow-left"></i> Regresar
        </a>
    </div>

    <!-- Include your Bootstrap JS link and any other necessary scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

    <script>
        function regresar() {
            window.history.back();
        }
    </script>
</body>
</html>
