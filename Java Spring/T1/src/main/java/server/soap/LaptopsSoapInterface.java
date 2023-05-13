package server.soap;

import server.database.DeviceList;

import javax.jws.WebMethod;
import javax.jws.WebService;
import javax.jws.soap.SOAPBinding;
import java.sql.SQLException;

import static javax.jws.soap.SOAPBinding.Style.RPC;

@WebService
@SOAPBinding(style = RPC)
public interface LaptopsSoapInterface {

    @WebMethod
    long getLaptopCountsFilterByProducer(final String producerName) throws SQLException;

    @WebMethod
    DeviceList getAllDevicesByScreenType(final String screenResolution) throws SQLException;

    @WebMethod
    long getDeviceCountByScreenResolution(final String screenSize) throws SQLException;
}
