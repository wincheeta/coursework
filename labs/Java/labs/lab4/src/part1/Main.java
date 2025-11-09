import java.util.ArrayList;
import java.util.Collections;

public class Main {
    public static void main(String[] args) {
        Wolf wolf = new Wolf("john",12 );
        Parrot parrot = new Parrot(1);

        wolf.makeNoise();
        parrot.makeNoise();

        wolf.eat(new Meat("Carrot"), 1);

        ArrayList<Animal> array = new ArrayList<>();
        array.add(new Wolf());
        array.add(new Wolf("Jong",123));
        array.add(new Wolf("WILFRED",456));
        array.add(new Parrot("bong",7));
        array.add(new Parrot(14));

        for (Animal animal : array) {
            System.out.println(animal.getName());
        }
        Collections.sort(array);
        for (Animal animal : array) {
            System.out.println(animal.getName());
        }
    }
}
