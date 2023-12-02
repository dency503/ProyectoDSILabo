
package Models;

import java.util.ArrayList;
import java.util.Date;
import lombok.AllArgsConstructor;
import lombok.Data;


@Data

@AllArgsConstructor
public class Venta {
    private int idVenta;
    private Cliente cliente;
    private Empleado empleado;
    private Date fechaCompra;
    private double montoCompra;
    private Date fechaCreacion;
private ArrayList<DetalleVenta> detalleVentas;
    // Constructor, getters y setters

    

    public Venta() {
        this.detalleVentas = new ArrayList<>();
    }

   
}