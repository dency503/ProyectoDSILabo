<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Modificar Proveedor | Ferreteria </title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="/Ferreteria/css/style.css">
    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
</head>
<body>

<div class="container mt-5">
    <h2>Modificar Proveedor</h2>

    <form method="post" action="/Ferreteria/?accion=ModificarProveedor">
        <!-- Retrieve parameters from the POST request -->
        <input type="hidden" name="idProveedor" value="${param.idProveedor}" />

        <!-- Modify provider information here -->
        <div class="form-group">
            <label for="inputNombre"> Nombre:</label>
            <input type="text" class="form-control" id="inputNombre" name="nombre" value="${param.nombre}" required>
        </div>

        <div class="form-group">
            <label for="inputTelefono">Teléfono:</label>
            <input type="text" class="form-control" id="inputTelefono" name="telefono" value="${param.telefono}" required>
        </div>

        <!-- Add more input fields for other attributes as needed -->

        <button type="submit" class="btn btn-primary">Guardar Cambios</button>
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
