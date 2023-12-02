package Models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Cliente {
    private int idCliente;
    private String nombres;
    private String apellidos;
    private String dui;
    private String telefono;

   
}