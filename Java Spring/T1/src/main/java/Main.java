import client.Client;
import server.Server;
import server.soap.LaptopSoapInterfaceImpl;

import java.net.MalformedURLException;
import java.sql.SQLException;

import static javax.xml.ws.Endpoint.publish;

public class Main {

    public static void main(String[] args) throws MalformedURLException, SQLException {
        new Server();
        publish("http://localhost:8080/laptops",new LaptopSoapInterfaceImpl());
        new Client("matowy");
    }

}
