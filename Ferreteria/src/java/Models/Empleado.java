package Models;

import java.util.Date;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Empleado {

    private int idEmpleado;
    private String dui;
    private int isss;
    private String nombres;
    private String apellidos;
    private Date fechaNacEmpleado;
    private String telefono;
    private String correo;
    private int idCargo;
    private String nombreCargo;
    private int idDireccion;

    // Constructor, getters y setters
}
