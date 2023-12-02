/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Operaciones;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
/**
 *
 * @author Home
 */
public class Conexion {
    static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=Ferreteria;encrypt=true;trustServerCertificate=true";
    static final String USER = "sa";
    static final String PASSWORD = "admin";

   public static Connection obtenerConexion() {
    Connection connection = null;
    try {
        // Cargar el controlador JDBC
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        // Establecer la conexión
        connection = DriverManager.getConnection(URL, USER, PASSWORD);
        System.out.println("Conexión exitosa a la base de datos.");
    } catch (ClassNotFoundException | SQLException e) {
        System.err.println("Error al conectar a la base de datos: " + e.getMessage());
    }
    return connection;
}

    public static void cerrarConexion(Connection connection) {
        try {
            // Cerrar la conexión
            if (connection != null && !connection.isClosed()) {
                connection.close();
                System.out.println("Conexion cerrada.");
            }
        } catch ( SQLException e) {
            System.err.println("Error al cerrar la conexión: " + e.getMessage());
        }
    }
}