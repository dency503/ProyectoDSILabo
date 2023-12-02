<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Agregar Proveedor</title>
    <link rel="stylesheet" href="/Ferreteria/css/style.css">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
</head>
<body>

<div class="container mt-5">
    <h2>Agregar Proveedor</h2>

    <form method="post" action="/Ferreteria/?accion=AgregarProveedor">
        <!-- Input fields for adding a new provider -->
        <div class="form-group">
            <label for="inputNombre">Nombre:</label>
            <input type="text" class="form-control" id="inputNombre" name="nombre" required>
        </div>

        <div class="form-group">
            <label for="inputTelefono">Teléfono:</label>
            <input type="text" class="form-control" id="inputTelefono" name="telefono" required>
        </div>

        <!-- Add more input fields for other attributes as needed -->

        <button type="submit" class="btn btn-primary">Agregar Proveedor</button>
        
    </form>
</div>

<!-- Bootstrap JS and Popper.js -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- Font Awesome JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js"></script>

</body>
</html>
