import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;

@XmlAccessorType(XmlAccessType.FIELD)
class Disc {

    @XmlAttribute(name = "type")
    private String type;

    private String storage;

    private Disc() {
    }

    public Disc(String type, String storage) {
        this.type = type;
        this.storage = storage;
    }

    public String getType() {
        return type;
    }

    public String getStorage() {
        return storage;
    }

}
