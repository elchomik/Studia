package server.soap;

import server.database.Device;
import server.database.DeviceList;

import javax.jws.WebService;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Objects;

import static server.database.ConnectionDB.*;

@WebService(endpointInterface = "server.soap.LaptopsSoapInterface")
public class LaptopSoapInterfaceImpl implements LaptopsSoapInterface {

    @Override
    public long getLaptopCountsFilterByProducer(String producerName) throws SQLException {
        final Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
        final int devices = selectDevicesCountByProducer(connection, producerName);
        connection.close();
        return devices;
    }

    @Override
    public DeviceList getAllDevicesByScreenType(String screenType) throws SQLException {
        final Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
        final ResultSet resultSet = selectDevicesByScreenType(connection, screenType);
        final ArrayList<Device> deviceFromDB = new ArrayList<>();

        while (resultSet.next()) {
            Device device = getDevice(resultSet);
            deviceFromDB.add(device);
        }

        connection.close();
        return new DeviceList(deviceFromDB);
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

    private String setTextIfApplicable(String value) {
        return (Objects.isNull(value) || value.isEmpty()) ? "Brak" : value;
    }

    @Override
    public long getDeviceCountByScreenResolution(String screenResolution) throws SQLException {
        final Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
        final int devicesCount = selectDevicesCountByScreenResolution(connection, screenResolution);
        connection.close();
        return devicesCount;
    }
}
