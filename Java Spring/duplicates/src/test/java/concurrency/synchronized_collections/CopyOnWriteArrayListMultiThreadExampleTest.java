package concurrency.synchronized_collections;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.Set;
import java.util.concurrent.*;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;

public class CopyOnWriteArrayListMultiThreadExampleTest {

    Set<String> fruits;
    Iterator<String> fruitsIterator;

    final CopyOnWriteArrayList<String> threadName = new CopyOnWriteArrayList<>();

    @BeforeEach
    void setUp() {
        fruits = new CopyOnWriteArraySet<>(Set.of("Banana", "Apple", "Orange", "Cherry"));
        fruitsIterator = fruits.iterator();
    }

    private Callable<Void> addFruitToFruits(String fruitName) {
        return () -> {
            fruits.add(fruitName);
            threadName.add("Thread " + Thread.currentThread().getName());
            return null;
        };
    }

    private Callable<Void> removeFruit(String fruitName) {
        return () -> {
            fruits.remove(fruitName);
            threadName.add(Thread.currentThread().getName());
            return null;
        };
    }

    @Test
    void testCopyOnWriteArrayList() throws InterruptedException {
        //GIVEN
        ExecutorService service = Executors.newFixedThreadPool(3);

        Callable<Void> lemonThread = addFruitToFruits("Lemon");
        Callable<Void> pineappleThread = removeFruit("Pineapple");
        Callable<Void> pearThread = addFruitToFruits("Pear");

        //WHEN
        service.invokeAll(Set.of(lemonThread, pearThread, pineappleThread));
        service.shutdown();
        Set<String> fruitResultAfterAdding = new LinkedHashSet<>();
        fruitsIterator.forEachRemaining(fruitResultAfterAdding::add);
        Set<String> fruitAfterTaskFinished = new LinkedHashSet<>();
        Iterator<String> iterator = fruits.iterator();
        iterator.forEachRemaining(fruitAfterTaskFinished::add);

        //THEN
        assertEquals(4,fruitResultAfterAdding.size());
        assertEquals(6, fruitAfterTaskFinished.size());
        assertFalse(fruitResultAfterAdding.contains("Lemon"));
        assertFalse(fruitResultAfterAdding.contains("Pineapple"));
        assertFalse(fruitResultAfterAdding.contains("Pear"));
        assertEquals(3, threadName.size());
    }

}
