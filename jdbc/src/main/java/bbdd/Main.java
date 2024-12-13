package bbdd;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Main {

    private final static String DB_SERVER = "127.0.0.1";
    private final static int DB_PORT = 3306;
    private final static String DB_NAME = "titanic_spaceship";
    private final static String DB_USER = "root";
    private final static String DB_PASS = "titanic";
    private static Connection conn;
    private static PreparedStatement stmtNuevoPl;
    private static PreparedStatement stmtListaPC;
    private static PreparedStatement stmtListaO;

    public static void main (String [] args) throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");

        String url = "jdbc:mysql://" + DB_SERVER + ":" + DB_PORT + "/" + DB_NAME;
        conn = DriverManager.getConnection(url, DB_USER, DB_PASS);
    
        // 1. Añade los planetas a la base de datos
        stmtNuevoPl = conn.prepareStatement("INSERT INTO planetas (nombre, masa, radio, sistema) VALUES (?, ?, ?, ?)");

        // nuevoPlaneta("Kepler-186f", 3.3e24, 8800 , "Copernico");
        // nuevoPlaneta("HD 209458 b (Osiris)", 1.4e27, 100000, "Beta Pictoris");
        // nuevoPlaneta("LHS 1140 b", 8.3e24, 8800, "Copernico");
        
        // 2. Muestra por pantalla la lista de pasajeros de la cabina A-60-S
        stmtListaPC = conn.prepareStatement("SELECT nombre, edad FROM pasajeros WHERE cubierta = ? AND numero_cabina = ? AND lado_cabina = ?");

        listaPasajerosCabina("A", 60, "S");


        System.out.println("--------------------");
        // 3. Muestra por pantalla una lista de sistemas, planetas y número de pasajeros con origen en ellos
        stmtListaO = conn.prepareStatement("SELECT sistema, nombre, (SELECT COUNT(*) FROM pasajeros WHERE planeta_natal = planetas.nombre) AS numPasajeros FROM planetas ORDER BY sistema");
        
        System.out.println("Lista origen de pasajeros: ");
        listaOrigenes();

        conn.close();
    }

    private static void nuevoPlaneta (String nombre, double masa, int radio, String sistema) throws SQLException {
        stmtNuevoPl.setString(1, nombre);
        stmtNuevoPl.setDouble(2, masa);
        stmtNuevoPl.setInt(3, radio);
        stmtNuevoPl.setString(4, sistema);
        stmtNuevoPl.executeUpdate();
    }

    private static void listaPasajerosCabina (String cubierta, int cabina, String lado) throws SQLException {
        stmtListaPC.setString(1, cubierta);
        stmtListaPC.setInt(2, cabina);
        stmtListaPC.setString(3, lado);
        ResultSet rs = stmtListaPC.executeQuery();

        System.out.println("Pasajero(s) de la cabina " + cubierta + "-" + cabina + "-" + lado + ":");
        while (rs.next()) {
            String nombre = rs.getString("nombre");
            int edad = rs.getInt("edad");

            System.out.println("Nombre = " + nombre + ", Edad = " + edad);
        }
    }

    private static void listaOrigenes() throws SQLException {
        ResultSet rs = stmtListaO.executeQuery();

        while (rs.next()) {
            String sistema = rs.getString("sistema");
            String planeta = rs.getString("nombre");
            int numPasajeros = rs.getInt("numPasajeros");

            System.out.println("Sistema = " + sistema + ", Planeta = " + planeta + ", Numero de pasajeros = " + numPasajeros);
        }
    }
}