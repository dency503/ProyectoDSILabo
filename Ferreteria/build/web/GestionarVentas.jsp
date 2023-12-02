<%-- 
    Document   : GestionarVentas
    Created on : 26 nov 2023, 18:32:34
    Author     : Home
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA==" crossorigin="anonymous" referrerpolicy="no-referrer" />

        <title>JSP Page</title>
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

            .btn-danger {
                background-color: #dc3545;
                border-color: #dc3545;
            }

            .btn-primary:hover,
            .btn-primary:focus {
                background-color: #0056b3;
                border-color: #0056b3;
            }

            .btn-danger:hover,
            .btn-danger:focus {
                background-color: #c82333;
                border-color: #bd2130;
            }

            .btn-primary i,
            .btn-danger i {
                color: #ffffff;
            }
        </style>
    </head>
    <body><div class="container">
            <h2>Gestionar Ventas</h2>
            <a href="/Ferreteria?accion=AgregarCompra" class="btn btn-primary mb-3">
                <i class="fas fa-plus"></i> Agregar Venta
            </a>
            <table class="table table-bordered table-striped">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Cliente</th>
                        <th>Empleado</th>
                        <th>Fecha de venta</th>
                        <th>Monto Total</th>
                        <!-- Add more columns as needed -->
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="venta" items="${ventasList}">
                        <tr>

                            <td>${venta.idVenta}</td>
                            <td>${venta.cliente.nombres}</td>
                            <td>${venta.empleado.nombres}</td>
                            <td>${venta.fechaCompra}</td>
                            <td>${venta.montoCompra}</td>
                            <!-- Add more columns as needed -->
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
    </body>
</html>
