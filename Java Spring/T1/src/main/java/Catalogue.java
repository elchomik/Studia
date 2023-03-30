import xml.catalogue.*;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;
import java.awt.*;
import java.io.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Objects;

import static java.lang.Integer.parseInt;

public class Catalogue extends JFrame {
    private final JTable table;
    private final DefaultTableModel tableModel;
    private final JTextField sonyField;
    private final JTextField assusField;
    private final JTextField dellField;
    private final JTextField samsungField;
    private final JTextField fujitsuField;
    private final JTextField msiField;
    private final JTextField huaweiField;

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
    int sonyCount = 0;
    int asusCount = 0;
    int dellCount = 0;
    int samsungCount = 0;
    int fujitsuCount = 0;
    int msiCount = 0;
    int huaweiCount =0;

    public Catalogue() {
        setTitle("Zadanie T2");
        setSize(1000, 700);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        JPanel panel = new JPanel();
        panel.setLayout(new BorderLayout());

        JPanel buttonsPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
        JPanel textFieldPanel = new JPanel(new FlowLayout());

        sonyField = new JTextField(5);
        JLabel sonyLabel = new JLabel("Sony");

        assusField = new JTextField(5);
        JLabel assusLabel = new JLabel("Assus");

        dellField = new JTextField(5);
        JLabel dellLabel = new JLabel("Dell");

        samsungField = new JTextField(5);
        JLabel samsungLabel = new JLabel("Samsung");

        fujitsuField = new JTextField(5);
        JLabel fujistuLabel = new JLabel("Fujitsu");

        msiField = new JTextField(5);
        JLabel msiLabel = new JLabel("MSI");

        huaweiField = new JTextField(5);
        JLabel huaweiLabel = new JLabel("Huawei");


        textFieldPanel.add(sonyLabel);
        textFieldPanel.add(sonyField);

        textFieldPanel.add(assusLabel);
        textFieldPanel.add(assusField);

        textFieldPanel.add(dellLabel);
        textFieldPanel.add(dellField);

        textFieldPanel.add(samsungLabel);
        textFieldPanel.add(samsungField);

        textFieldPanel.add(fujistuLabel);
        textFieldPanel.add(fujitsuField);

        textFieldPanel.add(msiLabel);
        textFieldPanel.add(msiField);

        textFieldPanel.add(huaweiLabel);
        textFieldPanel.add(huaweiField);

        panel.add(textFieldPanel, BorderLayout.SOUTH);

        JButton importButton = new JButton("Importuj");
        importButton.setPreferredSize(new Dimension(200,20));
        JButton exportButton = new JButton("Eksportuj");
        exportButton.setPreferredSize(new Dimension(200, 20));

        JButton importXML = new JButton(" Import XML");
        importXML.setPreferredSize(new Dimension(200, 20));
        JButton exportXML = new JButton( "Export XML");
        exportXML.setPreferredSize(new Dimension(200, 20));

        importButton.addActionListener(e -> {
            JFileChooser fileChooser = new JFileChooser();
            int result = fileChooser.showOpenDialog(Catalogue.this);
            if(result == JFileChooser.APPROVE_OPTION) {
                String filePath = fileChooser.getSelectedFile().getAbsolutePath();
                importDataFromFile(filePath);
            }
        });

        exportButton.addActionListener(e->{
            JFileChooser fileChooser = new JFileChooser();
            int result = fileChooser.showSaveDialog(Catalogue.this);
            if(result == JFileChooser.APPROVE_OPTION) {
                String filePath = fileChooser.getSelectedFile().getAbsolutePath();
                exportDataToFile(filePath);
                exportDataToXMLFile(filePath);
            }
        });

        importXML.addActionListener(e -> {
            JFileChooser fileChooser = new JFileChooser();
            int result = fileChooser.showOpenDialog(Catalogue.this);
            if(result == JFileChooser.APPROVE_OPTION) {
                String filePath = fileChooser.getSelectedFile().getAbsolutePath();
                try {
                    importFromXml(filePath);
                } catch (Exception ex) {
                    throw new RuntimeException(ex);
                }
            }
        });

        exportXML.addActionListener(e->{
            JFileChooser fileChooser = new JFileChooser();
            int result = fileChooser.showSaveDialog(Catalogue.this);
            if(result == JFileChooser.APPROVE_OPTION) {
                String filePath = fileChooser.getSelectedFile().getAbsolutePath();
                exportDataToXMLFile(filePath);
            }
        });

        buttonsPanel.add(importButton);
        buttonsPanel.add(exportButton);
        buttonsPanel.add(importXML);
        buttonsPanel.add(exportXML);

        panel.add(buttonsPanel, BorderLayout.NORTH);

        tableModel = new DefaultTableModel();
        for (String s : Arrays.asList("Nr", "Producent", "Ekran", "Rozdzielczość", "Powierzchnia", "Dotykowy", "Procesor", "Rdzenie", "Taktowanie", "RAM", "Dysk", "Rodzaj dysku", "Układ graficzny", "Pamięć graf.", "System", "Napęd")) {
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

        panel.add(new JScrollPane(table), BorderLayout.CENTER);
        add(panel);
        setVisible(true);

    }

    private void validateInputData(int row, int column, String currentValue) {
        if(currentValue.isEmpty()) {
            JOptionPane.showMessageDialog(table, "Podaana wartość jest pusta, powinieneś wprowadzić wartość", "Błąd",
                    JOptionPane.ERROR_MESSAGE);
        }
        else if(isColumnWithStringValidation(column) && !isInputConatinsOnlyString(currentValue)) {
                JOptionPane.showMessageDialog(table, "Podałeś liczbę w tym polu dozwolone są tylko znaki", "Błąd",
                        JOptionPane.ERROR_MESSAGE);
        }
        else if(column == RDZENIE && !isProperIntegerValue(currentValue)) {
                JOptionPane.showMessageDialog(table, "Podałeś złą wartość, w tym polu dozwolone są tylko liczby całkowite", "Błąd",
                        JOptionPane.ERROR_MESSAGE);
        }
        else if(column == TAKTOWANIE && currentValue.length() >4 && isInputContainsOnlyDigit(currentValue)) {
            JOptionPane.showMessageDialog(table, "Za duża wartość taktowania dopuszczalne tylko 4 cyfry", "Błąd",
                    JOptionPane.ERROR_MESSAGE);
        }
        else if( column == TAKTOWANIE || column == NR && !isInputContainsOnlyDigit(currentValue)) {
            JOptionPane.showMessageDialog(table, "Ups podałeś znak a dopuszczalne tylko cyfry", "Błąd",
                    JOptionPane.ERROR_MESSAGE);
        }
        else {
            tableModel.setValueAt(currentValue, row, column);
        }
    }

    private static boolean isInputConatinsOnlyString(String input) {
        return input.chars().allMatch(Character::isLetter);
    }

    private static boolean isInputContainsOnlyDigit(String input) {
        return input.chars().allMatch(Character::isDigit);
    }

    private static boolean isColumnWithStringValidation(int column) {
        return (column == PRODUCENT || column == POWIERZCHNIA || column == DOTYKOWY
                || column == PROCESOR || column == RODZAJ || column == UKLAD || column == SYSTEM || column == NAPED);
    }
    private boolean isProperIntegerValue(String currentObjectValue) {
            try{
                parseInt(currentObjectValue);
                return true;
            }catch (NumberFormatException e){
                return false;
            }
    }

    private void importDataFromFile(String filePath) {
        try (BufferedReader bufferedReader = new BufferedReader(new FileReader(filePath))) {
            String line;
            int lineNumber = 1;
            while ((line = bufferedReader.readLine()) != null) {
                String[] fields = line.split(";" ,-1);
                setTextWhenNoValue(fields);
                tableModel.addRow(new Object[]{
                        lineNumber, fields[0], fields[1], fields[2], fields[3], fields[4], fields[5], fields[6], fields[7], fields[8],
                        fields[9], fields[10], fields[11], fields[12], fields[13], fields[14]
                });
                countDevices(fields[0]);
                lineNumber++;
            }
        } catch (IOException exception) {
            exception.printStackTrace();
        }
    }

    private void importFromXml(String file) {
        try {
            JAXBContext jaxbContext = JAXBContext.newInstance(Laptops.class);
            Unmarshaller unmarshaller = jaxbContext.createUnmarshaller();
            Laptops laptops = (Laptops) unmarshaller.unmarshal(new File(file));

            for (Laptop laptop: laptops.getLaptops()) {
                int id = laptop.getId();
                String manufacturer = setTextIfApplicable(laptop.getManufacturer());
                String touch = setTextIfApplicable(laptop.getScreen().getTouch());
                String size = setTextIfApplicable(laptop.getScreen().getSize());
                String resolution = setTextIfApplicable(laptop.getScreen().getResolution());
                String type = setTextIfApplicable(laptop.getScreen().getType());
                String name = setTextIfApplicable(laptop.getProcessor().getName());
                String physicalCores = setTextIfApplicable(laptop.getProcessor().getPhysicalCores());
                String clockSpeed = setTextIfApplicable(laptop.getProcessor().getClockSpeed());
                String ram = setTextIfApplicable(laptop.getRam());
                String discType = setTextIfApplicable(laptop.getDisc().getType());
                String discStorage = setTextIfApplicable(laptop.getDisc().getStorage());
                String os = setTextIfApplicable(laptop.getOs());
                String discReader = setTextIfApplicable(laptop.getDiscReader());
                String graphicName = setTextIfApplicable(laptop.getGraphicCard().getName());
                String memory = setTextIfApplicable(laptop.getGraphicCard().getMemory());

                tableModel.addRow(new Object[]{
                        id, manufacturer, touch, size, resolution, type, name, physicalCores,
                        clockSpeed, ram, discType, discStorage, graphicName, memory, os, discReader
                });

            }
        }catch (Exception ex){
            ex.printStackTrace();
        }
    }


    private static void setTextWhenNoValue(String[] fields) {
        int i=0;
        for(String field: fields) {
            if(field.isEmpty()) {
                fields[i] = "Brak";
            }
            i++;
        }
    }

    private static String setTextIfApplicable(String value) {
        return (Objects.isNull(value) || value.isEmpty()) ? "Brak" : value;
    }

    private void countDevices(String device) {
        switch (device) {
            case "Asus" -> {
                asusCount++;
                assusField.setText(String.valueOf(asusCount));
            }
            case "Dell" -> {
                dellCount++;
                dellField.setText(String.valueOf(dellCount));
            }
            case "Fujitsu" -> {
                fujitsuCount++;
                fujitsuField.setText(String.valueOf(fujitsuCount));
            }
            case "Huawei" -> {
                huaweiCount++;
                huaweiField.setText(String.valueOf(huaweiCount));
            }
            case "MSI" -> {
                msiCount++;
                msiField.setText(String.valueOf(msiCount));
            }
            case "Samsung" -> {
                samsungCount++;
                samsungField.setText(String.valueOf(samsungCount));
            }
            case "Sony" -> {
                sonyCount++;
                sonyField.setText(String.valueOf(sonyCount));
            }
        }
    }

    private void exportDataToFile(String filename) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filename))) {
            for(int row = 0; row < tableModel.getRowCount(); row++) {
                for(int col = 1; col < tableModel.getColumnCount(); col++) {
                    String value = tableModel.getValueAt(row, col).toString() + ";";
                    writer.write(value);
                }
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void exportDataToXMLFile(String fileName) {
        Laptops laptops = new Laptops();
        ArrayList<Laptop> laptopArrayList = new ArrayList<>();
        laptops.setModdate(String.valueOf(LocalDateTime.now()));
        for (int row = 0; row < tableModel.getRowCount(); row++) {
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
                    tableModel.getValueAt(row,10).toString(),
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
        laptops.setLaptops(laptopArrayList);
        try{
            JAXBContext jaxbContext = JAXBContext.newInstance(Laptops.class);
            Marshaller marshaller = jaxbContext.createMarshaller();
            marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE);
            marshaller.marshal(laptops, new File(fileName));

        } catch (JAXBException e) {
            throw new RuntimeException(e);
        }
    }
}
