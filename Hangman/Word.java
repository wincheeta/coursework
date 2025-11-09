import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Scanner;

public abstract class Word extends ArrayList<String> {
    String value;

    Word(String value) {
        this.value = value;
    }
    public int getLength() {
        return this.value.length();
    }

    public char charAt(int index) {
        return this.value.charAt(index);
    }

    public String getValue() {
        return this.value;
    }

    public static HashMap<String, ArrayList<String>> read() {
        HashMap<String, ArrayList<String>> Dict = new HashMap<>();
        Dict.put("Easy", new ArrayList<String>());
        Dict.put("Medium", new ArrayList<String>());
        Dict.put("Hard", new ArrayList<String>());
        try {
            File myObj;
            myObj = new File("./WHA.txt");

            Scanner myReader = new Scanner(myObj);
                while (myReader.hasNextLine()) {
                    String[] data = myReader.nextLine().split(" ");
                    Dict.get(data[1]).add(data[0]);
                }
                myReader.close();
            } catch (FileNotFoundException e) {
                System.out.println("An error occurred.");
                e.printStackTrace();
            }
        return Dict;

    }
}
