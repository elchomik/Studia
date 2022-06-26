import java.time.LocalDate;

public class Person {

    public enum Sex{ MALE, FEMALE}

    private String name;
    private int age;
    private LocalDate birthday;

    private Sex gender;

    private String emailAddress;

    public Person(String name,int age, LocalDate birthday,Sex gender, String emailAddress) {
        this.name=name;
        this.age=age;
        this.birthday=birthday;
        this.gender=gender;
        this.emailAddress=emailAddress;
    }

    public int getAge(){
        return age;
    }
    public String getName(){
        return name;
    }

    public LocalDate getBirthday(){
        return birthday;
    }

    public Sex getSex(){
        return gender;
    }

    public String getEmailAddress(){
        return emailAddress;
    }

    public void printPerson(){
        System.out.println("Name: "+name+
                " age: "+age+ " sex: "+ gender +" birthday: "+ birthday
                +" emailAddress: "+ emailAddress);
    }
}
