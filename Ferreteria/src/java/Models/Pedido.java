package Models;


import java.util.ArrayList;
import java.util.Date;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data

@AllArgsConstructor
public class Pedido {
    private int idPedido;
    private Date fecha;
    private int IDProveedor;
    private String nombreProveedor;
    private String observaciones;
    private double costoTotal;
    private String estado;
    private int IDEmpleado;
    private String nombreEmpleado;
    private Date fechaCreacion;
    private ArrayList<DetallePedido> detallePedidos;

    public Pedido() {
       this.detallePedidos = new ArrayList<>();
    }

   

    
}
