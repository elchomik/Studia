package xml.catalogue;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;

@XmlAccessorType(XmlAccessType.FIELD)
public class Processor {

    private String name;

    @XmlElement(name = "physical_cores")
    private String physicalCores;

    private Processor() {
    }

    @XmlElement(name = "clock_speed")
    private String clockSpeed;

    public Processor(String name, String physicalCores, String clockSpeed) {
        this.name = name;
        this.physicalCores = physicalCores;
        this.clockSpeed = clockSpeed;
    }

    public String getName() {
        return name;
    }

    public String getPhysicalCores() {
        return physicalCores;
    }

    public String getClockSpeed() {
        return clockSpeed;
    }

}
