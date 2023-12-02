<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Eliminar Proveedor</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="/Ferreteria/css/style.css">
    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
</head>
<body>

<div class="container mt-5">
    <h2>Eliminar Proveedor</h2>

    <form method="post" action="/Ferreteria/?accion=EliminarProveedor">
        <!-- Retrieve parameters from the POST request -->
        <input type="hidden" name="idProveedor" value="${param.idProveedor}" />
        <input type="hidden" name="nombre" value="${param.nombre}" />
        <input type="hidden" name="telefono" value="${param.telefono}" />
        <input type="hidden" name="idDireccion" value="${param.idDireccion}" />

        <div class="alert alert-danger" role="alert">
            ¿Está seguro que desea eliminar al proveedor con la siguiente información?
        </div>

        <!-- Display provider information in input fields -->
        <div class="form-group">
            <label for="inputNombre">Nombre:</label>
            <input type="text" class="form-control" id="inputNombre" value="${param.nombre}" readonly>
        </div>

        <div class="form-group">
            <label for="inputTelefono">Teléfono:</label>
            <input type="text" class="form-control" id="inputTelefono" value="${param.telefono}" readonly>
        </div>

        <!-- Add more input fields for other attributes as needed -->

        <button type="submit" class="btn btn-danger">Eliminar</button>
        <a href="GestionarProveedor.jsp" class="btn btn-secondary">Cancelar</a>
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
