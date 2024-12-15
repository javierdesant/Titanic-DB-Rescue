package bbdd.hibernate;

import bbdd.hibernate.model.Entretenimiento;
import bbdd.hibernate.model.Gasto;
import bbdd.hibernate.model.Pasajero;
import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVParser;
import org.apache.commons.csv.CSVRecord;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;

import java.io.IOException;
import java.io.Reader;
import java.nio.file.Files;
import java.nio.file.Paths;


public class Main 
{

    private static Reader reader;
    private static CSVParser csvParser;
    public static void main( String[] args )
    {

        StandardServiceRegistry registry = new StandardServiceRegistryBuilder()
                .configure()
                .build();

        SessionFactory sessionFactory = new MetadataSources(registry)
                .buildMetadata()
                .buildSessionFactory();

        Session session = sessionFactory.openSession();

        // @TODO Crear un nuevo pasajero llamado "Din Djarin" y un nuevo entretenimiento
        // llamado "Bounty Hunting" y guardarlos en la base de datos. Añade un gasto de
        // 100 a "Din Djarin" para "Bounty Hunting".
        session.beginTransaction();

        Pasajero pasajero = new Pasajero("Din Djarin");

        Entretenimiento entretenimiento = new Entretenimiento("Bounty Hunting");

        Gasto gasto = new Gasto(pasajero, entretenimiento, 100);

        session.save(pasajero);
        session.save(entretenimiento);
        session.save(gasto);

        session.getTransaction().commit();

        // @TODO Leer el fichero CSV gastos.csv que se encuentra en el directorio "resources" y 
        // recorrerlo usando CSVParser para crear los pasajeros, entretenimientos y gastos que
        // en él se encuentran. Dichos gastos deberán ser asignados al pasajero/a y al entretenimiento 
        // correspondientes. Se deben guardar todos estos datos en la base de datos.

        session.beginTransaction();

        try {
            reader = Files.newBufferedReader(Paths.get("resources/gastos.csv"));
            csvParser = new CSVParser(reader, CSVFormat.DEFAULT.withHeader("Pasajero", "Entretenimiento", "Cantidad").withSkipHeaderRecord());
            for (CSVRecord csvRecord : csvParser) {
                String pasajeroNombre = csvRecord.get("Pasajero");
                String entretenimientoNombre = csvRecord.get("Entretenimiento");
                int cantidad = Integer.parseInt(csvRecord.get("Cantidad"));

                pasajero = new Pasajero(pasajeroNombre);

                entretenimiento = new Entretenimiento(entretenimientoNombre);

                gasto = new Gasto(pasajero, entretenimiento, cantidad);

                session.save(pasajero);
                session.save(entretenimiento);
                session.save(gasto);
            }
            csvParser.close();
            reader.close();
            
        } catch (IOException e) {
            e.printStackTrace();
        }
        
        session.getTransaction().commit();
        
        session.close();

    }
}