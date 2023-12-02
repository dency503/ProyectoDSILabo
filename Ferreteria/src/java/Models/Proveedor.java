
package Models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Proveedor {
     private int idProveedor;
    private String telefono;
    private int idDireccion;
    private String nombre;

    // Constructors, getters, and setters

}
