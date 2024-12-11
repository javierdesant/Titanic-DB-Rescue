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
    private static PreparedStatement nuevoPlstmt;
    private static PreparedStatement listaPCstmt;

    public static void main (String [] args) throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");

        String url = "jdbc:mysql://" + DB_SERVER + ":" + DB_PORT + "/" + DB_NAME;
        conn = DriverManager.getConnection(url, DB_USER, DB_PASS);
    
        // 1. Añade los planetas a la base de datos
        // nuevoPlstmt = conn.prepareStatement("INSERT INTO planetas (nombre, masa, radio, sistema) VALUES (?, ?, ?, ?)");

        // nuevoPlaneta("Kepler-186f", 3.3e24, 8800 , "Copernico");
        // nuevoPlaneta("HD 209458 b (Osiris)", 1.4e27, 100000, "Beta Pictoris");
        // nuevoPlaneta("LHS 1140 b", 8.3e24, 8800, "Copernico");
        
        // 2. Muestra por pantalla la lista de pasajeros de la cabina A-60-S
        listaPCstmt = conn.prepareStatement("SELECT nombre, edad FROM pasajeros WHERE cubierta = ? AND numero_cabina = ? AND lado_cabina = ?");

        listaPasajerosCabina("A", 60, "S");

        // 3. Muestra por pantalla una lista de sistemas, planetas y número de pasajeros con origen en ellos
        

        conn.close();
    }

    private static void nuevoPlaneta (String nombre, double masa, int radio, String sistema) throws SQLException {
        nuevoPlstmt.setString(1, nombre);
        nuevoPlstmt.setDouble(2, masa);
        nuevoPlstmt.setInt(3, radio);
        nuevoPlstmt.setString(4, sistema);
        nuevoPlstmt.executeUpdate();
    }

    private static void listaPasajerosCabina (String cubierta, int cabina, String lado) throws SQLException {
        listaPCstmt.setString(1, cubierta);
        listaPCstmt.setInt(2, cabina);
        listaPCstmt.setString(3, lado);
        ResultSet rs = listaPCstmt.executeQuery();

        System.out.println("Pasajero(s) de la cabina " + cubierta + "-" + cabina + "-" + lado + ":");
        while (rs.next()) {
            String nombre = rs.getString("nombre");
            int edad = rs.getInt("edad");

            System.out.println("nombre = " + nombre + ", edad = " + edad);
        }
    }

    private static void listaOrigenes() throws SQLException {
        // @TODO Muestra por pantalla una lista de planetas, sistemas y número de pasajeros provinientes de ellos

    }
}