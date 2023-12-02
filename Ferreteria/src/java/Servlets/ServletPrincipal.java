/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import java.sql.Statement;

import Models.Categoria;
import Models.Empleado;
import Models.Cliente;
import Models.*;
import Models.Producto;
import Operaciones.Conexion;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import org.json.JSONArray;
import org.json.JSONObject;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.Optional;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ServletPrincipal extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ServletPrincipal</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ServletPrincipal at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }
public boolean verificarCredenciales(String usuario, String contrasenia) {
    try (Connection connection = Conexion.obtenerConexion();
         PreparedStatement pstmt = connection.prepareStatement("SELECT * FROM Usuarios WHERE Usuario = ? AND Clave = ?");
    ) {
        pstmt.setString(1, usuario);
        pstmt.setString(2, contrasenia);

        try (ResultSet rs = pstmt.executeQuery()) {
            return rs.next(); // Returns true if a record with the provided credentials exists
        }
    } catch (SQLException e) {
        // Handle the SQLException appropriately, e.g., log the error or throw a custom exception.
        e.printStackTrace(); // For demonstration purposes. In production, consider logging.
        return false; // Return false in case of an exception
    }
}

    public ArrayList<Cliente> mostrarClientes() {
        ArrayList<Cliente> listaClientes = new ArrayList<>();

        try (Connection connection = Conexion.obtenerConexion(); PreparedStatement pstmt = connection.prepareStatement("SELECT * FROM Clientes"); ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Cliente cliente = new Cliente();
                cliente.setIdCliente(rs.getInt("idCliente"));
                cliente.setDui(rs.getString("DUI"));
                cliente.setNombres(rs.getString("Nombres"));
                cliente.setApellidos(rs.getString("Apellidos"));
                cliente.setTelefono(rs.getString("Telefono"));
                listaClientes.add(cliente);
            }
        } catch (SQLException e) {
            // Manejar la excepción SQLException aquí, por ejemplo, registrar el error o lanzar una excepción personalizada.
            // Este es solo un ejemplo. En un entorno de producción, deberías manejar la excepción de forma adecuada.
        }
        return listaClientes;
    }
   

    public ArrayList<Categoria> mostrarCategorias() {
        ArrayList<Categoria> listaCategorias = new ArrayList<>();

        try (Connection connection = Conexion.obtenerConexion(); PreparedStatement pstmt = connection.prepareStatement("SELECT * FROM Categorias"); ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Categoria categoria = new Categoria();
                categoria.setIdCategoria(rs.getInt("idCategoria"));
                categoria.setNombre(rs.getString("nombre"));

                categoria.setDescripcion(rs.getString("descripcion"));
                listaCategorias.add(categoria);
            }
        } catch (SQLException e) {
            // Handle the SQLException here, e.g., log the error or throw a custom exception.
            // This is just an example. In a production environment, you should handle the exception appropriately.
        }
        return listaCategorias;

    }
public List<DetalleCompra> mostrarDetalleCompra(HttpServletResponse response) {
    List<DetalleCompra> detalleCompraList = new ArrayList<>();

    try (Connection connection = Conexion.obtenerConexion();
         PreparedStatement pstmt = connection.prepareStatement("SELECT * FROM DetalleCompras");
         ResultSet rs = pstmt.executeQuery()
    ) {
        while (rs.next()) {
            DetalleCompra detalleCompra = new DetalleCompra();
            detalleCompra.setIdDetalleCompra(rs.getInt("idDetalleCompra"));
            detalleCompra.setIdCompra(rs.getInt("idCompra"));
            detalleCompra.setIdProducto(rs.getInt("idProducto"));
            detalleCompra.setCantidad(rs.getInt("cantidad"));
            detalleCompra.setPrecioUnitario(rs.getDouble("precioUnitario"));

            // Assuming you have a Producto class
            Producto producto = new Producto();
            producto.setIdProducto(rs.getInt("idProducto"));
            // Set other properties of Producto if needed
            detalleCompra.setProducto(producto);

            detalleCompraList.add(detalleCompra);
        }
    } catch (SQLException e) {
        // Handle the SQLException appropriately, e.g., log the error or throw a custom exception.
        e.printStackTrace(); // For demonstration purposes. In production, consider logging.
    }

    return detalleCompraList;
}

public void agregarDetallePedido(HttpServletRequest request) {
    int idProducto = Integer.parseInt(request.getParameter("idProducto"));
    int cantidad = Integer.parseInt(request.getParameter("cantidad"));
    double precioUnitario = Double.parseDouble(request.getParameter("precioUnitario"));

    try (Connection connection = Conexion.obtenerConexion();
         PreparedStatement pstmt = connection.prepareStatement("INSERT INTO DetallePedidos (idProducto, cantidad, precioUnitario) VALUES (?, ?, ?)")) {

        pstmt.setInt(1, idProducto);  // Corrected variable name
        pstmt.setInt(2, cantidad);
        pstmt.setDouble(3, precioUnitario);

        pstmt.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace(); // Handle the exception appropriately, e.g., log the error or throw a custom exception.
    }
}

public List<DetallePedido> mostrarDetallePedido() {
    List<DetallePedido> detallesPedido = new ArrayList<>();

    try (Connection connection = Conexion.obtenerConexion();
         PreparedStatement pstmt = connection.prepareStatement("SELECT * FROM DetallePedidos d  JOIN Productos p ON d.idProducto = p.idProducto ");
         ResultSet rs = pstmt.executeQuery()) {

        while (rs.next()) {
            DetallePedido detallePedido = new DetallePedido();
            detallePedido.setIdDetallePedido(rs.getInt("idDetallePedido"));
            detallePedido.setIdProducto(rs.getInt("idProducto"));
            detallePedido.setCantidad(rs.getInt("cantidad"));
            detallePedido.setPrecioUnitario(rs.getDouble("precioUnitario"));

            // Assuming you have a Producto class
            Producto producto = new Producto();
            producto.setIdProducto(rs.getInt("idProducto"));
             producto.setNombre(rs.getString("Nombre"));
            // Set other properties of Producto if needed
            detallePedido.setProducto(producto);

            detallesPedido.add(detallePedido);
        }
    } catch (SQLException e) {
        e.printStackTrace(); // Handle the exception appropriately, e.g., log the error or throw a custom exception.
    }

    return detallesPedido;
}

private List<DetalleVenta> mostrarDetallesVenta() {
    List<DetalleVenta> detallesVenta = new ArrayList<>();

    try (Connection connection = Conexion.obtenerConexion();
         PreparedStatement pstmt = connection.prepareStatement("SELECT * FROM DetalleVentas d "+ " JOIN Productos p on d.idProducto = p.idProducto");
         ResultSet rs = pstmt.executeQuery()) {

        while (rs.next()) {
            DetalleVenta detalleVenta = new DetalleVenta();
            detalleVenta.setIdDetalleVenta(rs.getInt("idDetalleVenta"));
            detalleVenta.setVenta(rs.getInt("idVenta"));

            Producto producto = new Producto();
            producto.setIdProducto(rs.getInt("idProducto"));
            producto.setNombre(rs.getString("Nombre"));
            detalleVenta.setProducto(producto);

            detalleVenta.setCantidad(rs.getInt("cantidad"));

            detallesVenta.add(detalleVenta);
        }

    } catch (SQLException e) {
        e.printStackTrace(); // Handle the SQLException appropriately, e.g., log the error or throw a custom exception.
        // Return an empty list in case of exception
        
    }

    // Move the return statement outside the try block
    return detallesVenta;
}
public void eliminarDetalleVentas(HttpServletRequest request) {
     int idDetalleVenta= Integer.parseInt(request.getParameter("idDetalleVenta"));
    try (Connection connection = Conexion.obtenerConexion();
         PreparedStatement pstmt = connection.prepareStatement("DELETE FROM DetalleVentas WHERE idDetalleVenta = ?")) {

        pstmt.setInt(1, idDetalleVenta);

        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            System.out.println("DetalleVenta with ID " + idDetalleVenta + " deleted successfully.");
        } else {
            System.out.println("No DetalleVenta found with ID " + idDetalleVenta + ". No changes were made.");
        }

    } catch (SQLException e) {
        e.printStackTrace(); // Handle the SQLException appropriately, e.g., log the error or throw a custom exception.
    }
}
 private void modificarDetalleVentas(HttpServletRequest request) {
     int idDetalleVenta = Integer.parseInt(request.getParameter("idDetalleVenta"));
        int newVenta = Integer.parseInt(request.getParameter("venta"));
        int newProducto = Integer.parseInt(request.getParameter("idProducto"));
        int newCantidad = Integer.parseInt(request.getParameter("cantidad"));
        try (Connection connection = Conexion.obtenerConexion();
             PreparedStatement pstmt = connection.prepareStatement(
                     "UPDATE DetalleVentas SET idventa = ?, cantidad = ? , idProducto = ? WHERE idDetalleVenta = ?")) {

            pstmt.setInt(1, newVenta);
            pstmt.setInt(2, newCantidad);
            pstmt.setInt(3, newProducto);
            pstmt.setInt(4, idDetalleVenta);

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("DetalleVenta with ID " + idDetalleVenta + " modified successfully.");
            } else {
                System.out.println("No DetalleVenta found with ID " + idDetalleVenta + ". No changes were made.");
            }

        } catch (SQLException e) {
            e.printStackTrace(); // Handle the SQLException appropriately, e.g., log the error or throw a custom exception.
        }
    }private void agregarDetalleVentas(HttpServletRequest request) {
        
       
        int idProducto = Integer.parseInt(request.getParameter("idProducto"));
        int venta = Integer.parseInt(request.getParameter("venta"));
        int cantidad = Integer.parseInt(request.getParameter("cantidad"));
        try (Connection connection = Conexion.obtenerConexion();
             PreparedStatement pstmt = connection.prepareStatement(
                     "INSERT INTO DetalleVentas (idProducto, idventa, cantidad) VALUES (?, ?, ?)")) {

            pstmt.setInt(1, idProducto);
            pstmt.setInt(2, venta);
            pstmt.setInt(3, cantidad);

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("DetalleVenta added successfully.");
            } else {
                System.out.println("Failed to add DetalleVenta.");
            }

        } catch (SQLException e) {
            e.printStackTrace(); // Handle the SQLException appropriately, e.g., log the error or throw a custom exception.
        }
    }
    public void obtenerEmpleados(HttpServletResponse response) throws IOException {
        ArrayList<Empleado> listaEmpleados = new ArrayList<>();

        try (Connection connection = Conexion.obtenerConexion(); PreparedStatement pstmt = connection.prepareStatement("SELECT * FROM Empleados"); ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Empleado empleado = new Empleado();
                empleado.setIdEmpleado(rs.getInt("idEmpleado"));
                empleado.setDui(rs.getString("DUI"));
                empleado.setIsss(rs.getInt("ISSS"));
                empleado.setNombres(rs.getString("Nombres"));
                empleado.setApellidos(rs.getString("Apellidos"));
                empleado.setFechaNacEmpleado(rs.getDate("FechaNacEmpleado"));
                empleado.setTelefono(rs.getString("Telefono"));
                empleado.setCorreo(rs.getString("Correo"));
                empleado.setIdCargo(rs.getInt("ID_Cargo"));
                empleado.setIdDireccion(rs.getInt("ID_Direccion"));
                listaEmpleados.add(empleado);
            }
        } catch (SQLException e) {

        }

        // Convert the list to a JSON array
        JSONArray jsonArray = new JSONArray();
        for (Empleado empleado : listaEmpleados) {
            JSONObject jsonEmpleado = new JSONObject();
            jsonEmpleado.put("id", empleado.getIdEmpleado());
            jsonEmpleado.put("dui", empleado.getDui());
            jsonEmpleado.put("isss", empleado.getIsss());
            jsonEmpleado.put("nombre", empleado.getNombres());
            jsonEmpleado.put("apellidos", empleado.getApellidos());
            jsonEmpleado.put("fechaNacEmpleado", empleado.getFechaNacEmpleado());
            jsonEmpleado.put("telefono", empleado.getTelefono());
            jsonEmpleado.put("correo", empleado.getCorreo());
            jsonEmpleado.put("idCargo", empleado.getIdCargo());
            jsonEmpleado.put("idDireccion", empleado.getIdDireccion());
            jsonArray.put(jsonEmpleado);
        }

        // Send the JSON response to the client
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonArray.toString());
    }
    public void obtenerCategorias(HttpServletResponse response) throws IOException {
        ArrayList<Categoria> listaCategorias = new ArrayList<>();

        try (Connection connection = Conexion.obtenerConexion();
             PreparedStatement pstmt = connection.prepareStatement("SELECT * FROM Categorias");
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Categoria categoria = new Categoria();
                categoria.setIdCategoria(rs.getInt("idCategoria"));
                categoria.setNombre(rs.getString("nombre"));
                categoria.setDescripcion(rs.getString("descripcion"));
                listaCategorias.add(categoria);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Convertir la lista a un array JSON
        JSONArray jsonArray = new JSONArray();
        for (Categoria categoria : listaCategorias) {
            JSONObject jsonCategoria = new JSONObject();
            jsonCategoria.put("idCategoria", categoria.getIdCategoria());
            jsonCategoria.put("nombre", categoria.getNombre());
            jsonCategoria.put("descripcion", categoria.getDescripcion());
            jsonArray.put(jsonCategoria);
        }

        // Enviar la respuesta JSON al cliente
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonArray.toString());
    }
public void obtenerCargos(HttpServletResponse response) throws IOException {
    ArrayList<Cargo> listaCargos = new ArrayList<>();

    try (Connection connection = Conexion.obtenerConexion();
         PreparedStatement pstmt = connection.prepareStatement("SELECT * FROM Cargos");
         ResultSet rs = pstmt.executeQuery()) {

        while (rs.next()) {
            Cargo cargo = new Cargo();
            cargo.setIdCargo(rs.getInt("ID_Cargo"));
            cargo.setCargoNombre(rs.getString("Cargo"));
            listaCargos.add(cargo);
        }
    } catch (SQLException e) {
        // Handle SQLException
    }

    // Convert the list to a JSON array
    JSONArray jsonArray = new JSONArray();
    for (Cargo cargo : listaCargos) {
        JSONObject jsonCargo = new JSONObject();
        jsonCargo.put("idCargo", cargo.getIdCargo());
        jsonCargo.put("cargoNombre", cargo.getCargoNombre());
        jsonArray.put(jsonCargo);
    }

    // Send the JSON response to the client
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    response.getWriter().write(jsonArray.toString());
}

    public void obtenerProductos(HttpServletResponse response) throws IOException {
        ArrayList<Producto> listaProductos = new ArrayList<>();

        try (Connection connection = Conexion.obtenerConexion(); PreparedStatement pstmt = connection.prepareStatement("SELECT * FROM Productos where Activo=1"); ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Producto producto = new Producto();
                producto.setIdProducto(rs.getInt("idProducto"));
                producto.setNombre(rs.getString("nombre"));
                producto.setDescripcion(rs.getString("descripcion"));
                producto.setPrecio(rs.getDouble("precio"));
                producto.setStock(rs.getInt("stock"));
                producto.setIdCategoria(rs.getInt("idCategoria"));
                producto.setFechaCreacion(rs.getDate("fechaCreacion"));
                producto.setImagenURL(rs.getString("imagenURL"));
                producto.setFechaModificacion(rs.getDate("fechaModificacion"));
                producto.setActivo(rs.getBoolean("activo"));
                listaProductos.add(producto);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle the exception appropriately in a production environment
        }

        // Convert the list to a JSON array
        JSONArray jsonArray = new JSONArray();
        for (Producto producto : listaProductos) {
            JSONObject jsonProducto = new JSONObject();
            jsonProducto.put("id", producto.getIdProducto());
            jsonProducto.put("nombre", producto.getNombre());
            jsonProducto.put("descripcion", producto.getDescripcion());
            jsonProducto.put("precio", producto.getPrecio());
            jsonProducto.put("stock", producto.getStock());
            jsonProducto.put("idCategoria", producto.getIdCategoria());
            jsonProducto.put("fechaCreacion", producto.getFechaCreacion().toString());
            jsonProducto.put("imagenURL", producto.getImagenURL());

            jsonProducto.put("activo", producto.isActivo());
            jsonArray.put(jsonProducto);
        }

        // Send the JSON response to the client
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonArray.toString());
    }

    public void obtenerProveedores(HttpServletResponse response) throws IOException {
        ArrayList<Proveedor> listaProveedores = new ArrayList<>();

        try (Connection connection = Conexion.obtenerConexion(); PreparedStatement pstmt = connection.prepareStatement("SELECT * FROM Proveedores"); ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Proveedor proveedor = new Proveedor();
                proveedor.setIdProveedor(rs.getInt("idProveedor"));
                proveedor.setTelefono(rs.getString("Telefono"));
                proveedor.setIdDireccion(rs.getInt("idDireccion"));
                proveedor.setNombre(rs.getString("Nombre"));
                listaProveedores.add(proveedor);
            }
        } catch (SQLException e) {
        }

        // Convert the list to a JSON array
        JSONArray jsonArray = new JSONArray();
        for (Proveedor proveedor : listaProveedores) {
            JSONObject jsonProveedor = new JSONObject();
            jsonProveedor.put("id", proveedor.getIdProveedor());
            jsonProveedor.put("telefono", proveedor.getTelefono());
            jsonProveedor.put("idDireccion", proveedor.getIdDireccion());
            jsonProveedor.put("nombre", proveedor.getNombre());
            jsonArray.put(jsonProveedor);
        }

        // Send the JSON response to the client
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(jsonArray.toString());
    }

    private ArrayList<Empleado> mostrarEmpleados(HttpServletRequest request, HttpServletResponse response) {
        ArrayList<Empleado> listaEmpleados = new ArrayList<>();
         try (Connection connection = Conexion.obtenerConexion(); 
         PreparedStatement pstmt = connection.prepareStatement("SELECT e.*, c.Cargo as NombreCargo " +
                                                               "FROM Empleados e " +
                                                               "JOIN Cargos c ON e.ID_Cargo = c.ID_Cargo " +
                                                               "JOIN Direcciones d ON e.ID_Direccion = d.ID_Direccion");
         ResultSet rs = pstmt.executeQuery()) {                      
             while (rs.next()) {
                Empleado empleado = new Empleado();
                empleado.setIdEmpleado(rs.getInt("idEmpleado"));
                empleado.setDui(rs.getString("DUI"));
                empleado.setIsss(rs.getInt("ISSS"));
                empleado.setNombres(rs.getString("Nombres"));
                empleado.setApellidos(rs.getString("Apellidos"));
                empleado.setFechaNacEmpleado(rs.getDate("FechaNacEmpleado"));
                empleado.setTelefono(rs.getString("Telefono"));
                empleado.setCorreo(rs.getString("Correo"));
                empleado.setIdCargo(rs.getInt("ID_Cargo"));
                empleado.setIdDireccion(rs.getInt("ID_Direccion"));
                empleado.setNombreCargo(rs.getString("NombreCargo"));
                listaEmpleados.add(empleado);
            }
        } catch (SQLException e) {
            // Manejar la excepción SQLException aquí, por ejemplo, registrar el error o lanzar una excepción personalizada.
            // Este es solo un ejemplo. En un entorno de producción, deberías manejar la excepción de forma adecuada.
        }
        return listaEmpleados;
    }

    public void agregarCompra(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int proveedor = Integer.parseInt(Objects.requireNonNullElse(request.getParameter("proveedor"), "0"));
        int empleado = Integer.parseInt(request.getParameter("empleado"));

        Date fechaCompra = Optional.ofNullable(request.getParameter("fechaCompra"))
                .map(s -> {
                    try {
                        return new SimpleDateFormat("yyyy-MM-dd").parse(s);
                    } catch (ParseException e) {
                        return null;
                    }
                })
                .orElse(null);

        Item[] productos = Optional.ofNullable(request.getParameter("productos[]"))
                .map((String jsonArray) -> {
                    try {
                        ObjectMapper objectMapper = new ObjectMapper();

                        // Intenta deserializar como un array de Item
                        return objectMapper.readValue(jsonArray, Item[].class);

                    } catch (IOException e) {
                        try {
                            ObjectMapper objectMapper = new ObjectMapper();

                            // Intenta deserializar como un solo objeto Item dentro de un array
                            Item[] singleItemArray = objectMapper.readValue(jsonArray, Item[].class);
                            return singleItemArray;

                        } catch (IOException innerException) {
                            innerException.printStackTrace();
                            return new Item[0];
                        }
                    }
                })
                .orElse(new Item[0]);

        try (Connection conn = Conexion.obtenerConexion(); PreparedStatement pstmtCompra = conn.prepareStatement("INSERT INTO Compras (IDProveedor, IDEmpleado, FechaCompra) VALUES (?, ?, ?)", Statement.RETURN_GENERATED_KEYS); PreparedStatement pstmtDetalleCompra = conn.prepareStatement("INSERT INTO DetalleCompras (idCompra, idProducto, Cantidad, PrecioUnitario) VALUES (?, ?, ?, ?)")) {
            conn.setAutoCommit(false);
            pstmtCompra.setInt(1, proveedor);
            pstmtCompra.setInt(2, empleado);
            pstmtCompra.setDate(3, new java.sql.Date(fechaCompra.getTime()));

            int registrosCompra = pstmtCompra.executeUpdate();

            if (registrosCompra > 0) {
                ResultSet generatedKeys = pstmtCompra.getGeneratedKeys();
                int idCompra = 0;

                if (generatedKeys.next()) {
                    idCompra = generatedKeys.getInt(1);
                }
                System.out.println("el id es: " + idCompra);
                for (Item producto : productos) {
                    if (producto.getId() != 0) {
                        pstmtDetalleCompra.setInt(1, idCompra);
                        pstmtDetalleCompra.setInt(2, producto.getId());
                        pstmtDetalleCompra.setInt(3, producto.getCantidad());
                        pstmtDetalleCompra.setBigDecimal(4, producto.getPrecioUnitario());
                        pstmtDetalleCompra.addBatch();
                    }
                }

                int[] registrosDetalleCompra = pstmtDetalleCompra.executeBatch();

                if (registrosDetalleCompra.length > 0 && registrosDetalleCompra.length == productos.length) {
                    System.out.println("Compra guardada exitosamente");
                    conn.commit();
                } else {
                    System.out.println("Error al guardar detalles de la compra");
                    conn.rollback();
                }
            } else {
                System.out.println("Error al guardar la compra");
                conn.rollback();
            }
        } catch (SQLException e) {

            System.out.println("Error al guardar la compra: " + e.getMessage());
        }
    }
    

    public void modificarCompra(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int idCompra = Integer.parseInt(request.getParameter("idCompra")); // Assuming you have a parameter for the ID of the purchase to modify

        // Retrieve updated information from the request parameters
        int proveedor = Integer.parseInt(Objects.requireNonNullElse(request.getParameter("proveedor"), "0"));
        int empleado = Integer.parseInt(request.getParameter("empleado"));

        LocalDate fechaCompra = Optional.ofNullable(request.getParameter("fechaCompra"))
                .map(LocalDate::parse)
                .orElse(null);

        Item[] productos = Optional.ofNullable(request.getParameter("productos[]"))
                .map((String jsonArray) -> {
                    try {
                        ObjectMapper objectMapper = new ObjectMapper();
                        return objectMapper.readValue(jsonArray, Item[].class);
                    } catch (IOException e) {
                        e.printStackTrace();
                        return new Item[0];
                    }
                })
                .orElse(new Item[0]);

        try (Connection conn = Conexion.obtenerConexion(); PreparedStatement pstmtCompra = conn.prepareStatement("UPDATE Compras SET IDProveedor=?, IDEmpleado=?, FechaCompra=? WHERE IDCompra=?"); PreparedStatement pstmtDeleteDetalle = conn.prepareStatement("DELETE FROM DetalleCompras WHERE idCompra=?"); PreparedStatement pstmtInsertDetalle = conn.prepareStatement("INSERT INTO DetalleCompras (idCompra, idProducto, Cantidad, PrecioUnitario) VALUES (?, ?, ?, ?)")) {

            conn.setAutoCommit(false);
            pstmtCompra.setInt(1, proveedor);
            pstmtCompra.setInt(2, empleado);
            pstmtCompra.setDate(3, java.sql.Date.valueOf(fechaCompra));
            pstmtCompra.setInt(4, idCompra);

            int registrosCompra = pstmtCompra.executeUpdate();

            if (registrosCompra > 0) {
                pstmtDeleteDetalle.setInt(1, idCompra);
                pstmtDeleteDetalle.executeUpdate();

                for (Item producto : productos) {
                    if (producto.getId() != 0) {
                        pstmtInsertDetalle.setInt(1, idCompra);
                        pstmtInsertDetalle.setInt(2, producto.getId());
                        pstmtInsertDetalle.setInt(3, producto.getCantidad());
                        pstmtInsertDetalle.setBigDecimal(4, producto.getPrecioUnitario());
                        pstmtInsertDetalle.addBatch();
                    }
                }

                int[] registrosDetalleCompra = pstmtInsertDetalle.executeBatch();

                if (registrosDetalleCompra.length > 0 && registrosDetalleCompra.length == productos.length) {
                    System.out.println("Compra modificada exitosamente");
                    conn.commit();
                } else {
                    System.out.println("Error al modificar detalles de la compra");
                    conn.rollback();
                }
            } else {
                System.out.println("Error al modificar la compra");
                conn.rollback();
            }
        } catch (SQLException e) {
            System.out.println("Error al modificar la compra: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public void eliminarCompra(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int idCompra = Integer.parseInt(request.getParameter("idCompra")); // Assuming you have a parameter for the ID of the purchase to delete

        try (Connection conn = Conexion.obtenerConexion(); PreparedStatement pstmtDeleteDetalle = conn.prepareStatement("DELETE FROM DetalleCompras WHERE idCompra=?"); PreparedStatement pstmtDeleteCompra = conn.prepareStatement("DELETE FROM Compras WHERE IDCompra=?")) {

            conn.setAutoCommit(false);

            pstmtDeleteDetalle.setInt(1, idCompra);
            int registrosDetalleCompra = pstmtDeleteDetalle.executeUpdate();

            pstmtDeleteCompra.setInt(1, idCompra);
            int registrosCompra = pstmtDeleteCompra.executeUpdate();

            if (registrosDetalleCompra > 0 && registrosCompra > 0) {
                System.out.println("Compra eliminada exitosamente");
                conn.commit();
            } else {
                System.out.println("Error al eliminar la compra");
                conn.rollback();
            }
        } catch (SQLException e) {
            System.out.println("Error al eliminar la compra: " + e.getMessage());
            e.printStackTrace();
        }
    }
public ArrayList<Proveedor> mostrarProveedores() {
        ArrayList<Proveedor> listaProveedores = new ArrayList<>();

        try (Connection connection = Conexion.obtenerConexion(); PreparedStatement pstmt = connection.prepareStatement("SELECT * FROM Proveedores"); ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Proveedor proveedor = new Proveedor();
                proveedor.setIdProveedor(rs.getInt("idProveedor"));
                proveedor.setTelefono(rs.getString("telefono"));
                proveedor.setIdDireccion(rs.getInt("idDireccion"));
                proveedor.setNombre(rs.getString("nombre"));
                listaProveedores.add(proveedor);
            }
        } catch (SQLException e) {
            // Handle the SQLException here, for example, log the error or throw a custom exception.
            // This is just an example. In a production environment, you should handle the exception properly.
        }
        return listaProveedores;
    }
    public ArrayList<Compra> mostrarCompras() {
        ArrayList<Compra> listaCompras = new ArrayList<>();

        try (Connection connection = Conexion.obtenerConexion(); PreparedStatement pstmt = connection.prepareStatement(
                "SELECT c.idCompra, c.IDProveedor, p.Nombre AS NombreProveedor, c.IDEmpleado, e.Nombres AS NombreEmpleado, c.FechaCompra, c.MontoCompra, c.FechaCreacion, "
                + "d.idDetalleCompra, d.idProducto, d.cantidad, d.precioUnitario, "
                + "pr.nombre AS NombreProducto, pr.descripcion AS DescripcionProducto, pr.precio AS PrecioProducto, pr.stock AS StockProducto, pr.idCategoria AS IDCategoriaProducto, "
                + "pr.fechaCreacion AS FechaCreacionProducto, pr.imagenURL AS ImagenURLProducto, pr.fechaModificacion AS FechaModificacionProducto, pr.activo AS ActivoProducto "
                + "FROM Compras c "
                + "JOIN Proveedores p ON c.IDProveedor = p.IDProveedor "
                + "JOIN Empleados e ON c.IDEmpleado = e.IDEmpleado "
                + "JOIN DetalleCompras d ON c.idCompra = d.idCompra "
                + "JOIN Productos pr ON d.idProducto = pr.idProducto"
        ); ResultSet rs = pstmt.executeQuery()) {

            Map<Integer, Compra> mapaCompras = new HashMap<>();

            while (rs.next()) {
                int idCompra = rs.getInt("idCompra");
                Compra compra = mapaCompras.get(idCompra);

                if (compra == null) {
                    compra = new Compra();
                    compra.setIdCompra(idCompra);
                    compra.setIdProveedor(rs.getInt("IDProveedor"));
                    compra.setNombreProveedor(rs.getString("NombreProveedor"));
                    compra.setIdEmpleado(rs.getInt("IDEmpleado"));
                    compra.setNombreEmpleado(rs.getString("NombreEmpleado"));
                    compra.setFechaCompra(rs.getDate("FechaCompra"));
                    compra.setMontoCompra(rs.getDouble("MontoCompra"));
                    compra.setFechaCreacion(rs.getDate("FechaCreacion"));

                    mapaCompras.put(idCompra, compra);
                }

                DetalleCompra detalle = new DetalleCompra();
                detalle.setIdDetalleCompra(rs.getInt("idDetalleCompra"));
                detalle.setIdProducto(rs.getInt("idProducto"));
                detalle.setCantidad(rs.getInt("cantidad"));
                detalle.setPrecioUnitario(rs.getDouble("precioUnitario"));

                Producto producto = new Producto();
                producto.setIdProducto(rs.getInt("idProducto"));
                producto.setNombre(rs.getString("NombreProducto"));
                producto.setDescripcion(rs.getString("DescripcionProducto"));
                producto.setPrecio(rs.getDouble("PrecioProducto"));
                producto.setStock(rs.getInt("StockProducto"));
                producto.setIdCategoria(rs.getInt("IDCategoriaProducto"));
                producto.setFechaCreacion(rs.getDate("FechaCreacionProducto"));
                producto.setImagenURL(rs.getString("ImagenURLProducto"));
                producto.setFechaModificacion(rs.getDate("FechaModificacionProducto"));
                producto.setActivo(rs.getBoolean("ActivoProducto"));

                detalle.setProducto(producto);

                compra.getDetalleCompra().add(detalle);
            }

            listaCompras.addAll(mapaCompras.values());

        } catch (SQLException e) {

        }

        return listaCompras;
    }

    public ArrayList<Pedido> mostrarPedidos() {
        ArrayList<Pedido> listaPedidos = new ArrayList<>();

        try (Connection connection = Conexion.obtenerConexion(); PreparedStatement pstmt = connection.prepareStatement(
                "SELECT p.idPedido, p.Fecha, p.IDProveedor, pr.Nombre AS NombreProveedor, "
                + "p.Observaciones, p.CostoTotal, p.Estado, p.IDEmpleado, e.Nombres AS NombreEmpleado, p.FechaCreacion, "
                + "dp.idDetallePedido, dp.idProducto, dp.Cantidad, dp.PrecioUnitario, "
                + "pr1.Nombre AS NombreProducto, pr1.Descripcion AS DescripcionProducto, pr1.Precio AS PrecioProducto, pr1.Stock AS StockProducto, pr1.IDCategoria AS IDCategoriaProducto, "
                + "pr1.FechaCreacion AS FechaCreacionProducto, pr1.ImagenURL AS ImagenURLProducto, pr1.FechaModificacion AS FechaModificacionProducto, pr1.Activo AS ActivoProducto "
                + "FROM Pedidos p "
                + "JOIN Proveedores pr ON p.IDProveedor = pr.IDProveedor "
                + "JOIN Empleados e ON p.IDEmpleado = e.IDEmpleado "
                + "JOIN DetallePedidos dp ON p.idPedido = dp.idPedido "
                + "JOIN Productos pr1 ON dp.idProducto = pr1.idProducto"
        ); ResultSet rs = pstmt.executeQuery()) {

            Map<Integer, Pedido> mapaPedidos = new HashMap<>();

            while (rs.next()) {
                int idPedido = rs.getInt("idPedido");
                Pedido pedido = mapaPedidos.get(idPedido);

                if (pedido == null) {
                    pedido = new Pedido();
                    pedido.setIdPedido(idPedido);
                    pedido.setFecha(rs.getDate("Fecha"));
                    pedido.setIDProveedor(rs.getInt("IDProveedor"));
                    pedido.setNombreProveedor(rs.getString("NombreProveedor"));
                    pedido.setObservaciones(rs.getString("Observaciones"));
                    pedido.setCostoTotal(rs.getDouble("CostoTotal"));
                    pedido.setEstado(rs.getString("Estado"));
                    pedido.setIDEmpleado(rs.getInt("IDEmpleado"));
                    pedido.setNombreEmpleado(rs.getString("NombreEmpleado"));
                    pedido.setFechaCreacion(rs.getDate("FechaCreacion"));

                    mapaPedidos.put(idPedido, pedido);
                }

                DetallePedido detalle = new DetallePedido();
                detalle.setIdDetallePedido(rs.getInt("idDetallePedido"));
                detalle.setIdProducto(rs.getInt("idProducto"));
                detalle.setCantidad(rs.getInt("Cantidad"));
                detalle.setPrecioUnitario(rs.getDouble("PrecioUnitario"));

                Producto producto = new Producto();
                producto.setIdProducto(rs.getInt("idProducto"));
                producto.setNombre(rs.getString("NombreProducto"));
                producto.setDescripcion(rs.getString("DescripcionProducto"));
                producto.setPrecio(rs.getDouble("PrecioProducto"));
                producto.setStock(rs.getInt("StockProducto"));
                producto.setIdCategoria(rs.getInt("IDCategoriaProducto"));
                producto.setFechaCreacion(rs.getDate("FechaCreacionProducto"));
                producto.setImagenURL(rs.getString("ImagenURLProducto"));
                producto.setFechaModificacion(rs.getDate("FechaModificacionProducto"));
                producto.setActivo(rs.getBoolean("ActivoProducto"));

                detalle.setProducto(producto);

                pedido.getDetallePedidos().add(detalle);
            }

            listaPedidos.addAll(mapaPedidos.values());

        } catch (SQLException e) {
            // Manejo de excepciones
        }

        return listaPedidos;
    }

    public ArrayList<Venta> mostrarVentas() {
        ArrayList<Venta> listaVentas = new ArrayList<>();

        try (Connection connection = Conexion.obtenerConexion(); PreparedStatement pstmt = connection.prepareStatement(
                "SELECT v.idVenta, v.idCliente, c.Nombres AS NombreCliente, v.idEmpleado, e.Nombres AS NombreEmpleado, "
                + "v.FechaCompra, v.MontoCompra, v.FechaCreacion, dv.idDetalleVenta, dv.idProducto, dv.Cantidad, "
                + "p.Nombre AS NombreProducto, p.Descripcion AS DescripcionProducto, p.Precio AS PrecioProducto, "
                + "p.Stock AS StockProducto, p.IDCategoria AS IDCategoriaProducto, p.FechaCreacion AS FechaCreacionProducto, "
                + "p.ImagenURL AS ImagenURLProducto, p.FechaModificacion AS FechaModificacionProducto, p.Activo AS ActivoProducto "
                + "FROM Ventas v "
                + "JOIN Clientes c ON v.idCliente = c.idCliente "
                + "JOIN Empleados e ON v.idEmpleado = e.idEmpleado "
                + "JOIN DetalleVentas dv ON v.idVenta = dv.idVenta "
                + "JOIN Productos p ON dv.idProducto = p.idProducto"
        ); ResultSet rs = pstmt.executeQuery()) {

            Map<Integer, Venta> mapaVentas = new HashMap<>();

            while (rs.next()) {
                int idVenta = rs.getInt("idVenta");
                Venta venta = mapaVentas.get(idVenta);
               
                if (venta == null) {
                    venta = new Venta();
                    venta.setIdVenta(idVenta);
                    // Create Cliente object and set its properties
                    Cliente cliente = new Cliente();
                    cliente.setIdCliente(rs.getInt("idCliente"));
                    cliente.setNombres(rs.getString("NombreCliente"));
                    // Set Cliente object in Venta
                    venta.setCliente(cliente);
                    // Create Empleado object and set its properties
                    Empleado empleado = new Empleado();
                    empleado.setIdEmpleado(rs.getInt("idEmpleado"));
                    empleado.setNombres(rs.getString("NombreEmpleado"));
                    // Set Empleado object in Venta
                    venta.setEmpleado(empleado);
                    venta.setFechaCompra(rs.getDate("FechaCompra"));
                    venta.setMontoCompra(rs.getDouble("MontoCompra"));
                    venta.setFechaCreacion(rs.getDate("FechaCreacion"));

                    mapaVentas.put(idVenta, venta);
                }

                DetalleVenta detalleVenta = new DetalleVenta();
                detalleVenta.setIdDetalleVenta(rs.getInt("idDetalleVenta"));
                
                
                detalleVenta.setCantidad(rs.getInt("Cantidad"));

                Producto producto = new Producto();
                producto.setIdProducto(rs.getInt("idProducto"));
                producto.setNombre(rs.getString("NombreProducto"));
                producto.setDescripcion(rs.getString("DescripcionProducto"));
                producto.setPrecio(rs.getDouble("PrecioProducto"));
                producto.setStock(rs.getInt("StockProducto"));
                producto.setIdCategoria(rs.getInt("IDCategoriaProducto"));
                producto.setFechaCreacion(rs.getDate("FechaCreacionProducto"));
                producto.setImagenURL(rs.getString("ImagenURLProducto"));
                producto.setFechaModificacion(rs.getDate("FechaModificacionProducto"));
                producto.setActivo(rs.getBoolean("ActivoProducto"));

                detalleVenta.setProducto(producto);

                venta.getDetalleVentas().add(detalleVenta);
            }

            listaVentas.addAll(mapaVentas.values());

        } catch (SQLException e) {
           e.printStackTrace();
        }

        return listaVentas;
    }

    public ArrayList<Compra> mostrarComprasPorId(HttpServletRequest request) {
        int idCompra = Integer.parseInt(request.getParameter("idCompra"));
        ArrayList<Compra> listaCompras = new ArrayList<>();

        try (Connection connection = Conexion.obtenerConexion(); PreparedStatement pstmt = connection.prepareStatement(
                "SELECT c.idCompra, c.IDProveedor, p.Nombre AS NombreProveedor, c.IDEmpleado, e.Nombres AS NombreEmpleado, c.FechaCompra, c.MontoCompra, c.FechaCreacion, "
                + "d.idDetalleCompra, d.idProducto, d.cantidad, d.precioUnitario, "
                + "pr.nombre AS NombreProducto, pr.descripcion AS DescripcionProducto, pr.precio AS PrecioProducto, pr.stock AS StockProducto, pr.idCategoria AS IDCategoriaProducto, "
                + "pr.fechaCreacion AS FechaCreacionProducto, pr.imagenURL AS ImagenURLProducto, pr.fechaModificacion AS FechaModificacionProducto, pr.activo AS ActivoProducto "
                + "FROM Compras c "
                + "JOIN Proveedores p ON c.IDProveedor = p.IDProveedor "
                + "JOIN Empleados e ON c.IDEmpleado = e.IDEmpleado "
                + "JOIN DetalleCompras d ON c.idCompra = d.idCompra "
                + "JOIN Productos pr ON d.idProducto = pr.idProducto "
                + "WHERE c.idCompra = ?"
        )) {

            pstmt.setInt(1, idCompra);

            try (ResultSet rs = pstmt.executeQuery()) {

                Map<Integer, Compra> mapaCompras = new HashMap<>();

                while (rs.next()) {
                    int idCompraResultado = rs.getInt("idCompra");
                    Compra compra = mapaCompras.get(idCompraResultado);

                    if (compra == null) {
                        compra = new Compra();
                        compra.setIdCompra(idCompraResultado);
                        compra.setIdProveedor(rs.getInt("IDProveedor"));
                        compra.setNombreProveedor(rs.getString("NombreProveedor"));
                        compra.setIdEmpleado(rs.getInt("IDEmpleado"));
                        compra.setNombreEmpleado(rs.getString("NombreEmpleado"));
                        compra.setFechaCompra(rs.getDate("FechaCompra"));
                        compra.setMontoCompra(rs.getDouble("MontoCompra"));
                        compra.setFechaCreacion(rs.getDate("FechaCreacion"));

                        mapaCompras.put(idCompraResultado, compra);
                    }

                    DetalleCompra detalle = new DetalleCompra();
                    detalle.setIdDetalleCompra(rs.getInt("idDetalleCompra"));
                    detalle.setIdProducto(rs.getInt("idProducto"));
                    detalle.setCantidad(rs.getInt("cantidad"));
                    detalle.setPrecioUnitario(rs.getDouble("precioUnitario"));

                    Producto producto = new Producto();
                    producto.setIdProducto(rs.getInt("idProducto"));
                    producto.setNombre(rs.getString("NombreProducto"));
                    producto.setDescripcion(rs.getString("DescripcionProducto"));
                    producto.setPrecio(rs.getDouble("PrecioProducto"));
                    producto.setStock(rs.getInt("StockProducto"));
                    producto.setIdCategoria(rs.getInt("IDCategoriaProducto"));
                    producto.setFechaCreacion(rs.getDate("FechaCreacionProducto"));
                    producto.setImagenURL(rs.getString("ImagenURLProducto"));
                    producto.setFechaModificacion(rs.getDate("FechaModificacionProducto"));
                    producto.setActivo(rs.getBoolean("ActivoProducto"));

                    detalle.setProducto(producto);

                    compra.getDetalleCompra().add(detalle);
                }

                listaCompras.addAll(mapaCompras.values());
            }
        } catch (SQLException e) {
            // Manejar la excepción
            e.printStackTrace();
        }

        return listaCompras;
    }

    public ArrayList<Producto> mostrarProductos() {
    ArrayList<Producto> listaProductos = new ArrayList<>();

    try (Connection connection = Conexion.obtenerConexion(); 
         PreparedStatement pstmt = connection.prepareStatement("SELECT P.*, C.Nombre AS CategoriaNombre FROM Productos P INNER JOIN Categorias C ON P.IdCategoria = C.IdCategoria");
         ResultSet rs = pstmt.executeQuery()) {

        while (rs.next()) {
            Producto producto = new Producto();
            producto.setIdProducto(rs.getInt("idProducto"));
            producto.setNombre(rs.getString("Nombre"));
            producto.setDescripcion(rs.getString("Descripcion"));
            producto.setPrecio(rs.getDouble("Precio"));
            producto.setStock(rs.getInt("Stock"));
            producto.setIdCategoria(rs.getInt("IdCategoria"));
            producto.setFechaCreacion(rs.getDate("FechaCreacion"));
            producto.setImagenURL(rs.getString("ImagenURL"));
            producto.setFechaModificacion(rs.getDate("FechaModificacion"));
            producto.setActivo(rs.getBoolean("Activo"));
            producto.setCategoriaNombre(rs.getString("CategoriaNombre")); // Nuevo campo

            listaProductos.add(producto);
        }
    } catch (SQLException e) {
        // Manejar la excepción, por ejemplo, imprimir un mensaje de error
        e.printStackTrace();
    }

    return listaProductos;
}
    
    public void agregarProducto(HttpServletRequest request) {
    String nombre = request.getParameter("nombre");
    String descripcion = request.getParameter("descripcion");
    double precio = Double.parseDouble(request.getParameter("precio"));
    int stock = Integer.parseInt(request.getParameter("stock"));
    int idCategoria = Integer.parseInt(request.getParameter("idCategoria"));
    String imagenURL = request.getParameter("imagenURL");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        conn = Conexion.obtenerConexion();
        String sql = "INSERT INTO Productos (Nombre, Descripcion, Precio, Stock, IdCategoria, ImagenURL) VALUES (?, ?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, nombre);
        pstmt.setString(2, descripcion);
        pstmt.setDouble(3, precio);
        pstmt.setInt(4, stock);
        pstmt.setInt(5, idCategoria);
        pstmt.setString(6, imagenURL);

        int registros = pstmt.executeUpdate();

        if (registros > 0) {
            System.out.println("Producto agregado correctamente.");
        } else {
            System.out.println("No se pudo agregar el producto. Por favor, revise los datos y vuelva a intentarlo.");
        }
    } catch (SQLException e) {
        // Handle the exception (print, log, or set appropriate error messages)
        e.printStackTrace();
        System.out.println("Error al agregar el producto: " + e.getMessage());
    } finally {
        try {
            if (pstmt != null) {
                pstmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

public void modificarDetallePedido(HttpServletRequest request) {
    int idDetallePedido = Integer.parseInt(request.getParameter("idDetallePedido"));
    int nuevaCantidad = Integer.parseInt(request.getParameter("cantidad"));
    double nuevoPrecioUnitario = Double.parseDouble(request.getParameter("precioUnitario"));

    try (Connection connection = Conexion.obtenerConexion();
         PreparedStatement pstmt = connection.prepareStatement("UPDATE DetallePedidos SET cantidad = ?, precioUnitario = ? WHERE idDetallePedido = ?")) {

        pstmt.setInt(1, nuevaCantidad);
        pstmt.setDouble(2, nuevoPrecioUnitario);
        pstmt.setInt(3, idDetallePedido);

        pstmt.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace(); // Handle the exception appropriately, e.g., log the error or throw a custom exception.
    }
}
public void modificarProducto(HttpServletRequest request) {
    int idProducto = Integer.parseInt(request.getParameter("idProducto"));
    String nombre = request.getParameter("nombre");
    String descripcion = request.getParameter("descripcion");
    double precio = Double.parseDouble(request.getParameter("precio"));
    int stock = Integer.parseInt(request.getParameter("stock"));
    int idCategoria = Integer.parseInt(request.getParameter("idCategoria"));
    String imagenURL = request.getParameter("imagenURL");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        conn = Conexion.obtenerConexion();
        String sql = "UPDATE Productos SET Nombre=?, Descripcion=?, Precio=?, Stock=?, IdCategoria=?, ImagenURL=? WHERE IdProducto=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, nombre);
        pstmt.setString(2, descripcion);
        pstmt.setDouble(3, precio);
        pstmt.setInt(4, stock);
        pstmt.setInt(5, idCategoria);
        pstmt.setString(6, imagenURL);
        pstmt.setInt(7, idProducto);

        int registros = pstmt.executeUpdate();

        if (registros > 0) {
            System.out.println("Producto modificado correctamente.");
        } else {
            System.out.println("No se pudo modificar el producto. Por favor, revise los datos y vuelva a intentarlo.");
        }
    } catch (SQLException e) {
        // Handle the exception (print, log, or set appropriate error messages)
        e.printStackTrace();
        System.out.println("Error al modificar el producto: " + e.getMessage());
    } finally {
        try {
            if (pstmt != null) {
                pstmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

public void eliminarDetallePedido(HttpServletRequest request) {
    int idDetallePedido = Integer.parseInt(request.getParameter("idDetallePedido"));

    try (Connection connection = Conexion.obtenerConexion();
         PreparedStatement pstmt = connection.prepareStatement("DELETE FROM DetallePedidos WHERE idDetallePedido = ?")) {

        pstmt.setInt(1, idDetallePedido);

        pstmt.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace(); // Handle the exception appropriately, e.g., log the error or throw a custom exception.
    }
}

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        if (null == accion) {
            request.getRequestDispatcher("/Login.jsp").forward(request, response);
        } else {
            switch (accion) {
                case "Login" ->
                    request.getRequestDispatcher("/Login.jsp").forward(request, response);
                case "RegistrarEmpleados" ->
                    request.getRequestDispatcher("/RegistrarEmpleados.html").forward(request, response);
                case "RegistrarCategorias" ->
                    request.getRequestDispatcher("/RegistrarCategorias.html").forward(request, response);
                case "RegistrarCompras" ->
                    request.getRequestDispatcher("/RegistrarCompras.html").forward(request, response);
                case "RegistrarVentas" ->
                    request.getRequestDispatcher("/RegistrarVentas.html").forward(request, response);
                case "RegistrarClientes" ->
                    request.getRequestDispatcher("/RegistrarClientes.html").forward(request, response);
                case "RegistrarProveedores" ->
                    request.getRequestDispatcher("/RegistrarProveedores.html").forward(request, response);
                case "AgregarProducto" ->
                    request.getRequestDispatcher("/opcionesUsuario/AgregarProducto.jsp").forward(request, response);
                    
                case "GestionarEmpleados" -> {
                    request.setAttribute("empleadosList", mostrarEmpleados(request, response));
                    request.getRequestDispatcher("/GestionarEmpleados.jsp").forward(request, response);
                }
                case "GestionarClientes" -> {
                    request.setAttribute("clientesList", mostrarClientes());
                    request.getRequestDispatcher("/GestionarClientes.jsp").forward(request, response);
                }
                case "GestionarCategorias" -> {
                    request.setAttribute("categoriasList", mostrarCategorias());
                    request.getRequestDispatcher("/GestionarCategoria.jsp").forward(request, response);
                }
                case "GestionarProductos" -> {
                    request.setAttribute("productosList", mostrarProductos());
                    request.getRequestDispatcher("/GestionarProductos.jsp").forward(request, response);
                }
                case "GestionarCompras" -> {
                    request.setAttribute("comprasList", mostrarCompras());
                    request.getRequestDispatcher("/GestionarCompras.jsp").forward(request, response);
                }
                case "GestionarPedidos" -> {
                    request.setAttribute("pedidosList", mostrarPedidos());
                    request.getRequestDispatcher("/GestionarPedidos.jsp").forward(request, response);
                }
                 case "GestionarDetallePedidos" -> {
                    request.setAttribute("pedidosList", mostrarDetallePedido());
                    request.getRequestDispatcher("/GestionarDetallePedidos.jsp").forward(request, response);
                }
                 case "GestionarVentas" -> {
                    request.setAttribute("ventasList", mostrarVentas());
                    
                    request.getRequestDispatcher("/GestionarVentas.jsp").forward(request, response);
                }
                  case "GestionarDetalleVentas" -> {
                    request.setAttribute("ventasDetalleList", mostrarDetallesVenta());
                    
                    request.getRequestDispatcher("/GestionarDetalleVentas.jsp").forward(request, response);
                }
                 case "GestionarProveedores" -> {
                    request.setAttribute("proveedoresList", mostrarProveedores());
                    
                    request.getRequestDispatcher("/GestionarProveedores.jsp").forward(request, response);
                }
                 case "GestionarDetalleCompras" -> {
                    request.setAttribute("comprasDetalleList", mostrarDetalleCompra(response));
                    
                    request.getRequestDispatcher("/GestionarDetalleCompras.jsp").forward(request, response);
                }
                case "AgregarCompra" -> {

                    request.getRequestDispatcher("opcionesUsuario/AgregarCompra.jsp").forward(request, response);
                }
                case "ObtenerEmpleados" -> {
                    obtenerEmpleados(response);

                }
                case "ObtenerProveedores" -> {
                    obtenerProveedores(response);

                }
                case "ObtenerCargos" -> {
                    obtenerCargos(response);

                }
                case "ObtenerProductos" -> {
                    obtenerProductos(response);

                }
                 case "ObtenerCategoria" -> {
                    obtenerCategorias(response);

                }
                case "MostrarComprasPorId" -> {
                    request.setAttribute("comprasList", mostrarComprasPorId(request));

                    request.getRequestDispatcher("opcionesUsuario/ModificarCompra.jsp").forward(request, response);
                }

                default -> {
                    request.getRequestDispatcher("/error404").forward(request, response);
                }
            }
        }

    }
public void eliminarProducto(HttpServletRequest request) {
    int idProducto = Integer.parseInt(request.getParameter("idProducto"));

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        conn = Conexion.obtenerConexion();
        String sql = "DELETE FROM Productos WHERE IdProducto=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, idProducto);

        int registros = pstmt.executeUpdate();

        if (registros > 0) {
            System.out.println("Producto eliminado correctamente.");
        } else {
            System.out.println("No se pudo eliminar el producto. Asegúrese de que el producto exista.");
        }
    } catch (SQLException e) {
        // Handle the exception (print, log, or set appropriate error messages)
        e.printStackTrace();
        System.out.println("Error al eliminar el producto: " + e.getMessage());
    } finally {
        try {
            if (pstmt != null) {
                pstmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");

        if (accion.equals("Login")) {
            String usuario = request.getParameter("tfUsuario");
            String contrasenia = request.getParameter("tfContrasenia");

            try (PrintWriter print = response.getWriter()) {
                if (verificarCredenciales(usuario, contrasenia)) {

                    request.getRequestDispatcher("/PanelAdministrador.jsp").forward(request, response);
                } else {
                    print.println("<!DOCTYPE html>");
                    print.println("<html>");
                    print.println("<head>");
                    print.println("<title>Login Sistema </title>");
                    print.println("</head>");
                    print.println("<body>");
                    print.println("<h2>Error: La contraseña o el usuario son erróneos</h2>");
                    print.println("</body>");
                    print.println("</html>");
                }
            }
        }
        switch (accion) {
            case "AgregarEmpleado" -> {
                // LOS DATOS SE LE PASAN POR PARÁMETROS A LA FUNCIÓN
                agregarEmpleado(request, response);
                // REDIRIGE NUEVAMENTE A LA VISTA DE AGREGAR EMPLEADO
                response.sendRedirect(request.getContextPath() + "/ServletPrincipal?accion=GestionarEmpleados");
            }
            case "ModificarEmpleado" -> {
                modificarEmpleado(request, response);
                response.sendRedirect(request.getContextPath() + "/ServletPrincipal?accion=GestionarEmpleados");
            }
            case "EliminarEmpleado" -> {
                eliminarEmpleado(request, response);
                response.sendRedirect(request.getContextPath() + "/ServletPrincipal?accion=GestionarEmpleados");
            }
            case "AgregarCliente" -> {
                agregarCliente(request, response);
                response.sendRedirect(request.getContextPath() + "/ServletPrincipal?accion=GestionarCliente");
            }
            case "ModificarCliente" -> {
                modificarCliente(request, response);
                response.sendRedirect(request.getContextPath() + "/ServletPrincipal?accion=GestionarClientes");
            }
            case "EliminarCliente" -> {
                eliminarCliente(request, response);
                response.sendRedirect(request.getContextPath() + "/ServletPrincipal?accion=GestionarClientes");
            }
            case "AgregarCategoria" -> {
                agregarCategoria(request, response);
                response.sendRedirect(request.getContextPath() + "/ServletPrincipal?accion=GestionarCategorias");
            }case "AgregarProveedor" -> {
               agregarProveedor(request);
                response.sendRedirect(request.getContextPath() + "/ServletPrincipal?accion=GestionarProveedores");
            }
            case "ModificarProveedor" -> {
                modificarProveedor(request);
                response.sendRedirect(request.getContextPath() + "/ServletPrincipal?accion=GestionarProveedores");
            }
             case "EliminarProveedor" -> {
                eliminarProveedor(request);
                response.sendRedirect(request.getContextPath() + "/ServletPrincipal?accion=GestionarProveedores");
            }
             case "EliminarProducto" -> {
                 eliminarProducto(request);
                response.sendRedirect(request.getContextPath() + "/ServletPrincipal?accion=GestionarProductos");
            }
             case "AgregarDetalleVenta" -> {
                 agregarDetalleVentas(request);
                response.sendRedirect(request.getContextPath() + "/ServletPrincipal?accion=GestionarDetalleVentas");
            }
             case "ModificarDetalleVenta" -> {
             modificarDetalleVentas(request);
                response.sendRedirect(request.getContextPath() + "/ServletPrincipal?accion=GestionarDetalleVentas");
            }
             case "EliminarDetalleVenta" -> {
                 eliminarDetalleVentas(request);
                response.sendRedirect(request.getContextPath() + "/ServletPrincipal?accion=GestionarDetalleVentas");
            }
            case "ModificarCategoria" -> {
                modificarCategoria(request, response);
                response.sendRedirect(request.getContextPath() + "/ServletPrincipal?accion=GestionarCategorias");
            }
            case "EliminarCategoria" -> {
                eliminarCategoria(request, response);
                response.sendRedirect(request.getContextPath() + "/ServletPrincipal?accion=GestionarCategorias");
            }
            case "AgregarCompras" -> {
                agregarCompra(request, response);
                response.sendRedirect(request.getContextPath() + "/ServletPrincipal?accion=GestionarCompras");
            }
             case "AgregarProducto" -> {
                agregarProducto(request);
                response.sendRedirect(request.getContextPath() + "/ServletPrincipal?accion=GestionarProductos");
            }
              case "ModificarProducto" -> {
                  modificarProducto(request);
                response.sendRedirect(request.getContextPath() + "/ServletPrincipal?accion=GestionarProductos");
            }
            case "ModificarCompra" -> {
                modificarCompra(request, response);
                response.sendRedirect(request.getContextPath() + "/ServletPrincipal?accion=GestionarCompras");
            } case "EliminarCompra" -> {
                eliminarCompra(request, response);
                response.sendRedirect(request.getContextPath() + "/ServletPrincipal?accion=GestionarCompras");
            }
             case "AgregarDetallePedido" -> {
                 agregarDetallePedido(request);
                response.sendRedirect(request.getContextPath() + "/ServletPrincipal?accion=GestionarDetallePedidos");
            }
             case "ModificarDetallePedido" -> {
                 modificarDetallePedido(request);
                response.sendRedirect(request.getContextPath() + "/ServletPrincipal?accion=GestionarDetallePedidos");
            }
             case "EliminarDetallePedido" -> {
                 eliminarDetallePedido(request);
                response.sendRedirect(request.getContextPath() + "/ServletPrincipal?accion=GestionarDetallePedidos");
            }
            default -> {
                request.getRequestDispatcher("/error404").forward(request, response);
            }
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
public void agregarPedido() {
    try (Connection connection = Conexion.obtenerConexion(); PreparedStatement pstmt = connection.prepareStatement(
            "INSERT INTO Pedidos (Fecha, IDProveedor, Observaciones, CostoTotal, Estado, IDEmpleado, FechaCreacion) "
            + "VALUES (?, ?, ?, ?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS)) {
Pedido nuevoPedido = new Pedido();
        pstmt.setDate(1, new java.sql.Date(nuevoPedido.getFecha().getTime()));
        pstmt.setInt(2, nuevoPedido.getIDProveedor());
        pstmt.setString(3, nuevoPedido.getObservaciones());
        pstmt.setDouble(4, nuevoPedido.getCostoTotal());
        pstmt.setString(5, nuevoPedido.getEstado());
        pstmt.setInt(6, nuevoPedido.getIDEmpleado());
        pstmt.setDate(7, new java.sql.Date(nuevoPedido.getFechaCreacion().getTime()));

        int affectedRows = pstmt.executeUpdate();

        if (affectedRows > 0) {
            try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    int idPedidoGenerado = generatedKeys.getInt(1);

                    // Ahora, inserta los detalles del pedido
                    for (DetallePedido detalle : nuevoPedido.getDetallePedidos()) {
                        try (PreparedStatement pstmtDetalle = connection.prepareStatement(
                                "INSERT INTO DetallePedidos (idPedido, idProducto, Cantidad, PrecioUnitario) "
                                + "VALUES (?, ?, ?, ?)")) {

                            pstmtDetalle.setInt(1, idPedidoGenerado);
                            pstmtDetalle.setInt(2, detalle.getIdProducto());
                            pstmtDetalle.setInt(3, detalle.getCantidad());
                            pstmtDetalle.setDouble(4, detalle.getPrecioUnitario());

                            pstmtDetalle.executeUpdate();
                        }
                    }
                } else {
                    // No se generó la clave, manejar el error
                }
            }
        } else {
            // No se insertó ninguna fila, manejar el error
        }

    } catch (SQLException e) {
        // Manejo de excepciones
    }
}

    private void agregarCategoria(HttpServletRequest request, HttpServletResponse response) {
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = Conexion.obtenerConexion();
            String sql = "INSERT INTO Categorias (Nombre, Descripcion) VALUES (?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, nombre);
            pstmt.setString(2, descripcion);

            int registros = pstmt.executeUpdate();

            if (registros > 0) {
                request.getSession().setAttribute("exito", true);
                request.getSession().setAttribute("mensaje", "Categoría agregada correctamente.");
            } else {
                request.getSession().setAttribute("exito", false);
                request.getSession().setAttribute("mensaje", "No se pudo agregar la categoría. Por favor, revise los datos y vuelva a intentarlo.");
            }
        } catch (SQLException e) {

            request.getSession().setAttribute("exito", false);
            request.getSession().setAttribute("mensaje", "Error al agregar la categoría: " + e.getMessage());
        } finally {
            try {
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {

            }
        }
    }

private void agregarEmpleado(HttpServletRequest request, HttpServletResponse response) {
    String dui = request.getParameter("dui");
    String isss = request.getParameter("isss");
    String nombres = request.getParameter("nombres");
    String apellidos = request.getParameter("apellidos");
    String fechaNacimiento = request.getParameter("fechaNacEmpleado");
    String telefono = request.getParameter("telefono");
    String correo = request.getParameter("correo");
    
    // Validate and parse integers
    int idCargo = 0;
    int idDireccion = 0;

    try {
        String idCargoParameter = request.getParameter("idCargo");
        String idDireccionParameter = request.getParameter("idDireccion");

        if (idCargoParameter != null && !idCargoParameter.isEmpty()) {
            idCargo = Integer.parseInt(idCargoParameter);
        }

        if (idDireccionParameter != null && !idDireccionParameter.isEmpty()) {
            idDireccion = Integer.parseInt(idDireccionParameter);
        }
    } catch (NumberFormatException e) {
        // Handle the exception (print, log, or set appropriate error messages)
        e.printStackTrace();
        request.getSession().setAttribute("exito", false);
        request.getSession().setAttribute("mensaje", "Error en la conversión de datos: " + e.getMessage());
        return; // Exit the method if there's an issue with parsing integers
    }

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        conn = Conexion.obtenerConexion();
        String sql = "INSERT INTO Empleados (DUI, ISSS, Nombres, Apellidos, FechaNacEmpleado, Telefono, Correo, ID_Cargo, ID_Direccion) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, dui);
        pstmt.setString(2, isss);
        pstmt.setString(3, nombres);
        pstmt.setString(4, apellidos);
        pstmt.setString(5, fechaNacimiento);
        pstmt.setString(6, telefono);
        pstmt.setString(7, correo);
        pstmt.setInt(8, idCargo);
        pstmt.setInt(9, idDireccion);

        int registros = pstmt.executeUpdate();

        if (registros > 0) {
            request.getSession().setAttribute("exito", true);
            request.getSession().setAttribute("mensaje", "Empleado agregado correctamente.");
        } else {
            request.getSession().setAttribute("exito", false);
            request.getSession().setAttribute("mensaje", "No se pudo agregar el empleado. Por favor, revise los datos y vuelva a intentarlo.");
            System.out.println("Error");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        request.getSession().setAttribute("exito", false);
        request.getSession().setAttribute("mensaje", "Error al agregar el empleado: " + e.getMessage());
    } finally {
        try {
            if (pstmt != null) {
                pstmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}


    private void modificarEmpleado(HttpServletRequest request, HttpServletResponse response) {
        try {

            Connection conn = Conexion.obtenerConexion();

            String sql = "UPDATE Empleados SET DUI=?, ISSS=?, Nombres=?, Apellidos=?, FechaNacEmpleado=?, Telefono=?, Correo=?, ID_Cargo=?, ID_Direccion=? WHERE idEmpleado=?";

            String dui = request.getParameter("dui");
            String isss = request.getParameter("isss");
            String nombres = request.getParameter("nombres");
            String apellidos = request.getParameter("apellidos");
            String fechaNacimiento = request.getParameter("fechaNacimiento");
            String telefono = request.getParameter("telefono");
            String correo = request.getParameter("correo");
            int idCargo = Integer.parseInt(request.getParameter("idCargo"));
            int idDireccion = Integer.parseInt(request.getParameter("idDireccion"));
            int idEmpleado = Integer.parseInt(request.getParameter("idEmpleado"));
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dui);
            pstmt.setString(2, isss);
            pstmt.setString(3, nombres);
            pstmt.setString(4, apellidos);
            pstmt.setString(5, fechaNacimiento);
            pstmt.setString(6, telefono);
            pstmt.setString(7, correo);
            pstmt.setInt(8, idCargo);
            pstmt.setInt(9, idDireccion);
            pstmt.setInt(10, idEmpleado);

            int registros = pstmt.executeUpdate();

            if (registros > 0) {
                request.getSession().setAttribute("exito", true);
            } else {
                request.getSession().setAttribute("exito", false);
            }

            conn.close();
        } catch (SQLException ex) {
            request.getSession().setAttribute("exito", false);
        }
    }

    private void eliminarEmpleado(HttpServletRequest request, HttpServletResponse response) {
        int idEmpleado = Integer.parseInt(request.getParameter("idEmpleado"));

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = Conexion.obtenerConexion();
            String sql = "DELETE FROM Empleados where idEmpleado = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, idEmpleado);

            int filasAfectadas = pstmt.executeUpdate();

            if (filasAfectadas > 0) {
                // La eliminación se realizó con éxito
                // Puedes redirigir o mostrar un mensaje de éxito
                request.getSession().setAttribute("exito", true);
                request.getSession().setAttribute("mensaje", "Empleado eliminado correctamente.");
            } else {
                // No se encontró el registro para eliminar
                // Puedes redirigir o mostrar un mensaje de error
                request.getSession().setAttribute("exito", false);
                request.getSession().setAttribute("mensaje", "No se pudo eliminar el empleado. Por favor, revise los datos y vuelva a intentarlo.");
            }
        } catch (SQLException e) {
            // Manejar excepciones de SQL

        } finally {
            // Cerrar conexiones y declaraciones
            try {
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {

                    Conexion.cerrarConexion(conn);
                }
            } catch (SQLException e) {

            }
        }

    }

    public void agregarCliente(HttpServletRequest request, HttpServletResponse response) {
        String dui = request.getParameter("dui");
        String nombres = request.getParameter("nombres");
        String apellidos = request.getParameter("apellidos");
        String telefono = request.getParameter("telefono");

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = Conexion.obtenerConexion();
            String sql = "INSERT INTO Clientes (DUI, Nombres, Apellidos, Telefono) VALUES (?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dui);
            pstmt.setString(2, nombres);
            pstmt.setString(3, apellidos);
            pstmt.setString(4, telefono);

            int registros = pstmt.executeUpdate();

            if (registros > 0) {
                request.getSession().setAttribute("exito", true);
                request.getSession().setAttribute("mensaje", "Cliente agregado correctamente.");
            } else {
                request.getSession().setAttribute("exito", false);
                request.getSession().setAttribute("mensaje", "No se pudo agregar el cliente. Por favor, revise los datos y vuelva a intentarlo.");
            }
        } catch (SQLException e) {

            request.getSession().setAttribute("exito", false);
            request.getSession().setAttribute("mensaje", "Error al agregar el cliente: " + e.getMessage());
        } finally {
            Conexion.cerrarConexion(conn);
        }
    }

    public void modificarCliente(HttpServletRequest request, HttpServletResponse response) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = Conexion.obtenerConexion();
            String sql = "UPDATE Clientes SET DUI=?, Nombres=?, Apellidos=?, Telefono=? WHERE idCliente=?";

            String dui = request.getParameter("dui");
            String nombres = request.getParameter("nombres");
            String apellidos = request.getParameter("apellidos");
            String telefono = request.getParameter("telefono");
            int idCliente = Integer.parseInt(request.getParameter("idCliente"));

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dui);
            pstmt.setString(2, nombres);
            pstmt.setString(3, apellidos);
            pstmt.setString(4, telefono);
            pstmt.setInt(5, idCliente);

            int registros = pstmt.executeUpdate();

            if (registros > 0) {
                request.getSession().setAttribute("exito", true);
                request.getSession().setAttribute("mensaje", "Cliente modificado correctamente.");
            } else {
                request.getSession().setAttribute("exito", false);
                request.getSession().setAttribute("mensaje", "No se pudo modificar el cliente. Por favor, revise los datos y vuelva a intentarlo.");
            }
        } catch (SQLException e) {

            request.getSession().setAttribute("exito", false);
            request.getSession().setAttribute("mensaje", "Error al modificar el cliente: " + e.getMessage());
        } finally {
            Conexion.cerrarConexion(conn);
        }
    }

    public void eliminarCliente(HttpServletRequest request, HttpServletResponse response) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = Conexion.obtenerConexion();
            String sql = "DELETE FROM Clientes WHERE idCliente=?";
            int idCliente = Integer.parseInt(request.getParameter("idCliente"));

            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, idCliente);

            int filasAfectadas = pstmt.executeUpdate();

            if (filasAfectadas > 0) {
                request.getSession().setAttribute("exito", true);
                request.getSession().setAttribute("mensaje", "Cliente eliminado correctamente.");
            } else {
                request.getSession().setAttribute("exito", false);
                request.getSession().setAttribute("mensaje", "No se pudo eliminar el cliente. Por favor, revise los datos y vuelva a intentarlo.");
            }
        } catch (SQLException e) {

            request.getSession().setAttribute("exito", false);
            request.getSession().setAttribute("mensaje", "Error al eliminar el cliente: " + e.getMessage());
        } finally {
            Conexion.cerrarConexion(conn);
        }
    }

    private void modificarCategoria(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve parameters from the request
        int idCategoria = Integer.parseInt(request.getParameter("idCategoria"));
        String nuevoNombre = request.getParameter("nombre");
        String nuevaDescripcion = request.getParameter("descripcion");

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = Conexion.obtenerConexion();
            String sql = "UPDATE Categorias SET Nombre=?, Descripcion=? WHERE idCategoria=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, nuevoNombre);
            pstmt.setString(2, nuevaDescripcion);
            pstmt.setInt(3, idCategoria);

            int registros = pstmt.executeUpdate();

            if (registros > 0) {
                request.getSession().setAttribute("exito", true);
                request.getSession().setAttribute("mensaje", "Categoría modificada correctamente.");
            } else {
                request.getSession().setAttribute("exito", false);
                request.getSession().setAttribute("mensaje", "No se pudo modificar la categoría. Por favor, revise los datos y vuelva a intentarlo.");
            }
        } catch (SQLException e) {

            request.getSession().setAttribute("exito", false);
            request.getSession().setAttribute("mensaje", "Error al modificar la categoría: " + e.getMessage());
        } finally {
            try {
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {

            }
        }

    }

    public void eliminarCategoria(HttpServletRequest request, HttpServletResponse response) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = Conexion.obtenerConexion();
            String sql = "DELETE FROM Categorias WHERE idCategoria=?";
            int idCategoria = Integer.parseInt(request.getParameter("idCategoria"));

            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, idCategoria);

            int filasAfectadas = pstmt.executeUpdate();

            if (filasAfectadas > 0) {
                request.getSession().setAttribute("exito", true);
                request.getSession().setAttribute("mensaje", "Categoría eliminada correctamente.");
            } else {
                request.getSession().setAttribute("exito", false);
                request.getSession().setAttribute("mensaje", "No se pudo eliminar la categoría. Por favor, revise los datos y vuelva a intentarlo.");
            }
        } catch (SQLException e) {

            request.getSession().setAttribute("exito", false);
            request.getSession().setAttribute("mensaje", "Error al eliminar la categoría: " + e.getMessage());
        } finally {
            try {
                if (pstmt != null) {
                    pstmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {

            }
        }
    }
  private void agregarProveedor(HttpServletRequest request) throws ServletException, IOException {
        // Retrieve new provider information from the request parameters
        String nombre = request.getParameter("nombre");
        String telefono = request.getParameter("telefono");
        // Add more parameters as needed

        // Validate input if needed

        try (Connection connection = Conexion.obtenerConexion();
             PreparedStatement pstmt = connection.prepareStatement("INSERT INTO Proveedores (nombre, telefono) VALUES (?, ?)")) {

            pstmt.setString(1, nombre);
            pstmt.setString(2, telefono);

            // Set more parameters if needed

            pstmt.executeUpdate();

        } catch (SQLException e) {
            // Handle the SQLException here, for example, log the error or throw a custom exception.
            // This is just an example. In a production environment, you should handle the exception properly.
            e.printStackTrace();
        }

        // Redirect to the page displaying the updated list of providers
       
    }
    private void modificarProveedor(HttpServletRequest request) throws ServletException, IOException {
        // Retrieve modified provider information from the request parameters
        int idProveedor = Integer.parseInt(request.getParameter("idProveedor"));
        String nuevoNombre = request.getParameter("nombre");
        String nuevoTelefono = request.getParameter("telefono");
        // Add more parameters as needed

        // Validate input if needed

        try (Connection connection = Conexion.obtenerConexion();
             PreparedStatement pstmt = connection.prepareStatement("UPDATE Proveedores SET nombre = ?, telefono = ? WHERE idProveedor = ?")) {

            pstmt.setString(1, nuevoNombre);
            pstmt.setString(2, nuevoTelefono);
            pstmt.setInt(3, idProveedor);

            // Set more parameters if needed

            pstmt.executeUpdate();

        } catch (SQLException e) {
            // Handle the SQLException here, for example, log the error or throw a custom exception.
            // This is just an example. In a production environment, you should handle the exception properly.
            e.printStackTrace();
        }

        // Redirect to the page displaying the updated list of providers
       
    }
private void eliminarProveedor(HttpServletRequest request) throws ServletException, IOException {
        // Retrieve the provider ID to be deleted from the request
        int idProveedor = Integer.parseInt(request.getParameter("idProveedor"));

        // Implement the logic to delete the provider with the given ID
        try (Connection connection = Conexion.obtenerConexion();
             PreparedStatement pstmt = connection.prepareStatement("DELETE FROM Proveedores WHERE idProveedor = ?")) {

            pstmt.setInt(1, idProveedor);

            pstmt.executeUpdate();

        } catch (SQLException e) {
            // Handle the SQLException here, for example, log the error or throw a custom exception.
            // This is just an example. In a production environment, you should handle the exception properly.
            e.printStackTrace();
        }

        // Redirect to the page displaying the updated list of providers
        
    }
}
