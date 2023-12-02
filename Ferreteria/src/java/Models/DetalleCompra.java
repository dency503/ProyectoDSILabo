package Models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DetalleCompra {
    private int idDetalleCompra;
    private int idCompra;
    private int idProducto;
    private int cantidad;
    private double precioUnitario;
private Producto producto;
    // Constructors, getters, setters

    
}
