package xml.catalogue;

import javax.xml.bind.annotation.*;
import java.util.List;

@XmlRootElement(name = "laptops")
@XmlAccessorType(XmlAccessType.FIELD)
public class Laptops {


    @XmlElement(name = "laptop")
    private List<Laptop> laptops;

    @XmlAttribute(name = "moddate")
    private String moddate;

    public String getModdate() {
        return moddate;
    }

    public void setModdate(String moddate) {
        this.moddate = moddate;
    }

    public List<Laptop> getLaptops() {
        return laptops;
    }

    public void setLaptops(List<Laptop> laptops) {
        this.laptops = laptops;
    }

}
