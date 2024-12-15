package bbdd.hibernate.model;

import javax.persistence.*;


@Entity
@Table(name = "gasto")
public class Gasto {

    @Id
    @GeneratedValue
    @Column(name = "id")
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
