import com.google.common.collect.Iterables;
import com.google.common.collect.Lists;
import database.ComparingDevice;
import database.Device;
import xml.catalogue.*;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;
import java.awt.*;
import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.*;
import java.util.stream.IntStream;

import static database.ConnectionDB.*;
import static database.Device.toComparingDevices;
import static database.Device.toDevice;
import static java.lang.Integer.parseInt;

public class Catalogue extends JFrame {
    private final JTable table;
    private final DefaultTableModel tableModel;
    private final JLabel label;

    private static final int NR = 0;
    private static final int PRODUCENT = 1;
    private static final int POWIERZCHNIA = 4;
    private static final int DOTYKOWY = 5;
    private static final int PROCESOR = 6;
    private static final int RDZENIE = 7;
    private static final int TAKTOWANIE = 8;
    private static final int RODZAJ = 11;
    private static final int UKLAD = 12;
    private static final int SYSTEM = 14;
    private static final int NAPED = 15;


    public Catalogue() {
        setTitle("Zadanie T2");
        setSize(1000, 700);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        JPanel panel = new JPanel();
        panel.setLayout(new BorderLayout());

        JPanel buttonsPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));


        JButton importButton = new JButton("Importuj");
        importButton.setPreferredSize(new Dimension(100, 20));
        JButton exportButton = new JButton("Eksportuj");
        exportButton.setPreferredSize(new Dimension(100, 20));

        JButton importXML = new JButton(" Import XML");
        importXML.setPreferredSize(new Dimension(120, 20));
        JButton exportXML = new JButton("Export XML");
        exportXML.setPreferredSize(new Dimension(120, 20));

        JButton importDB = new JButton("Import DB");
        importDB.setPreferredSize(new Dimension(120, 20));
        JButton exportDB = new JButton("Export to DB");
        exportDB.setPreferredSize(new Dimension(120, 20));

        label = new JLabel();
        label.setLayout(new FlowLayout(FlowLayout.CENTER));

        importButton.addActionListener(e -> {
            JFileChooser fileChooser = new JFileChooser();
            int result = fileChooser.showOpenDialog(Catalogue.this);
            if (result == JFileChooser.APPROVE_OPTION) {
                String filePath = fileChooser.getSelectedFile().getAbsolutePath();
                importDataFromFile(filePath);
            }
        });

        exportButton.addActionListener(e -> {
            JFileChooser fileChooser = new JFileChooser();
            int result = fileChooser.showSaveDialog(Catalogue.this);
            if (result == JFileChooser.APPROVE_OPTION) {
                String filePath = fileChooser.getSelectedFile().getAbsolutePath();
                exportDataToFile(filePath);
            }
        });

        importXML.addActionListener(e -> {
            JFileChooser fileChooser = new JFileChooser();
            int result = fileChooser.showOpenDialog(Catalogue.this);
            if (result == JFileChooser.APPROVE_OPTION) {
                String filePath = fileChooser.getSelectedFile().getAbsolutePath();
                try {
                    importFromXml(filePath);
                } catch (Exception ex) {
                    throw new RuntimeException(ex);
                }
            }
        });

        exportXML.addActionListener(e -> {
            JFileChooser fileChooser = new JFileChooser();
            int result = fileChooser.showSaveDialog(Catalogue.this);
            if (result == JFileChooser.APPROVE_OPTION) {
                String filePath = fileChooser.getSelectedFile().getAbsolutePath();
                exportDataToXMLFile(filePath);
            }
        });

        importDB.addActionListener(e -> {
            try {
                importDataFromDB();
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
        });

        exportDB.addActionListener(e -> exportDataToDB());

        buttonsPanel.add(importButton);
        buttonsPanel.add(exportButton);
        buttonsPanel.add(importXML);
        buttonsPanel.add(exportXML);
        buttonsPanel.add(importDB);
        buttonsPanel.add(exportDB);

        tableModel = new DefaultTableModel();
        for (String s : Arrays.asList("Nr", "Producent", "Ekran", "Rozdzielczość", "Powierzchnia", "Dotykowy", "Procesor",
                "Rdzenie", "Taktowanie", "RAM", "Dysk", "Rodzaj dysku", "Układ graficzny", "Pamięć graf.", "System", "Napęd")) {
            tableModel.addColumn(s);
        }

        table = new JTable(tableModel) {
            @Override
            public boolean isCellEditable(int row, int column) {
                return true;
            }

            @Override
            public void setValueAt(Object aValue, int row, int column) {
                String currentValue = aValue.toString();
                validateInputData(row, column, currentValue);
            }
        };

        panel.add(buttonsPanel, BorderLayout.NORTH);
        panel.add(label, BorderLayout.CENTER);
        panel.add(new JScrollPane(table), BorderLayout.SOUTH);

        add(panel);
        setVisible(true);

    }

    private void validateInputData(int row, int column, String currentValue) {
        if (currentValue.isEmpty()) {
            JOptionPane.showMessageDialog(table, "Podaana wartość jest pusta, powinieneś wprowadzić wartość", "Błąd",
                    JOptionPane.ERROR_MESSAGE);
        } else if (isColumnWithStringValidation(column) && !isInputContainsOnlyString(currentValue)) {
            JOptionPane.showMessageDialog(table, "Podałeś liczbę w tym polu dozwolone są tylko znaki", "Błąd",
                    JOptionPane.ERROR_MESSAGE);
        } else if (column == RDZENIE && !isProperIntegerValue(currentValue)) {
            JOptionPane.showMessageDialog(table, "Podałeś złą wartość, w tym polu dozwolone są tylko liczby całkowite", "Błąd",
                    JOptionPane.ERROR_MESSAGE);
        } else if (column == TAKTOWANIE && currentValue.length() > 4 && isInputContainsOnlyDigit(currentValue)) {
            JOptionPane.showMessageDialog(table, "Za duża wartość taktowania dopuszczalne tylko 4 cyfry", "Błąd",
                    JOptionPane.ERROR_MESSAGE);
        } else if (column == TAKTOWANIE || column == NR && !isInputContainsOnlyDigit(currentValue)) {
            JOptionPane.showMessageDialog(table, "Ups podałeś znak a dopuszczalne tylko cyfry", "Błąd",
                    JOptionPane.ERROR_MESSAGE);
        } else {
            tableModel.setValueAt(currentValue, row, column);
        }
    }

    public boolean isInputContainsOnlyString(String input) {
        return input.chars().allMatch(Character::isLetter);
    }

    public boolean isInputContainsOnlyDigit(String input) {
        return input.chars().allMatch(Character::isDigit);
    }

    public boolean isColumnWithStringValidation(int column) {
        return (column == PRODUCENT || column == POWIERZCHNIA || column == DOTYKOWY
                || column == PROCESOR || column == RODZAJ || column == UKLAD || column == SYSTEM || column == NAPED);
    }

    public boolean isProperIntegerValue(String currentObjectValue) {
        try {
            parseInt(currentObjectValue);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    public void importDataFromFile(String filePath) {
        int rowCount = tableModel.getRowCount();
        List<Device> devicesFromViewTable = getDevicesFromViewTable(rowCount);
        List<Device> devicesFromFile = Lists.newArrayList();

        try (BufferedReader bufferedReader = new BufferedReader(new FileReader(filePath))) {
            String line;
            int lineNumber = 1;
            while ((line = bufferedReader.readLine()) != null) {
                String[] fields = line.split(";", -1);
                setTextWhenNoValue(fields);
                devicesFromFile.add(getDeviceFromFile(lineNumber, fields));
                lineNumber++;
            }
        } catch (IOException exception) {
            exception.printStackTrace();
        }
        detectDuplicates(devicesFromFile, devicesFromViewTable);
    }

    private static Device getDeviceFromFile(int lineNumber, String[] fields) {
        return new Device(lineNumber, fields[0], fields[1], fields[2], fields[3], fields[4], fields[5],
                parseToIntIfApplicable(fields[6]), parseToIntIfApplicable(fields[7]),
                fields[8], fields[9], fields[10], fields[11], fields[12], fields[13], fields[14]);
    }

    public void importFromXml(String file) {
        int rowCount = tableModel.getRowCount();
        List<Device> devicesFromViewTable = getDevicesFromViewTable(rowCount);
        List<Device> devicesFromXML = Lists.newArrayList();

        try {
            JAXBContext jaxbContext = JAXBContext.newInstance(Laptops.class);
            Unmarshaller unmarshaller = jaxbContext.createUnmarshaller();
            Laptops laptops = (Laptops) unmarshaller.unmarshal(new File(file));
            for (Laptop laptop : laptops.getLaptops()) {
                int id = ++rowCount;
                String manufacturer = setTextIfApplicable(laptop.getManufacturer());
                String touch = setTextIfApplicable(laptop.getScreen().getTouch());
                String screenSize = setTextIfApplicable(laptop.getScreen().getSize());
                String screenResolution = setTextIfApplicable(laptop.getScreen().getResolution());
                String screenType = setTextIfApplicable(laptop.getScreen().getType());
                String processorName = setTextIfApplicable(laptop.getProcessor().getName());
                int physicalCores = parseToIntIfApplicable(laptop.getProcessor().getPhysicalCores());
                int clockSpeed = parseToIntIfApplicable(laptop.getProcessor().getClockSpeed());
                String ram = setTextIfApplicable(laptop.getRam());
                String discType = setTextIfApplicable(laptop.getDisc().getType());
                String discStorage = setTextIfApplicable(laptop.getDisc().getStorage());
                String os = setTextIfApplicable(laptop.getOs());
                String discReader = setTextIfApplicable(laptop.getDiscReader());
                String graphicCardName = setTextIfApplicable(laptop.getGraphicCard().getName());
                String graphicCardMemory = setTextIfApplicable(laptop.getGraphicCard().getMemory());

                devicesFromXML.add(getDeviceFromXML(id, manufacturer, touch, screenSize, screenResolution, screenType,
                        processorName, physicalCores, clockSpeed, ram, discType, discStorage, os, discReader,
                        graphicCardName, graphicCardMemory));

            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        detectDuplicates(devicesFromXML, devicesFromViewTable);
    }

    private static Device getDeviceFromXML(int id, String manufacturer, String touch, String screenSize,
                                           String screenResolution, String screenType, String processorName,
                                           int physicalCores, int clockSpeed, String ram, String discType,
                                           String discStorage, String os, String discReader, String graphicCardName,
                                           String graphicCardMemory) {
        return new Device(id, manufacturer, touch, screenSize, screenResolution,
                screenType, processorName, physicalCores, clockSpeed, ram, discType, discStorage, graphicCardName,
                graphicCardMemory, os, discReader);
    }

    void importDataFromDB() throws SQLException {
        Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
        ResultSet resultSet = selectDataFromDB(connection);
        int rowCount = tableModel.getRowCount();
        List<Device> deviceFromDB = new ArrayList<>();

        List<Device> devicesFromViewTable = getDevicesFromViewTable(rowCount);

        while (resultSet.next()) {
            Device device = getDevice(resultSet);
            deviceFromDB.add(device);
        }

        if (!deviceFromDB.isEmpty()) {
            detectDuplicates(devicesFromViewTable, deviceFromDB);
            deleteAllRecords(connection);
        }
        connection.close();
    }


    private List<Device> getDevicesFromViewTable(int rowCount) {
        if (rowCount == 0) return Collections.emptyList();

        List<Device> results = new ArrayList<>();
        for (int i = 0; i < rowCount; i++) {
            int id = (int) tableModel.getValueAt(i, 0);
            String manufacturer = tableModel.getValueAt(i, 1).toString();
            String touch = tableModel.getValueAt(i, 2).toString();
            String screenSize = tableModel.getValueAt(i, 3).toString();
            String screenResolution = tableModel.getValueAt(i, 4).toString();
            String screenType = tableModel.getValueAt(i, 5).toString();
            String processorName = tableModel.getValueAt(i, 6).toString();
            int physicalCores = (int) tableModel.getValueAt(i, 7);
            int clockSpeed = (int) tableModel.getValueAt(i, 8);
            String ram = tableModel.getValueAt(i, 9).toString();
            String discType = tableModel.getValueAt(i, 10).toString();
            String discStorage = tableModel.getValueAt(i, 11).toString();
            String graphicCardName = tableModel.getValueAt(i, 12).toString();
            String graphicCardMemory = tableModel.getValueAt(i, 13).toString();
            String os = tableModel.getValueAt(i, 14).toString();
            String discReader = tableModel.getValueAt(i, 15).toString();

            Device oldDevice = new Device(id, manufacturer, touch, screenSize, screenResolution, screenType, processorName,
                    physicalCores, clockSpeed, ram, discType, discStorage, graphicCardName, graphicCardMemory,
                    os, discReader);

            results.add(oldDevice);
        }

        return results;
    }

    private void detectDuplicates(List<Device> devicesFromDB, List<Device> devicesFromView) {
        List<Device> duplicates = Lists.newArrayList();
        List<Device> originals = Lists.newArrayList();
        int id = 1;
        List<ComparingDevice> comparingDevicesFromView = toComparingDevices(devicesFromView);
        List<ComparingDevice> comparingDevicesFromDB = toComparingDevices(devicesFromDB);

        for (ComparingDevice comparingDevice : comparingDevicesFromDB) {
            Device device = toDevice(comparingDevice, id++);
            if(comparingDevicesFromView.contains(comparingDevice)){
                duplicates.add(device);
            }
            else {
                originals.add(device);
            }
        }
        Iterable<Device> allItems = Iterables.concat(originals, duplicates);

        for(Device device: allItems) {
            tableModel.addRow(getRowData(device));
        }

        if (originals.size() != 0 || duplicates.size() != 0) {
            label.setText("Znalazłem " + duplicates.size() + " duplikatów reszta " + originals.size() + " to rekordy orginalne" +
                    " wśród ostatich " + (originals.size() + duplicates.size()) + " wstawionych rekordów");
        }
    }


    private static Object[] getRowData(Device device) {
        return new Object[]{device.id(), device.manufacturer(), device.touch(),
                device.screenSize(), device.screenResolution(), device.screenType(),
                device.processorName(), device.physicalCores(),
                device.clockSpeed(), device.ram(), device.discType(), device.discStorage(),
                device.graphicCardName(),
                device.graphicCardMemory(), device.os(), device.discReader()};
    }

    private Device getDevice(ResultSet resultSet) throws SQLException {
        int id = resultSet.getInt("id");
        String manufacturer = setTextIfApplicable(resultSet.getString("manufacturer"));
        String touch = setTextIfApplicable(resultSet.getString("touch"));
        String screenSize = setTextIfApplicable(resultSet.getString("screen_size"));
        String screenResolution = setTextIfApplicable(resultSet.getString("screen_resolution"));
        String screenType = setTextIfApplicable(resultSet.getString("screen_type"));
        String processorName = setTextIfApplicable(resultSet.getString("processor_name"));
        int physicalCores = resultSet.getInt("physical_cores");
        int clockSpeed = resultSet.getInt("clock_speed");
        String ram = setTextIfApplicable(resultSet.getString("ram"));
        String discType = setTextIfApplicable(resultSet.getString("disc_type"));
        String discStorage = setTextIfApplicable(resultSet.getString("disc_storage"));
        String graphicCardName = setTextIfApplicable(resultSet.getString("graphic_card_name"));
        String graphicCardMemory = setTextIfApplicable(resultSet.getString("graphic_card_memory"));
        String os = setTextIfApplicable(resultSet.getString("os"));
        String discReader = setTextIfApplicable(resultSet.getString("disc_reader"));

        return new Device(id, manufacturer, touch, screenSize, screenResolution,
                screenType, processorName, physicalCores, clockSpeed, ram, discType, discStorage, graphicCardName,
                graphicCardMemory, os, discReader);
    }


    private static int parseToIntIfApplicable(String input) {
        return input.equals("Brak") ? 0 : Integer.parseInt(input);
    }

    public void setTextWhenNoValue(String[] fields) {
        IntStream.range(0, fields.length)
                .filter(i -> fields[i].isEmpty())
                .forEach(i -> fields[i] = "Brak");
    }

    public String setTextIfApplicable(String value) {
        return (Objects.isNull(value) || value.isEmpty()) ? "Brak" : value;
    }

    public void exportDataToFile(String filename) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filename))) {
            for (int row = 0; row < tableModel.getRowCount(); row++) {
                for (int col = 1; col < tableModel.getColumnCount(); col++) {
                    String value = tableModel.getValueAt(row, col).toString() + ";";
                    writer.write(value);
                }
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void exportDataToXMLFile(String fileName) {
        Laptops laptops = new Laptops();
        ArrayList<Laptop> laptopArrayList = new ArrayList<>();
        laptops.setModdate(String.valueOf(LocalDateTime.now()));
        for (int row = 0; row < tableModel.getRowCount(); row++) {
            preparedXMLData(laptopArrayList, row);
        }
        laptops.setLaptops(laptopArrayList);
        try {
            JAXBContext jaxbContext = JAXBContext.newInstance(Laptops.class);
            Marshaller marshaller = jaxbContext.createMarshaller();
            marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE);
            marshaller.marshal(laptops, new File(fileName));

        } catch (JAXBException e) {
            throw new RuntimeException(e);
        }
    }

    private void preparedXMLData(ArrayList<Laptop> laptopArrayList, int row) {
        Laptop laptop = new Laptop();
        laptop.setId(row + 1);
        laptop.setManufacturer(tableModel.getValueAt(row, 1).toString());

        laptop.setScreen(new Screen(
                tableModel.getValueAt(row, 2).toString(),
                tableModel.getValueAt(row, 3).toString(),
                tableModel.getValueAt(row, 4).toString(),
                tableModel.getValueAt(row, 5).toString()
        ));

        laptop.setProcessor(new Processor(
                tableModel.getValueAt(row, 6).toString(),
                tableModel.getValueAt(row, 7).toString(),
                tableModel.getValueAt(row, 8).toString()
        ));

        laptop.setRam(tableModel.getValueAt(row, 9).toString());

        laptop.setDisc(new Disc(
                tableModel.getValueAt(row, 10).toString(),
                tableModel.getValueAt(row, 11).toString()
        ));

        laptop.setGraphicCard(new GraphicCard(
                tableModel.getValueAt(row, 12).toString(),
                tableModel.getValueAt(row, 13).toString()
        ));

        laptop.setOs(tableModel.getValueAt(row, 14).toString());
        laptop.setDiscReader(tableModel.getValueAt(row, 15).toString());
        laptopArrayList.add(laptop);
    }

    public void exportDataToDB() {
        try {
            Connection connection = DriverManager
                    .getConnection(URL, USER, PASSWORD);
            extractDataToDB(connection, tableModel);
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
