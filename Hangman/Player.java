import java.util.HashSet;
import java.util.Scanner;

public class Player implements User {
    private String name;
    private HashSet<Character> guessed = new HashSet<Character>();

    @Override
    public char takeGuess() {
        Scanner sc;
        String guess = "";
        do {
            System.out.print("Please enter a letter: ");
            sc = new Scanner(System.in);
            guess = sc.next();
        }
        while (!this.isValid(guess));
        return guess.charAt(0);
    }

    @Override
    public void setName(String newName) {
        this.name = newName;
    }

    public boolean isValid(String in) {
        if (in.length() == 1 && Character.isAlphabetic(in.toCharArray()[0]) && !guessed.contains(Character.toLowerCase((in.toCharArray()[0])))) {
            guessed.add(Character.toLowerCase(in.toCharArray()[0]));
            return true;
        }
        if (in.length() != 1) {
            System.out.println("You can only guess one letter");}
        else if (!Character.isAlphabetic(in.toCharArray()[0])){
            System.out.println("You have to guess a letter");
        } else if (guessed.contains(in.toCharArray()[0])) {
            System.out.println("You've already guessed the letter");
        }
        return false;
    }
}
