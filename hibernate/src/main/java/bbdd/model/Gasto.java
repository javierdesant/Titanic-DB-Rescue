package bbdd.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.CascadeType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;


@Entity
@Table(name = "gastos")
public class Gasto {

    @Id
    @GeneratedValue
    //no hay @Colum, porque no existe la columna , pero se crea el atributo para evitar el uso de una clave primaria compuesta.
    private Long id;

    @ManyToOne
    @JoinColumn(name = "pasajero")
    private Pasajero pasajero;

    @ManyToOne
    @JoinColumn(name = "entretenimiento")
    private Entretenimiento entretenimiento;

    @Column(name = "cantidad")
    private Integer cantidad;

    public Gasto() {
        // requerido por Hibernate
    }

    public Gasto(Pasajero pasajero, Entretenimiento entretenimiento, Integer cantidad) {
        this.pasajero = pasajero;
        this.entretenimiento = entretenimiento;
        this.cantidad = cantidad;
    }

    public Long getId() { 
        return id;
    }
    
    public Pasajero getPasajero() { 
        return pasajero; 
    }

    public Entretenimiento getEntretenimiento() { 
        return entretenimiento; 
    }

    public Integer getCantidad() { 
        return cantidad; 
    }

}
