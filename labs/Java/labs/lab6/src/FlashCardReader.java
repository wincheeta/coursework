import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

public class FlashCardReader {
    private BufferedReader reader;

    public FlashCardReader(String filename) {
        try {
            reader = new BufferedReader(new FileReader(filename));
        } catch (IOException e) {
            System.err.println("Error opening file: " + e.getMessage());
            reader = null;
        }
    }

    public String getLine() {
        try {
            if (reader != null) {
                return reader.readLine();
            } else {
                System.err.println("Reader is not initialized.");
                return null;
            }
        } catch (IOException e) {
            System.err.println("Error reading line: " + e.getMessage());
            return null;
        }
    }

    public boolean fileIsReady() {
        try {
            if (reader != null) {
                return reader.ready();
            } else {
                System.err.println("Reader is not initialized.");
                return false;
            }
        } catch (IOException e) {
            System.err.println("Error checking file readiness: " + e.getMessage());
            return false;
        }
    }

    public ArrayList<FlashCard> getFlashCards() {
        ArrayList<FlashCard> flashCards = new ArrayList<>();
        String line;
        try {
            while ((line = getLine()) != null) {
                String[] parts = line.split(":");
                if (parts.length == 2) {
                    flashCards.add(new FlashCard(parts[0], parts[1]));
                }
            }
        } catch (Exception e) {
            System.err.println("Error reading flash cards: " + e.getMessage());
        }
        return flashCards;
    }
}