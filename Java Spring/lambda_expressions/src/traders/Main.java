package traders;

import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

public class Main {

    public static void main(String[] args) {

        Trader rsoul=new Trader("Rsoul","Cambridge");
        Trader mario=new Trader("Mario","Milan");
        Trader alan=new Trader("Alan","Cambridge");
        Trader brian=new Trader("Brian","Cambridge");

        List<Transaction> transactions= Arrays.asList(
          new Transaction(brian,2011,300),
          new Transaction(rsoul,2012,1000),
          new Transaction(rsoul,2011,400),
          new Transaction(mario,2012,710),
          new Transaction(mario,2012,700),
          new Transaction(alan,2012,950)
        );

        System.out.println("Podpunkt 1");
        //1
        List<Transaction> transactions1=
                transactions.stream()
                        .filter(t->t.getYear()==2011)
                        .sorted(Comparator.comparing(Transaction::getValue))
                        .collect(Collectors.toList());
        transactions1.forEach(System.out::println);

        //2
        System.out.println("Podpunkt 2\n");
        List<String> cities=
                transactions.stream()
                        .map(transaction -> transaction.getTrader())
                        .map(Trader::getCity)
                        .distinct()
                        .collect(Collectors.toList());

        cities.forEach(System.out::println);

        //3
        System.out.println("Podpunkt 3\n");
        List<Trader> traders=
                transactions.stream()
                        .map(Transaction::getTrader)
                        .filter(trader -> trader.getCity().equals("Cambridge"))
                        .sorted(Comparator.comparing(Trader::getName))
                        .collect(Collectors.toList());
        traders.forEach(System.out::println);

        //4
        System.out.println("Podpunkt 4\n");
        String nameOfTraders=
                transactions.stream()
                        .map(Transaction::getTrader)
                        .map(Trader::getName)
                        .distinct()
                        .sorted()
                        .reduce("",(n1,n2)->n1+n2);

        System.out.println(nameOfTraders);

        //Podpunkt 5

      boolean milanBased=transactions
              .stream()
              .anyMatch(transaction -> transaction.getTrader().getCity().equals("Milan"));
        System.out.println(milanBased);
    }
}
