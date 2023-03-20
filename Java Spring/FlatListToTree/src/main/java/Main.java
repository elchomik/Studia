import java.util.ArrayList;
import java.util.List;


public class Main {

    public static void main(String[] args) {

        List<Element> elements = new ArrayList<>();
        elements.add(new Element(1L,"Object 1", null));
        elements.add(new Element(2L,"Object 2", 1L));
        elements.add(new Element(3L,"Object 3", 1L));
        elements.add(new Element(4L,"Object 4", 3L));
        elements.add(new Element(5L,"Object 5", 6L));
        elements.add(new Element(6L,"Object 6", 2L));
        elements.add(new Element(7L,"Object 7", 1L));
        elements.add(new Element(8L,"Object 8", 14L));
        elements.add(new Element(9L,"Object 9", 4L));
        elements.add(new Element(10L,"Object 10", 3L));
        elements.add(new Element(11L,"Object 11", 5L));
        elements.add(new Element(12L,"Object 12", 6L));
        elements.add(new Element(13L,"Object 13", 8L));
        elements.add(new Element(14L,"Object 14", null));

        List<TreeElement> treeElements = mapFlatListToTree(elements, null);

        treeElements.forEach(element -> System.out.println(
                 element.getElement().toString() + " " + element.getElements().toString()));

    }

    private static List<TreeElement> mapFlatListToTree(List<Element> elements, Long parentId) {
       return elements.stream().filter(element -> element.getParentId() == parentId)
               .map(element -> new TreeElement(element,
                       mapFlatListToTree(elements, element.getId())))
               .toList();
    }
}
