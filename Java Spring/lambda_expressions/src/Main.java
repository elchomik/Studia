import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.function.Consumer;
import java.util.function.Function;
import java.util.function.Predicate;
import java.util.stream.Collectors;

public class Main {

    public static void main(String[] args) {
        Person p1=new Person("Jan",24, LocalDate.of(1998,11,5), Person.Sex.MALE,"jan@kowalski.com");
        Person p2=new Person("Tomasz",20, LocalDate.of(2002,12,17), Person.Sex.MALE,"t.@wp.com");
        Person p3=new Person("Piotr",19, LocalDate.of(2003,2,24), Person.Sex.MALE,"pioter34@gmail.com");
        Person p4=new Person("Grażyna",25, LocalDate.of(1997,1,31), Person.Sex.FEMALE,"g.rten@gmail.com");
        Person p5=new Person("Barbara",26, LocalDate.of(1996,4,2), Person.Sex.FEMALE,"b.rbra@onet.com");
        Person p6=new Person("Joanna",27, LocalDate.of(1995,3,6), Person.Sex.FEMALE,"jo.annda@gmail.com");
        Person p7=new Person("Paweł",23, LocalDate.of(1999,5,7), Person.Sex.MALE,"p.tomczyk@gmail.com");
        Person p8=new Person("Julia",25, LocalDate.of(1997,3,11), Person.Sex.FEMALE,"j.ulk@gmail.com");
        Person p9=new Person("Katarzyna",25, LocalDate.of(1997,6,15), Person.Sex.FEMALE,"kat.rzyna@gmail.com");
        Person p10=new Person("Ola",24, LocalDate.of(1998,7,23), Person.Sex.FEMALE,"ola.kot@gmail.com");

        List<Person> people=new ArrayList<>();
        people.add(p1);
        people.add(p2);
        people.add(p3);
        people.add(p4);
        people.add(p5);
        people.add(p6);
        people.add(p7);
        people.add(p8);
        people.add(p9);
        people.add(p10);

        printPersonWithPredicate(people,
                p->p.getSex()== Person.Sex.FEMALE && p.getAge()>20,
                Person::getBirthday,
                System.out::println);

        people.stream()
                .filter(p->p.getSex()== Person.Sex.FEMALE
                && p.getAge()>=22 && p.getAge()<26)
                .map(Person::getEmailAddress)
                .forEach(System.out::println);
        double average=people
                .stream()
                .filter(p->p.getSex()== Person.Sex.FEMALE)
                .mapToInt(Person::getAge)
                .average()
                .getAsDouble();

        System.out.println("\n"+average);

        List<String> femalesAddresses=people.stream()
                .filter(p->p.getSex()== Person.Sex.FEMALE)
                .map(Person::getEmailAddress)
                .collect(Collectors.toList());
        femalesAddresses.forEach(System.out::println);


    }
/*
    public static void printPersonWithPredicate(
            List<Person> roster, Predicate<Person> tester,
            Consumer<Person> block
    ){
        for(Person p: roster){
            if(tester.test(p)){
                block.accept(p);
            }
        }
    }*/

    public static void printPersonWithPredicate(
            List<Person> roster, Predicate<Person> tester,
            Function<Person,LocalDate> mapper,Consumer<LocalDate> block
    ){
        for(Person p: roster){
            if(tester.test(p)){
                LocalDate data=mapper.apply(p);
                block.accept(data);
            }
        }
    }


}
