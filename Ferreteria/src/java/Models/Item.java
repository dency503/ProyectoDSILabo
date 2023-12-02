
package Models;

import java.math.BigDecimal;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Item {
   private int id;
    private int cantidad; 
    private BigDecimal precioUnitario;

   
}
