package database;

import javax.swing.table.DefaultTableModel;
import java.sql.*;

public class ConnectionDB {
    public static final String URL = "jdbc:mysql://localhost:3306/integracja";
    public static final String USER = "root";
    public static final String PASSWORD = "mysql2021";

    public static ResultSet selectDataFromDB(Connection connection) throws SQLException {
        Statement statement = connection.createStatement();
        return statement.executeQuery("SELECT * FROM Urzadzenia");
    }

    public static void extractDataToDB(Connection connection, DefaultTableModel tableModel, int rowCount) throws SQLException {
        for (int row = 0; row < tableModel.getRowCount(); row++) {
            int id = ++rowCount;
            String touch = tableModel.getValueAt(row, 1).toString();
            String manufacturer = tableModel.getValueAt(row, 2).toString();
            String screen_size = tableModel.getValueAt(row, 3).toString();
            String screen_resolution = tableModel.getValueAt(row, 4).toString();
            String screen_type = tableModel.getValueAt(row, 5).toString();
            String processor_name = tableModel.getValueAt(row, 6).toString();
            int physical_cores = parseToIntIfApplicable(tableModel.getValueAt(row, 7).toString());
            int clock_speed = parseToIntIfApplicable(tableModel.getValueAt(row, 8).toString());
            String ram = tableModel.getValueAt(row, 9).toString();
            String disc_type = tableModel.getValueAt(row, 10).toString();
            String disc_storage = tableModel.getValueAt(row, 11).toString();
            String graphic_card_name = tableModel.getValueAt(row, 12).toString();
            String graphic_card_memory = tableModel.getValueAt(row, 13).toString();
            String os = tableModel.getValueAt(row, 14).toString();
            String disc_reader = tableModel.getValueAt(row, 15).toString();

            insertToDB(connection, id, touch, manufacturer, screen_size, screen_resolution, screen_type,
                    processor_name, physical_cores, clock_speed,
                    ram, disc_type, disc_storage, graphic_card_name, graphic_card_memory, os, disc_reader);
        }
    }

    private static int parseToIntIfApplicable(String input) {
        return input.equals("Brak") ? 0 : Integer.parseInt(input);
    }

    private static void insertToDB(Connection connection, int id, String touch, String manufacturer, String screen_size, String screen_resolution, String screen_type, String processor_name, int physical_cores, int clock_speed, String ram, String disc_type, String disc_storage, String graphic_card_name, String graphic_card_memory, String os, String disc_reader) throws SQLException {
        String sql = "INSERT INTO Urzadzenia (id, touch, manufacturer, screen_size, screen_resolution, screen_type, processor_name, physical_cores, clock_speed, ram, disc_type, disc_storage, graphic_card_name, graphic_card_memory, os, disc_reader) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setInt(1, id);
        statement.setString(2, touch);
        statement.setString(3, manufacturer);
        statement.setString(4, screen_size);
        statement.setString(5, screen_resolution);
        statement.setString(6, screen_type);
        statement.setString(7, processor_name);
        statement.setInt(8, physical_cores);
        statement.setInt(9, clock_speed);
        statement.setString(10, ram);
        statement.setString(11, disc_type);
        statement.setString(12, disc_storage);
        statement.setString(13, graphic_card_name);
        statement.setString(14, graphic_card_memory);
        statement.setString(15, os);
        statement.setString(16, disc_reader);

        statement.executeUpdate();
    }
}
