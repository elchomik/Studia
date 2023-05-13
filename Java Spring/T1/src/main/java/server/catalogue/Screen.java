package server.catalogue;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;

@XmlAccessorType(XmlAccessType.FIELD)
public class Screen {

    private String size;

    @XmlAttribute(name = "touch")
    private String touch;

    private String resolution;

    private String type;

    private Screen() {
    }

    public Screen(String size, String touch, String resolution, String type) {
        this.size = size;
        this.touch = touch;
        this.resolution = resolution;
        this.type = type;
    }

    public String getSize() {
        return size;
    }
    public String getTouch() {
        return touch;
    }

    public String getResolution() {
        return resolution;
    }

    public String getType() {
        return type;
    }

}
