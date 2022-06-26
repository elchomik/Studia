package animals;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class Main {
    public static void main(String[] args) {
        Animal elephant = new Animal("Rose", 2, Animal.Gender.MALE);
        Animal giraffe = new Animal("Hania", 5, Animal.Gender.FEMALE);
        Animal lion = new Animal("Zbyszek", 10, Animal.Gender.MALE);
        Animal tiger = new Animal("Mietek", 6, Animal.Gender.MALE);
        Animal monkey = new Animal("Monika", 4, Animal.Gender.FEMALE);
        Animal penguin = new Animal("Klara", 7, Animal.Gender.FEMALE);
        Animal rhinoceros = new Animal("Stefan", 1, Animal.Gender.MALE);
        Animal hippopotamus = new Animal("Anna", 9, Animal.Gender.FEMALE);
        Animal leopard = new Animal("Sara", 4, Animal.Gender.FEMALE);
        Animal antelope = new Animal("Maria", 12, Animal.Gender.FEMALE);

        List<Animal> animals = new ArrayList<>();

        animals.add(elephant);
        animals.add(giraffe);
        animals.add(leopard);
        animals.add(lion);
        animals.add(tiger);
        animals.add(monkey);
        animals.add(penguin);
        animals.add(rhinoceros);
        animals.add(hippopotamus);
        animals.add(antelope);

        Veterinarian veterinarian1 = new Veterinarian("Jan", 45);
        Veterinarian veterinarian2 = new Veterinarian("Pawel", 33);
        Veterinarian veterinarian3 = new Veterinarian("Olgierd", 34);
        Veterinarian veterinarian4 = new Veterinarian("Przemek", 23);

        List<Veterinarian> veterinarians = new ArrayList<>();
        veterinarians.add(veterinarian1);
        veterinarians.add(veterinarian2);
        veterinarians.add(veterinarian3);
        veterinarians.add(veterinarian4);

        Zoo zoo1 = new Zoo("Zwariowane melodie", animals, veterinarians);
        Zoo zoo2 = new Zoo("Wesołe przygody", animals, veterinarians);
        Zoo zoo3 = new Zoo("Andrzej to jebnie", animals, veterinarians);

        List<Zoo> zoos = new ArrayList<>();
        zoos.add(zoo1);
        zoos.add(zoo2);
        zoos.add(zoo3);

        List<String> names = zoos.stream()
                .filter(z -> z.getName() == "Wesołe przygody")
                .collect(Collectors.toList())
                .stream()
                .flatMap(zoo -> zoo.getAnimals().stream().filter(
                        animal -> animal.getAge() > 4 && animal.getGender() == Animal.Gender.FEMALE
                ))
                .map(Animal::getName)
                .collect(Collectors.toList());
        names.forEach(System.out::println);

        System.out.println("\n----\n");

        List<String> names2 = zoos.stream()
                .flatMap(z -> z.getAnimals()
                        .stream()
                        .filter(a -> a.getAge() > 4
                                && a.getGender() == Animal.Gender.FEMALE)
                )
                .map(Animal::getName)
                .collect(Collectors.toList());
        names2.forEach(System.out::println);

        List<String> vetsName = zoos.stream()
                .filter(z -> z.getName() == "Andrzej to jebnie")
                .collect(Collectors.toList())
                .stream()
                .flatMap(zoo -> zoo.getVeterinarians().stream().filter(
                        v -> v.getAge() > 30
                ))
                .map(Veterinarian::getName)
                .collect(Collectors.toList());

        System.out.println("Veterinarians names: ");
        vetsName.forEach(System.out::println);


    }
}
