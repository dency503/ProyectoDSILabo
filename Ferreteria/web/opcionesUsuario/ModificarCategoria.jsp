<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>Modificar Categoría | Ferreteria</title>
        <link rel="stylesheet" href="/Ferreteria/css/style.css">
</head>
<body>
    <div class="container mt-5">
        <h1>Modificar Categoría</h1>
        
        <form method="post" action="/Ferreteria/ServletPrincipal?accion=ModificarCategoria">
            <input type="hidden" name="idCategoria" value="${param.idCategoria}" />
            
            <div class="mb-3">
                <label for="nombre" class="form-label">Nombre</label>
                <input type="text" class="form-control" id="nombre" name="nombre" value="${param.nombre}" required>
            </div>

            <div class="mb-3">
                <label for="descripcion" class="form-label">Descripción</label>
                <textarea class="form-control" id="descripcion" name="descripcion" rows="3" required>${param.descripcion}</textarea>
            </div>

            <!-- Add any other fields related to category modification -->

            <button type="submit" class="btn btn-primary">Guardar Cambios</button>
        </form>

        <div class="mt-3">
            <a href="/Ferreteria">Regresar a la Lista de Categorías</a>
        </div>
    </div>

    <!-- Include your Bootstrap JS link and any other necessary scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>
