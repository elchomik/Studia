package client;

import server.database.Device;
import server.database.DeviceList;
import server.soap.LaptopsSoapInterface;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import javax.xml.namespace.QName;
import javax.xml.ws.Service;
import java.awt.*;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.SQLException;
import java.util.List;

import static java.awt.FlowLayout.LEFT;
import static java.util.Arrays.asList;
import static javax.swing.Box.createHorizontalStrut;

public class Client extends JFrame {
    private static final String URL_ADDRESS = "http://localhost:8080/laptops?wsdl";
    private static final String SOAP_SERVER = "http://soap.server/";
    private static final String SOAP_INTERFACE = "LaptopSoapInterfaceImplService";

    private static final String[] MATRIX_LIST = {"matowa", "Brak", "blyszczaca"};
    private static final String[] PRODUCER_LIST = {"Dell", "Sony", "Samsung", "Fujitsu", "MSI", "Huawei"};
    private static final String[] SCREEN_RESOLUTION_LIST = {"1600x900", "1366x768", "1400x1150", "1920x1080"};
    private static final int X = 80;
    private static final int Y = 80;
    private static final int WIDTH = 90;
    private static final int HEIGHT = 40;
    private static final int FIELD_WIDTH = 150;
    private static final int FIELD_HEIGHT = 30;

    private final JTable table;
    private final DefaultTableModel tableModel;


    public Client() {
        setTitle("Client SOAP");
        setSize(1200, 700);
        setDefaultCloseOperation(EXIT_ON_CLOSE);

        final JPanel panel = new JPanel();
        panel.setLayout(new FlowLayout());

        final JPanel rowPanel = new JPanel(new FlowLayout(LEFT));

        rowPanel.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));

        final JLabel matrixLabel = new JLabel("Wybór matrycy");
        final JLabel matrixLaptopsCountLabel = new JLabel("0");
        final JLabel producerLabel = new JLabel("Wybór producenta");
        final JLabel producerLaptopsCountLabel = new JLabel("0");

        final JComboBox<String> matrixBox = new JComboBox<>(MATRIX_LIST);
        matrixBox.setBounds(X, Y, WIDTH, HEIGHT);

        final JComboBox<String> producerBox = new JComboBox<>(PRODUCER_LIST);
        producerBox.setBounds(X, Y, WIDTH, HEIGHT);

        final JComboBox<String> screenResolutionBox = new JComboBox<>(SCREEN_RESOLUTION_LIST);
        producerBox.setBounds(X, Y, WIDTH, HEIGHT);

        final JButton matrixBtn = new JButton("Liczba laptopów z określoną matrycą");
        matrixBtn.setPreferredSize(new Dimension(FIELD_WIDTH, FIELD_HEIGHT));

        final JButton producerBtn = new JButton("Liczba laptopów producenta");
        producerBtn.setPreferredSize(new Dimension(FIELD_WIDTH, FIELD_HEIGHT));

        final JButton allDevicesBtn = new JButton("Pobierz dane");
        allDevicesBtn.setPreferredSize(new Dimension(FIELD_WIDTH, FIELD_HEIGHT));

        tableModel = new DefaultTableModel();
        table = new JTable(tableModel);

        final JScrollPane jScrollPane = new JScrollPane(table);
        jScrollPane.setPreferredSize(new Dimension(getWidth(), getHeight()));


        matrixBtn.addActionListener(l -> {
            final String selectedMatrixType = matrixBox.getItemAt(matrixBox.getSelectedIndex());
            try {
                final long deviceCountByScreenType = fetchDataFromDBByScreenResolution(selectedMatrixType);
                matrixLaptopsCountLabel.setText(String.valueOf(deviceCountByScreenType));
            } catch (MalformedURLException | SQLException e) {
                e.printStackTrace();
            }
        });

        producerBtn.addActionListener(l -> {
            final String selectedProducerName = producerBox.getItemAt(producerBox.getSelectedIndex());
            try {
                final long producerDevicesCount = fetchDataFromDBFilterByProducer(selectedProducerName);
                producerLaptopsCountLabel.setText(String.valueOf(producerDevicesCount));
            } catch (MalformedURLException | SQLException e) {
                e.printStackTrace();
            }
        });

        allDevicesBtn.addActionListener(l -> {
            clearTableRows();
            final String selectedScreenResolution = screenResolutionBox.getItemAt(screenResolutionBox.getSelectedIndex());
            try {
                fetchDataFromDbByScreenResolution(selectedScreenResolution);
            } catch (MalformedURLException | SQLException e) {
                 e.printStackTrace();
            }
        });

        rowPanel.add(matrixLabel);
        rowPanel.add(createHorizontalStrut(12));
        rowPanel.add(matrixBox);
        rowPanel.add(createHorizontalStrut(12));
        rowPanel.add(matrixBtn);
        rowPanel.add(createHorizontalStrut(12));
        rowPanel.add(matrixLaptopsCountLabel);
        rowPanel.add(createHorizontalStrut(12));
        rowPanel.add(allDevicesBtn);
        rowPanel.add(createHorizontalStrut(12));
        rowPanel.add(screenResolutionBox);
        rowPanel.add(createHorizontalStrut(40));
        rowPanel.add(producerLabel);
        rowPanel.add(createHorizontalStrut(12));
        rowPanel.add(producerBox);
        rowPanel.add(createHorizontalStrut(12));
        rowPanel.add(producerBtn);
        rowPanel.add(createHorizontalStrut(12));
        rowPanel.add(producerLaptopsCountLabel);

        asList("Nr", "Producent", "Ekran", "Rozdzielczość", "Powierzchnia", "Dotykowy", "Procesor",
                "Rdzenie", "Taktowanie", "RAM", "Dysk", "Rodzaj dysku", "Układ graficzny", "Pamięć graf.", "System", "Napęd").forEach(tableModel::addColumn);

        panel.add(rowPanel, BorderLayout.NORTH);
        panel.add(jScrollPane);


        add(panel);
        setVisible(true);
    }

    private void clearTableRows() {
        int rowCount = table.getRowCount();
        if(rowCount!=0) {
            int i = 0;
            while (i < rowCount) {
                tableModel.removeRow(0);
                i++;
            }
        }
    }

    private LaptopsSoapInterface configureSOAPConnection() throws MalformedURLException {
        final URL url = new URL(URL_ADDRESS);
        final QName qname = new QName(SOAP_SERVER, SOAP_INTERFACE);
        final Service service = Service.create(url, qname);
        return service.getPort(LaptopsSoapInterface.class);
    }

    private long fetchDataFromDBByScreenResolution(final String screenResolution) throws MalformedURLException, SQLException {
        final LaptopsSoapInterface laptopsSoapInterface = configureSOAPConnection();
        return laptopsSoapInterface.getDeviceCountByScreenResolution(screenResolution);
    }

    private long fetchDataFromDBFilterByProducer(final String producerName) throws MalformedURLException, SQLException {
        final LaptopsSoapInterface laptopsSoapInterface = configureSOAPConnection();
        return laptopsSoapInterface.getLaptopCountsFilterByProducer(producerName);
    }

    private void fetchDataFromDbByScreenResolution(final String screenResolutionParam) throws MalformedURLException, SQLException {
        final LaptopsSoapInterface laptopsSoapInterface = configureSOAPConnection();
        final DeviceList allDevicesByScreenResolution = laptopsSoapInterface.getAllDevicesByScreenSize(screenResolutionParam);
        final List<Device> devices = allDevicesByScreenResolution.getDevices();

        for (Device device : devices) {
            int id = device.id();
            String manufacturer = device.manufacturer();
            String touch = device.touch();
            String screenSize = device.screenSize();
            String screenResolution = device.screenResolution();
            String screenType = device.screenType();
            String processorName = device.processorName();
            int physicalCores = device.physicalCores();
            int clockSpeed = device.clockSpeed();
            String ram = device.ram();
            String discType = device.discType();
            String discStorage = device.discStorage();
            String os = device.os();
            String discReader = device.discReader();
            String graphicCardName = device.graphicCardName();
            String graphicCardMemory = device.graphicCardMemory();
            tableModel.addRow(new Object[]{id, manufacturer, touch, screenSize, screenResolution, screenType,
                    processorName, physicalCores, clockSpeed, ram, discType, discStorage, os, discReader, graphicCardName,
                    graphicCardMemory});
        }
    }
}
