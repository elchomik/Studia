package animals;

import animals.Animal;
import animals.Veterinarian;

import java.util.List;

public class Zoo {

    private String name;

    private List<Animal> animals;

    private List<Veterinarian> veterinarians;

    public Zoo(String name, List<Animal> animals, List<Veterinarian> veterinarians) {
        this.name = name;
        this.animals = animals;
        this.veterinarians = veterinarians;
    }

    public String getName() {
        return name;
    }

    public List<Animal> getAnimals() {
        return animals;
    }

    public List<Veterinarian> getVeterinarians() {
        return veterinarians;
    }
}
