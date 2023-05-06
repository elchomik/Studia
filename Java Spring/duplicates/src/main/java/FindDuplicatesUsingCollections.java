import java.util.*;

class FindDuplicatesUsingCollections {

    FindDuplicatesUsingCollections() {
    }

    //This approach takes O(n) time for n elements in a list and extra space of size n for the set
    List<Integer> duplicateListUsingSet(List<Integer> list) {
        List<Integer> duplicates = new ArrayList<>();
        Set<Integer> setOfElements = new HashSet<>();
        list.forEach(element -> {
            if (setOfElements.contains(element)) {
                duplicates.add(element);
            } else {
                setOfElements.add(element);
            }
        });
        return duplicates;
    }

    List<Integer> findDuplicateUsingMap(List<Integer> list) {
        List<Integer> duplicates = new ArrayList<>();
        Map<Integer, Integer> map = new HashMap<>();
        list.forEach(element -> map.put(element, map.getOrDefault(element, 0) + 1));
        map.keySet().forEach(element -> addToDuplicates(duplicates, map, element));

        return duplicates;
    }

    private static void addToDuplicates(List<Integer> duplicates, Map<Integer, Integer> map, Integer element) {
        if (map.get(element) != 1) {
            duplicates.add(element);
        }
    }
}
