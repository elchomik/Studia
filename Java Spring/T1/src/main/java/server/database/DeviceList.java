package server.database;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.ArrayList;
import java.util.List;

@XmlRootElement(name = "DeviceList")
public class DeviceList {

    private List<Device> devices;

    public DeviceList(){
        devices = new ArrayList<>();
    }
    public DeviceList(List<Device> devices) {
        this.devices = devices;
    }

    @XmlElement(name = "device")
    public List<Device> getDevices() {
        return devices;
    }
}
