<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestionar Clientes | Ferreteria</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        body {
            background-color: #f8f9fa;
        }

        .container {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-top: 50px;
        }

        h1 {
            color: #343a40;
        }

        table {
            width: 100%;
            margin-top: 20px;
        }

        th, td {
            padding: 10px;
            text-align: center;
        }

        .btn-primary,
        .btn-warning,
        .btn-danger {
            margin-right: 5px;
        }

        .btn {
            font-size: 14px;
        }

        .btn i {
            margin-right: 5px;
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }

        .btn-warning {
            background-color: #ffc107;
            border-color: #ffc107;
        }

        .btn-danger {
            background-color: #dc3545;
            border-color: #dc3545;
        }

        .btn-primary:hover,
        .btn-primary:focus {
            background-color: #0056b3;
            border-color: #0056b3;
        }

        .btn-warning:hover,
        .btn-warning:focus {
            background-color: #d39e00;
            border-color: #d39e00;
        }

        .btn-danger:hover,
        .btn-danger:focus {
            background-color: #c82333;
            border-color: #bd2130;
        }

        .btn-primary i,
        .btn-warning i,
        .btn-danger i {
            color: #ffffff;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="mb-4">Listado de Clientes</h1>

        <!-- Enlace para agregar clientes -->
        <a href="/Ferreteria/opcionesUsuario/AgregarCliente.jsp" class="btn btn-primary mb-2 text-white"><i class="fas fa-plus"></i> Agregar Cliente</a>

        <table class="table table-bordered table-striped">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Nombres</th>
                    <th>Apellidos</th>
                    <th>DUI</th>
                    <th>Teléfono</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="cliente" items="${clientesList}">
                    <tr>
                        <td><c:out value="${cliente.idCliente}" /></td>
                        <td><c:out value="${cliente.nombres}" /></td>
                        <td><c:out value="${cliente.apellidos}" /></td>
                        <td><c:out value="${cliente.dui}" /></td>
                        <td><c:out value="${cliente.telefono}" /></td>
                        <td>
                            <form method="post" action="opcionesUsuario/ModificarCliente.jsp">
                                <input type="hidden" name="idCliente" value="${cliente.idCliente}" />
                                <input type="hidden" name="nombres" value="${cliente.nombres}" />
                                <input type="hidden" name="apellidos" value="${cliente.apellidos}" />
                                <input type="hidden" name="dui" value="${cliente.dui}" />
                                <input type="hidden" name="telefono" value="${cliente.telefono}" />
                                <button type="submit" class="btn btn-warning"><i class="fas fa-edit"></i> Modificar</button>
                            </form>
                            <form method="post" action="opcionesUsuario/EliminarCliente.jsp">
                                <input type="hidden" name="idCliente" value="${cliente.idCliente}" />
                                <input type="hidden" name="nombres" value="${cliente.nombres}" />
                                <input type="hidden" name="apellidos" value="${cliente.apellidos}" />
                                <input type="hidden" name="dui" value="${cliente.dui}" />
                                <input type="hidden" name="telefono" value="${cliente.telefono}" />
                                <button type="submit" class="btn btn-danger"><i class="fas fa-trash"></i> Eliminar</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <a href="#" class="btn btn-primary" onclick="regresar()"><i class="fas fa-arrow-left"></i> Regresar</a>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <script>
        function regresar() {
            window.history.back();
        }
    </script>
</body>
</html>
