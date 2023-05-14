package server.catalogue;

import javax.xml.bind.annotation.*;
import java.util.List;

@XmlRootElement(name = "laptops")
@XmlAccessorType(XmlAccessType.FIELD)
public class Laptops {

    @XmlElement(name = "laptop")
    private List<Laptop> laptops;

    public void setModdate(String moddate) {
    }

    public List<Laptop> getLaptops() {
        return laptops;
    }

    public void setLaptops(List<Laptop> laptops) {
        this.laptops = laptops;
    }

}
