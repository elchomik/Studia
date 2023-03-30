package xml.catalogue;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;

@XmlAccessorType(XmlAccessType.FIELD)
public class GraphicCard {

    private String name;
    private String memory;

    private GraphicCard() {
    }

    public GraphicCard(String name, String memory) {
        this.name = name;
        this.memory = memory;
    }

    public String getName() {
        return name;
    }

    public String getMemory() {
        return memory;
    }

}
