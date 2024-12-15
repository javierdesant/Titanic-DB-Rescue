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
                .configure("hibernate.cfg.xml")
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
        session.save(pasajero);

        Entretenimiento entretenimiento = new Entretenimiento("Bounty Hunting");
        session.save(entretenimiento);

        Gasto gasto = new Gasto(pasajero, entretenimiento, 100);
        session.save(gasto);

        session.getTransaction().commit();

        // @TODO Leer el fichero CSV gastos.csv que se encuentra en el directorio "resources" y 
        // recorrerlo usando CSVParser para crear los pasajeros, entretenimientos y gastos que
        // en él se encuentran. Dichos gastos deberán ser asignados al pasajero/a y al entretenimiento 
        // correspondientes. Se deben guardar todos estos datos en la base de datos.

        session.beginTransaction();

        try {
            reader = Files.newBufferedReader(Paths.get("src/main/resources/gastos.csv"));
            csvParser = new CSVParser(reader, CSVFormat.DEFAULT.withHeader("pasajero", "entretenimiento", "cantidad").withSkipHeaderRecord());
            for (CSVRecord csvRecord : csvParser) {
                String pasajeroNombre = csvRecord.get("pasajero");
                String entretenimientoNombre = csvRecord.get("entretenimiento");
                int cantidad = Integer.parseInt(csvRecord.get("cantidad"));

                Pasajero pasajeroCSV = new Pasajero(pasajeroNombre);
                session.save(pasajeroCSV);

                Entretenimiento entretenimientoCSV = new Entretenimiento(entretenimientoNombre);
                session.save(entretenimientoCSV);

                Gasto gastoCSV = new Gasto(pasajeroCSV, entretenimientoCSV, cantidad);
                session.save(gastoCSV);
            }
            session.getTransaction().commit();
        } catch (IOException e) {
            e.printStackTrace();
            session.getTransaction().rollback();
        } finally {
            try {
                if (reader != null) {
                    reader.close();
                }
                if (csvParser != null) {
                    csvParser.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        session.close();
        sessionFactory.close();

    }
}