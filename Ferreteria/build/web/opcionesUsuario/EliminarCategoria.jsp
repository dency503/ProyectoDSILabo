<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Eliminar Categoría | Ferreteria</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha384-f52b50b1b2ee31e2d0c9966981b5b6b95b7c181c6651852022f2a2f3eb6dd455" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <link rel="stylesheet" href="/Ferreteria/css/style.css">
</head>
<body>
    <div class="container mt-5">
        <h1 class="mb-4">Eliminar Categoría <i class="fas fa-trash"></i></h1>
        
        <form action="/Ferreteria/ServletPrincipal?accion=EliminarCategoria" method="post"> <!-- Adjust the action attribute with the appropriate Servlet URL -->
            <div class="form-group">
                <label for="idCategoria">ID:</label>
                <input type="text" class="form-control" id="idCategoria" name="idCategoria" value="<c:out value="${param.idCategoria}" />" readonly>
            </div>
            <div class="form-group">
                <label for="nombre">Nombre:</label>
                <input type="text" class="form-control" id="nombre" name="nombre" value="<c:out value="${param.nombre}" />" readonly>
            </div>
            <div class="form-group">
                <label for="descripcion">Descripción:</label>
                <textarea class="form-control" id="descripcion" name="descripcion" rows="3" readonly><c:out value="${param.descripcion}" /></textarea>
            </div>
            <!-- Add more fields that you want to display for confirmation -->

            <button type="submit" class="btn btn-danger"><i class="fas fa-trash"></i> Confirmar Eliminación</button>
            <button type="button" class="btn btn-secondary" onclick="regresar()"><i class="fas fa-arrow-left"></i> Regresar</button>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <script>
        function regresar(){
            window.history.back();
        }
    </script>
</body>
</html>
