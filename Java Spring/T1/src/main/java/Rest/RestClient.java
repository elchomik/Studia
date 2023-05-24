package Rest;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import static java.awt.FlowLayout.LEFT;
import static java.util.Arrays.asList;
import static javax.swing.Box.createHorizontalStrut;

public class RestClient extends JFrame {

    private static final String REST_URL = "https://api.spacexdata.com/v4/rockets";
    private final ArrayList<String> rocketNames = new ArrayList<>();
    private final ArrayList<String> rocketCountries = new ArrayList<>();
    private final ArrayList<String> rocketIds = new ArrayList<>();
    private final DefaultTableModel tableModel;
    private final JTable table;
    private final JComboBox<String> rocketNamesBox;
    private final JComboBox<String> rocketCountryBox;
    private final JComboBox<String> rocketIdsBox;

    private static final int X = 80;
    private static final int Y = 80;
    private static final int WIDTH = 90;
    private static final int HEIGHT = 40;
    private static final int FIELD_WIDTH = 150;
    private static final int FIELD_HEIGHT = 30;

    private final Set<Rocket> dataFromAPI;

    public RestClient() {
        setSize(1200, 700);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        final JPanel panel = new JPanel();
        panel.setLayout(new FlowLayout());

        final JPanel rowPanel = new JPanel(new FlowLayout(LEFT));
        rowPanel.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));

        final JLabel rocketNameLabel = new JLabel("Nazwa rakiety");
        final JLabel rocketNamesCount = new JLabel("0");
        final JLabel rocketCountryLabel = new JLabel("Wybór producenta");
        final JLabel rocketCountryCount = new JLabel("0");

        rocketNamesBox = new JComboBox<>();
        rocketNamesBox.setBounds(X, Y, WIDTH, HEIGHT);

        rocketCountryBox = new JComboBox<>();
        rocketCountryBox.setBounds(X, Y, WIDTH, HEIGHT);

        rocketIdsBox = new JComboBox<>();
        rocketCountryBox.setBounds(X, Y, WIDTH, HEIGHT);

        final JButton rocketNameBtn = new JButton("Liczba rakiet o nazwie");
        rocketNameBtn.setPreferredSize(new Dimension(FIELD_WIDTH, FIELD_HEIGHT));

        final JButton rocketCountryBtn = new JButton("Liczba rakiet o wymiarze");
        rocketCountryBtn.setPreferredSize(new Dimension(FIELD_WIDTH, FIELD_HEIGHT));

        final JButton rocketIdBtn = new JButton("Wyświetl rakietę o id");
        rocketIdBtn.setPreferredSize(new Dimension(FIELD_WIDTH, FIELD_HEIGHT));

        dataFromAPI = new HashSet<>();
        tableModel = new DefaultTableModel();
        table = new JTable(tableModel);


        asList("Id", "Nazwa", "Kraj", "Firma", "Rozmiar", "Etapy",
                "Waga", "Koszty", "Data pierwszego lotu").forEach(tableModel::addColumn);

        final JScrollPane scrollPane = new JScrollPane(table);
        scrollPane.setPreferredSize(new Dimension(getWidth(), getHeight()));

        rowPanel.add(rocketNameLabel);
        rowPanel.add(createHorizontalStrut(12));
        rowPanel.add(rocketNamesBox);
        rowPanel.add(createHorizontalStrut(12));
        rowPanel.add(rocketNameBtn);
        rowPanel.add(createHorizontalStrut(12));
        rowPanel.add(rocketNamesCount);
        rowPanel.add(createHorizontalStrut(12));
        rowPanel.add(rocketIdBtn);
        rowPanel.add(createHorizontalStrut(12));
        rowPanel.add(rocketIdsBox);
        rowPanel.add(createHorizontalStrut(40));
        rowPanel.add(rocketCountryLabel);
        rowPanel.add(createHorizontalStrut(12));
        rowPanel.add(rocketCountryBox);
        rowPanel.add(createHorizontalStrut(12));
        rowPanel.add(rocketCountryBtn);
        rowPanel.add(createHorizontalStrut(12));
        rowPanel.add(rocketCountryCount);
        panel.add(rowPanel, BorderLayout.NORTH);
        panel.add(scrollPane);

        rocketIdBtn.addActionListener(l -> {
            clearTableRows();
            final String selectedRocketId = rocketIdsBox.getItemAt(rocketIdsBox.getSelectedIndex());
            Rocket rocketData = dataFromAPI.stream().filter(rocket -> rocket.rocketId().equals(selectedRocketId))
                    .findFirst().get();
            tableModel.addRow(new Object[]{rocketData.rocketId(), rocketData.rocketName(),
                    rocketData.country(), rocketData.company(), rocketData.rocketHeight(),
                    rocketData.stages(), rocketData.rocketMass(), rocketData.costPerLaunch(),
                    rocketData.firstFlight()});
        });


        rocketNameBtn.addActionListener(l -> {
            final String selectedRocketName = rocketNamesBox.getItemAt(rocketNamesBox.getSelectedIndex());
            long selectedRocketNames = dataFromAPI.stream().filter(rocket -> rocket.rocketName().equals(selectedRocketName))
                    .count();
            rocketNamesCount.setText(String.valueOf(selectedRocketNames));
        });

        rocketCountryBtn.addActionListener(l -> {
            clearTableRows();
            final String selectedRocketCountry = rocketCountryBox.getItemAt(rocketCountryBox.getSelectedIndex());
            List<Rocket> rockets = dataFromAPI.stream().filter(rocket ->
                    rocket.country().equals(selectedRocketCountry)).toList();

            rockets.forEach(a -> tableModel.addRow(new Object[]{a.rocketId(), a.rocketName(),
                    a.country(), a.company(), a.rocketHeight(),
                    a.stages(), a.rocketMass(), a.costPerLaunch(),
                    a.firstFlight()}));

            int sum = rockets.stream().mapToInt(Rocket::costPerLaunch).sum();
            rocketCountryLabel.setText(String.valueOf(sum));
        });

        add(panel);
        setVisible(true);
        fetchDataFromApi();
    }

    private void fetchDataFromApi() {
        HttpClient httpClient = HttpClient.newHttpClient();
        HttpRequest httpRequest = HttpRequest.newBuilder()
                .uri(URI.create(REST_URL))
                .build();
        try {
            HttpResponse<String> response = httpClient.send(httpRequest, HttpResponse.BodyHandlers.ofString());
            String body = response.body();
            ObjectMapper objectMapper = new ObjectMapper();
            int size = objectMapper.readTree(body).size();
            for (int i = 0; i < size; i++) {
                JsonNode jsonNode = objectMapper.readTree(body).get(i);
                String rocketName = jsonNode.get("name").asText();
                int stages = jsonNode.get("stages").asInt();
                String country = jsonNode.get("country").asText();
                String company = jsonNode.get("company").asText();
                String rocketId = jsonNode.get("id").asText();
                String rocketHeight = jsonNode.get("height").get("meters").asText();
                int rocketMass = jsonNode.get("mass").get("kg").asInt();
                int costPerLaunch = jsonNode.get("cost_per_launch").asInt();
                String firstFlight = jsonNode.get("first_flight").asText();
                addToModels(rocketName, rocketId, country);
                dataFromAPI.add(new Rocket(rocketId, rocketName, country, company, rocketHeight, stages, rocketMass, costPerLaunch, firstFlight));
                tableModel.addRow(new Object[]{rocketId, rocketName, country, company, rocketHeight, stages, rocketMass, costPerLaunch, firstFlight});
            }
        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
        }
    }

    private void addToModels(String rocketName, String rocketId, String country) {
        if (!rocketNames.contains(rocketName)) {
            rocketNames.add(rocketName);
        }

        if (!rocketIds.contains(rocketId)) {
            rocketIds.add(rocketId);
        }

        if (!rocketCountries.contains(country)) {
            rocketCountries.add(country);
        }

        var rocketNamesModel = new DefaultComboBoxModel<>(rocketNames.toArray(new String[0]));
        rocketNamesBox.setModel(rocketNamesModel);

        var rocketSizeModel = new DefaultComboBoxModel<>(rocketCountries.toArray(new String[0]));
        rocketCountryBox.setModel(rocketSizeModel);

        var rocketIdsModel = new DefaultComboBoxModel<>(rocketIds.toArray(new String[0]));
        rocketIdsBox.setModel(rocketIdsModel);
    }

    private void clearTableRows() {
        int rowCount = table.getRowCount();
        if (rowCount != 0) {
            int i = 0;
            while (i < rowCount) {
                tableModel.removeRow(0);
                i++;
            }
        }
    }
}
