
package Models;

import java.util.Date;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Factura {
    private int idFactura;
    private String numeroFactura;
    private String creditoFiscal;
    private double iva;
    private Venta venta;
    private Cliente cliente;
    private double monto;
    private Date fechaFactura;
    private Date fechaCreacion;

 
}
