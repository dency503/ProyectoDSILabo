<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Eliminar Compra | Ferreteria</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
     <link rel="stylesheet" href="/Ferreteria/css/style.css">
</head>
<body>
    <div class="container mt-5">
        <h1 class="mb-4">Eliminar Compra</h1>

        <div class="card">
            <div class="card-body">
                <p><strong>ID Compra:</strong> ${param.idCompra}</p>
                <p><strong>Proveedor:</strong> ${param.nombreProveedor}</p>
                <p><strong>Empleado:</strong> ${param.nombreEmpleado}</p>
                <p><strong>Fecha de Compra:</strong> ${param.fechaCompra}</p>
                <p><strong>Monto de Compra:</strong> ${param.montoCompra}</p>
                <!-- Add more details as needed -->

                <form method="post" action="/Ferreteria/?accion=EliminarCompra">
                    <input type="hidden" name="idCompra" value="${param.idCompra}" />
                    <!-- Add more hidden input fields as needed -->

                    <button type="submit" class="btn btn-danger">
                        <i class="fas fa-trash-alt"></i> Confirmar Eliminación
                    </button>
                </form>
            </div>
        </div>

        <a href="#" onclick="regresar()" class="btn btn-primary mt-3">
            <i class="fas fa-arrow-left"></i> Regresar
        </a>
    </div>

    <!-- Include your Bootstrap JS link and any other necessary scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

    <script>
        function regresar() {
            window.history.back();
        }
    </script>
</body>
</html>
