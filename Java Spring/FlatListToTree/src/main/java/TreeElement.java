import java.util.List;

public class TreeElement {

    private final Element element;
    private final List<TreeElement> elements;

    public TreeElement(Element element, List<TreeElement> elements) {
        this.element = element;
        this.elements = elements;
    }

    public Element getElement() {
        return element;
    }

    public List<TreeElement> getElements() {
        return elements;
    }

    @Override
    public String toString() {
        return "TreeElement{" +
                "element=" + element +
                ", elements=" + elements+
                '}';
    }
}
