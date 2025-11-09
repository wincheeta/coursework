import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;

public class Main {
    public Main() throws FileNotFoundException {
    }

    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
    BufferedReader reader = new BufferedReader(new FileReader("./Questions.txt"));
}