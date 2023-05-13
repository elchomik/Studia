package client;

import server.database.DeviceList;
import server.soap.LaptopsSoapInterface;

import javax.xml.namespace.QName;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.SQLException;
import javax.xml.ws.Service;

public class Client {
    private static final String URL_ADDRESS = "http://localhost:8080/laptops?wsdl";
    private static final String SOAP_SERVER = "http://soap.server/";
    private static final String SOAP_INTERFACE = "LaptopSoapInterfaceImplService";

    public Client(final String name) throws MalformedURLException, SQLException {
        final URL url = new URL(URL_ADDRESS);
        final QName qname = new QName(SOAP_SERVER, SOAP_INTERFACE);
        final Service service = Service.create(url, qname);
        LaptopsSoapInterface port = service.getPort(LaptopsSoapInterface.class);
        DeviceList allDevicesByScreenType = port.getAllDevicesByScreenType(name);
        System.out.println( "All devices =" +allDevicesByScreenType.getDevices().size());

        long dell = port.getLaptopCountsFilterByProducer("Dell");
        System.out.println("Ilość deli = " + dell);

        long deviceCountByScreenResolution = port.getDeviceCountByScreenResolution("1600X900");
        System.out.println("Działąnie 3 metody = " + deviceCountByScreenResolution);
    }

}
