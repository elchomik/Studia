import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.function.Function;
import java.util.stream.Collectors;

import static java.util.Collections.frequency;

class FindDuplicatesUsingStream {

    List<Integer> listDuplicateUsingFilterAndSetAdd(List<Integer> list) {
        Set<Integer> elements = new HashSet<>();
        return list.stream()
                .filter(element -> !elements.add(element))
                .collect(Collectors.toList());
    }

    List<Integer> listDuplicateUsingCollectionsFrequency(List<Integer> list) {
        return list.stream()
                .filter(element -> frequency(list, element) > 1)
                .distinct()
                .collect(Collectors.toList());
    }

    List<Integer> listDuplicateUsingMapAndCollectorsGroupingBy(List<Integer> list) {
        return list
                .stream()
                .collect(Collectors.groupingBy(Function.identity(), Collectors.counting()))
                .entrySet()
                .stream()
                .filter(element -> element.getValue() > 1)
                .map(Map.Entry::getKey)
                .distinct()
                .collect(Collectors.toList());
    }
}
