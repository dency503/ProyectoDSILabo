<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="/Ferreteria/css/style.css">
    <title>Eliminar Producto | Ferreteria</title>
</head>
<body>
    <div class="container mt-5">
        <h1>Eliminar Producto</h1>
        
        <form id="eliminarProductoForm" method="post" action="/Ferreteria/?accion=EliminarProducto">
            <input type="hidden" name="idProducto" value="<%= request.getParameter("idProducto") %>" />
            
            <div class="mb-3">
                <label for="nombre" class="form-label">Nombre del Producto</label>
                <input type="text" class="form-control" id="nombre" name="nombre" value="<%= request.getParameter("nombre") %>" readonly>
            </div>

            <div class="mb-3">
                <label for="descripcion" class="form-label">Descripción</label>
                <textarea class="form-control" id="descripcion" name="descripcion" rows="3" readonly><%= request.getParameter("descripcion") %></textarea>
            </div>

            <div class="mb-3">
                <label for="precio" class="form-label">Precio</label>
                <input type="text" class="form-control" id="precio" name="precio" value="<%= request.getParameter("precio") %>" readonly>
            </div>

            <div class="mb-3">
                <label for="stock" class="form-label">Stock</label>
                <input type="text" class="form-control" id="stock" name="stock" value="<%= request.getParameter("stock") %>" readonly>
            </div>

            <div class="mb-3">
                <label for="idCategoria" class="form-label">ID de Categoría</label>
                <input type="text" class="form-control" id="idCategoria" name="idCategoria" value="<%= request.getParameter("idCategoria") %>" readonly>
            </div>

            <!-- Add other fields related to product deletion -->

            <button type="button" class="btn btn-danger" onclick="confirmarEliminacion()">Eliminar Producto</button>
        </form>

        <div class="mt-3">
            <a href="/Ferreteria">Regresar a la Lista de Productos en Ferreteria</a>
        </div>
    </div>

    <!-- Include your Bootstrap JS link and any other necessary scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>

    <script>
        function confirmarEliminacion() {
            var confirmacion = confirm("¿Está seguro de que desea eliminar este producto?");
            if (confirmacion) {
                document.getElementById("eliminarProductoForm").submit();
            }
        }
    </script>
</body>
</html>
