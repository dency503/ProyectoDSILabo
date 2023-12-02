package Models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DetallePedido {
    private int idDetallePedido;
    private int idProducto;
    private int cantidad;
    private double precioUnitario;
    private Producto producto;

   
}
