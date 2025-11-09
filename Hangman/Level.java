import java.util.ArrayList;

public abstract class Level implements Comparable<Character> {
    int guesses;
    Word word;
    char[] correct;


    Level(int guesses) {
        this.guesses = guesses;
        this.word = null;
        this.correct = null;
    }

    public void set_word(Word word) {
        this.word = word;
        this.correct = new char[word.getLength()];
    }

    public int getGuesses() {
        return guesses;
    }
    public abstract String get_word();

    public ArrayList<Integer> checkLetter(char L) {
        L = Character.toLowerCase(L);
        ArrayList<Integer> pos = new ArrayList<>();
        for (int i = 0; i < word.getLength(); i++) {
            if (word.charAt(i) == L) {
                pos.add(i);
            }
        }
        return pos;
    }

    public void makeGuess(char L) {
        if (this.guesses > 0) {
            ArrayList<Integer> pos = this.checkLetter(L);
            if (pos.isEmpty()) {
                this.guesses--;
                System.out.println("Incorrect!");
            } else {
            for (Integer i : pos) {
                this.correct[i] = Character.toLowerCase(L);
                System.out.println("Correct!");
            }
            }
        }
        this.displayWord();
        if (this.gameOver() == -1) {
            System.out.println("Game Over - you lost.");
            System.out.println("the word was: " + this.word.getValue());
        } else if (this.gameOver() == 1) {
            System.out.println("Game Over - you won.");
            System.out.println("The word was: " + this.getCorrectString());
        }

    }

    public int gameOver() {
        if (this.guesses == 0) {
            return -1;
        } else if (this.getCorrectString().equals(this.word.getValue())){
            return 1;
        }
        else {
            return 0;
        }
    }

    public void displayWord() {
        for (char c : correct) {
            if (Character.isLetter(c)) {
                System.out.print(c);
            }
            else {
                System.out.print("_");
            }
        }
        System.out.println();
        System.out.println("you have "+ this.guesses + " guesses remaining");
        System.out.println();
    }

    public String getCorrectString() {
        StringBuilder out = new StringBuilder();
        for (char c : correct) {
            out.append(c);
        }
        return out.toString();
    }

    public int compareTo(char o) {
        return 0;
    }
}
