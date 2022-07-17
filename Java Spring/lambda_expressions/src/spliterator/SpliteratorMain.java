package spliterator;

import java.util.stream.IntStream;
import java.util.stream.Stream;
import java.util.Spliterator;
import java.util.stream.StreamSupport;

import static spliterator.WordCounter.countWords;

public class SpliteratorMain {

    public static int countWordsIteratively(String sentence) {
        int counter = 0;
        boolean lastSpace = true;
        for (char c : sentence.toCharArray()) {
            if (Character.isWhitespace(c)) {
                lastSpace = true;
            } else {
                if (lastSpace)
                    counter++;
                lastSpace = false;
            }
        }
        return counter;
    }

    public static void main(String[] args) {
        final String SENTENCE = "Nel mezzo del cammin di nostra vita" +
                " mi ritrovai in una selva oscura" +
                " che la dritta via era smarrita";

        System.out.println("Found " + countWordsIteratively(SENTENCE) + " words ");

        Stream<Character> stream= IntStream.range(0,SENTENCE.length())
                .mapToObj(SENTENCE::charAt);
        System.out.println("Found "+ countWords(stream)+ " words");

        Spliterator<Character> spliterator=new WordCounterSpliterator(SENTENCE);
        Stream<Character> stream1= StreamSupport.stream(spliterator,true);

        System.out.println("Found "+ countWords(stream1)+ " words");

    }

}
