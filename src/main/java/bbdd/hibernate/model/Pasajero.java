package bbdd.hibernate.model;

import javax.persistence.*;
import java.util.HashSet;
import java.util.Set;


@Entity
@Table(name = "pasajero")
public class Pasajero {
    
    @Id
    @GeneratedValue
    @Column(name = "id")
    private Long id;

    @Column(name = "nombre")
    private String nombre;

    @OneToMany(mappedBy = "pasajero")
    private Set<Gasto> gastos = new HashSet<>();

    public Pasajero() {
        // requerido por Hibernate
    }

    public Pasajero(String nombre) {
        this.nombre = nombre;
    }

    public Long getId() {
        return id;
    }

    public String getNombre() {
        return nombre;
    }

    public Set<Gasto> getGastos() { 
        return gastos; 
    }
    
}
