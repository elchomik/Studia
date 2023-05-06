import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

public class FindDuplicatesUsingCollectionsTest {

    private List<Integer> list;
    private FindDuplicatesUsingCollections findDuplicatesUsingCollections;
    private List<Integer> duplicatedList;

    @BeforeEach
    void init() {
        list = Arrays.asList(1,2,3,4,5,4,5);
        findDuplicatesUsingCollections = new FindDuplicatesUsingCollections();
    }

    @Test
    void givenList_whenUsingSet_thenReturnDuplicateElements() {
        //GIVEN

        //WHEN
        duplicatedList = findDuplicatesUsingCollections.duplicateListUsingSet(list);

        //THEN
        assertEquals(duplicatedList.size(), 2);
        assertTrue(duplicatedList.contains(4));
        assertTrue(duplicatedList.contains(5));
        assertFalse(duplicatedList.contains(3));
    }

    @Test
    @DisplayName("Should find duplicate in List using Map")
    void givenList_whenUsingMap_thenReturnDuplicateElements() {
        //GIVEN

        //WHEN
        duplicatedList = findDuplicatesUsingCollections.findDuplicateUsingMap(list);

        //THEN
        assertEquals(duplicatedList.size(), 2);
        assertTrue(duplicatedList.contains(4));
        assertTrue(duplicatedList.contains(5));
        assertFalse(duplicatedList.contains(3));
    }
}
