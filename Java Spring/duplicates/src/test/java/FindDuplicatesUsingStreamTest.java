import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

public class FindDuplicatesUsingStreamTest {

    private List<Integer> list;
    private FindDuplicatesUsingStream findDuplicatesUsingStream;

    private List<Integer> duplicatedList;

    @BeforeEach
    void init() {
        list = Arrays.asList(1, 2, 3, 3, 4, 4, 5);
        findDuplicatesUsingStream = new FindDuplicatesUsingStream();
    }

    @Test
    void shouldFindDuplicatesUsingStream() {
        //GIVEN

        //WHEN
        duplicatedList = findDuplicatesUsingStream.listDuplicateUsingFilterAndSetAdd(list);

        //THEN
        assertEquals(duplicatedList.size(), 2);
        assertTrue(duplicatedList.contains(3));
        assertTrue(duplicatedList.contains(4));
        assertFalse(duplicatedList.contains(5));
    }

    @Test
    @DisplayName("Should find duplicates using Collections.frequency()")
    void shouldFindDuplicatesUsingStreamAndCollectionsFrequency() {
        //GIVEN

        //WHEN
        duplicatedList = findDuplicatesUsingStream.listDuplicateUsingCollectionsFrequency(list);

        //THEN
        assertEquals(duplicatedList.size(), 2);
        assertTrue(duplicatedList.contains(3));
        assertTrue(duplicatedList.contains(4));
        assertFalse(duplicatedList.contains(5));
    }

    @Test
    void shouldFindDuplicatesUsingStreamAndCollectorsGroupingBy() {
        //GIVEN

        //WHEN
        duplicatedList = findDuplicatesUsingStream.listDuplicateUsingMapAndCollectorsGroupingBy(list);

        //THEN
        assertEquals(duplicatedList.size(), 2);
        assertTrue(duplicatedList.contains(3));
        assertTrue(duplicatedList.contains(4));
        assertFalse(duplicatedList.contains(5));
    }
}
