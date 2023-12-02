<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <title>Gestionar Categorias | Ferreteria</title>
    <link rel="stylesheet" href="/Ferreteria/css/style.css">
</head>
<body>
    <div class="container mt-5">
        <h1 class="mb-4">Gestionar Categorías</h1>
        
        <a href="/Ferreteria/opcionesUsuario/AgregarCategoria.jsp" class="btn btn-primary mb-3">
            <i class="fas fa-plus"></i> Agregar Categoriaw
        </a>

        <table class="table table-bordered table-striped">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Descripción</th>
                    <th>Acciones</th>
                    <!-- Add any other category-related headers -->
                </tr>
            </thead>
            <tbody>
                <c:forEach var="categoria" items="${categoriasList}">
                    <tr>
                        <td><c:out value="${categoria.idCategoria}" /></td>
                        <td><c:out value="${categoria.nombre}" /></td>
                        <td><c:out value="${categoria.descripcion}" /></td>
                        <td>
                            <form method="post" action="opcionesUsuario/ModificarCategoria.jsp">
                                <input type="hidden" name="idCategoria" value="${categoria.idCategoria}" />
                                <input type="hidden" name="nombre" value="${categoria.nombre}" />
                                <input type="hidden" name="descripcion" value="${categoria.descripcion}" />
                                <!-- Add any other category-related data -->
                                <button type="submit" class="btn btn-primary btn-sm">
                                    <i class="fas fa-pencil-alt"></i> Modificar
                                </button>
                            </form>

                            <form method="post" action="opcionesUsuario/EliminarCategoria.jsp">
                                <input type="hidden" name="idCategoria" value="${categoria.idCategoria}" />
                                <input type="hidden" name="nombre" value="${categoria.nombre}" />
                                <input type="hidden" name="descripcion" value="${categoria.descripcion}" />
                                <!-- Add any other category-related data -->
                                <button type="submit" class="btn btn-danger btn-sm">
                                    <i class="fas fa-trash-alt"></i> Eliminar
                                </button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- Add category management actions, links, or forms here -->

        <button class="btn btn-primary" onclick="regresar()">
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
