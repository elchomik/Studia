import javax.xml.bind.annotation.*;

@XmlRootElement(name = "laptop")
@XmlAccessorType(XmlAccessType.FIELD)
class Laptop {

    @XmlAttribute(name = "id")
    private int id;

    private String manufacturer;

    @XmlElement(name = "screen")
    private Screen screen;

    @XmlElement(name = "processor")
    private Processor processor;

    private String ram;

    @XmlElement(name = "disc")
    private Disc disc;

    @XmlElement(name = "graphic_card")
    private GraphicCard graphicCard;

    private String os;

    @XmlElement(name = "disc_reader")
    private String discReader;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getManufacturer() {
        return manufacturer;
    }

    public void setManufacturer(String manufacturer) {
        this.manufacturer = manufacturer;
    }

    public Screen getScreen() {
        return screen;
    }

    public void setScreen(Screen screen) {
        this.screen = screen;
    }

    public Processor getProcessor() {
        return processor;
    }

    public void setProcessor(Processor processor) {
        this.processor = processor;
    }

    public String getRam() {
        return ram;
    }

    public void setRam(String ram) {
        this.ram = ram;
    }

    public Disc getDisc() {
        return disc;
    }

    public void setDisc(Disc disc) {
        this.disc = disc;
    }

    public GraphicCard getGraphicCard() {
        return graphicCard;
    }

    public void setGraphicCard(GraphicCard graphicCard) {
        this.graphicCard = graphicCard;
    }

    public String getOs() {
        return os;
    }

    public void setOs(String os) {
        this.os = os;
    }

    public String getDiscReader() {
        return discReader;
    }

    public void setDiscReader(String discReader) {
        this.discReader = discReader;
    }
}
