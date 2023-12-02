<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Gestionar Proveedores</title>
        <link rel="stylesheet" href="/Ferreteria/css/style.css">
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

        <!-- Font Awesome CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    </head>
    <body>

        <div class="container mt-5">
            <h2>Gestionar Proveedores</h2>

            <!-- Add your content here -->
            <div class="row">
                <div class="col-md-6">
                    <a class="btn btn-primary" href="/Ferreteria/opcionesUsuario/AgregarProveedor.jsp">
                        <i class="fas fa-plus"></i> Agregar Proveedor
                    </a>
                </div>
            </div>

            <!-- Sample table for displaying providers -->
            <table class="table table-bordered table-striped">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Teléfono</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Loop through your list of providers and populate the table -->
                    <c:forEach var="proveedor" items="${proveedoresList}">
                        <tr>
                            <td>${proveedor.idProveedor}</td>
                            <td>${proveedor.nombre}</td>
                            <td>${proveedor.telefono}</td>
                            <td>
                                <!-- Modify button -->
                                <form method="post" action="/Ferreteria/opcionesUsuario/ModificarProveedor.jsp">
                                    <input type="hidden" name="idProveedor" value="${proveedor.idProveedor}" />
                                    <input type="hidden" name="telefono" value="${proveedor.telefono}" />
                                    <input type="hidden" name="idDireccion" value="${proveedor.idDireccion}" />
                                    <input type="hidden" name="nombre" value="${proveedor.nombre}" />
                                    <!-- Add more hidden input fields as needed for other attributes -->

                                    <button type="submit" class="btn btn-warning btn-sm">
                                        <i class="fas fa-edit"></i> Modificar
                                    </button>
                                </form>

                                <!-- Delete button -->
                                <form method="post" action="/Ferreteria/opcionesUsuario/EliminarProveedor.jsp">
                                    <input type="hidden" name="idProveedor" value="${proveedor.idProveedor}" />
                                    <input type="hidden" name="telefono" value="${proveedor.telefono}" />
                                    <input type="hidden" name="idDireccion" value="${proveedor.idDireccion}" />
                                    <input type="hidden" name="nombre" value="${proveedor.nombre}" />
                                    <!-- Add more hidden input fields as needed for other attributes -->

                                    <button type="submit" class="btn btn-danger btn-sm">
                                        <i class="fas fa-trash-alt"></i> Eliminar
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <button class="btn btn-primary" onclick="regresar()">
                <i class="fas fa-arrow-left"></i> Regresar
            </button>
        </div>
        <script>
            function regresar() {
                window.history.back();
            }


        </script>
        <!-- Bootstrap JS and Popper.js -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

        <!-- Font Awesome JS -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js"></script>

    </body>
</html>
