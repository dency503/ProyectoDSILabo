
package Models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class DetalleVenta {
    private int idDetalleVenta;
    private int venta;
    private Producto producto;
    private int cantidad;

    // Constructor, getters y setters
}