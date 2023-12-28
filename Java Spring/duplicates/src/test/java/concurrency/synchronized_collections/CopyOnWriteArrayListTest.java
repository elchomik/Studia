package concurrency.synchronized_collections;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

import static org.junit.jupiter.api.Assertions.*;

public class CopyOnWriteArrayListTest {

    CopyOnWriteArrayList<Long> numbers;
    Iterator<Long> numberIterator;

    @BeforeEach
    void setUp() {
        List<Long> data = List.of(1L, 2L, 3L, 15L, 17L);
        numbers = new CopyOnWriteArrayList<>(data);
        numberIterator = numbers.iterator();
    }
    @Test
    void shouldNotChangeTheIterator() {

        //WHEN
        numbers.add(120L);
        numbers.add(43L);

        //THEN
        LinkedList<Long> iteratingResult = new LinkedList<>();
        numberIterator.forEachRemaining(iteratingResult::add);
        assertFalse(iteratingResult.contains(120L));
        assertFalse(iteratingResult.contains(43L));

        Iterator<Long> secondIterator = numbers.iterator();
        List<Long> secondIteratingResult = new LinkedList<>();
        secondIterator.forEachRemaining(secondIteratingResult::add);
        assertTrue(secondIteratingResult.contains(120L));
        assertTrue(secondIteratingResult.contains(43L));

    }

    @Test
    void shouldThrowExceptionWhileDeleteElement() {
        //GIVEN

        //WHEN

        //THEN
        assertThrows(UnsupportedOperationException.class, () -> {
            while (numberIterator.hasNext()) numberIterator.remove();
        });
    }
}
