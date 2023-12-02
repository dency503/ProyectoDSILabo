
package Models;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
public class Compra {
    private int idCompra;
    private int idProveedor;
    private int idEmpleado;
    private Date fechaCompra;
    private double montoCompra;
    private Date fechaCreacion;
private String nombreProveedor;
private String nombreEmpleado;
private List<DetalleCompra> detalleCompra;
 
    


    public Compra() {
          this.detalleCompra = new ArrayList<>();
    }

    
}
