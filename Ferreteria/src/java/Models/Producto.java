
package Models;

import java.util.Date;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Producto {
    private int idProducto;
    private String nombre;
    private String descripcion;
    private double precio;
    private int stock;
    private int idCategoria;
    private Date fechaCreacion;
    private String imagenURL;
    private Date fechaModificacion;
    private boolean activo;
    private String categoriaNombre;

    // Constructor, getters y setters

   
}
