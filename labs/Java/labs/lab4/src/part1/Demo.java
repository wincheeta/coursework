import java.util.ArrayList;
import java.util.Collections;

public class Demo {
    public static void main(String[] args) {
        ArrayList<Animal> array = null;
        array.add(new Wolf());
        array.add(new Wolf("Jong",123));
        array.add(new Wolf("WILFRED",456));
        array.add(new Parrot("bong",7));
        array.add(new Parrot(14));
        
        Collections.sort(array);
    }
}
