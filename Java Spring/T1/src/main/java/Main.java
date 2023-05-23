import Rest.RestClient;
import client.Client;
import server.Server;
import server.soap.LaptopSoapInterfaceImpl;

import static javax.xml.ws.Endpoint.publish;

public class Main {

    public static void main(String[] args) {
        new Server();
        publish("http://localhost:8080/laptops",new LaptopSoapInterfaceImpl());
        new Client();
        new RestClient();
    }

}
