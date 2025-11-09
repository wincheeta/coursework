import java.io.PrintStream;
import java.io.FileNotFoundException;
import java.util.ArrayList;

public class Quiz {
    private FlashCardReader reader;
    private ArrayList<FlashCard> flashCards;
    private Toolbox toolbox;
    private boolean saveResults;

    public Quiz(String filename) {
        reader = new FlashCardReader(filename);
        flashCards = reader.getFlashCards();
        toolbox = new Toolbox();
    }

    public void play() {
        System.out.print("Would you like to save your results? (Y/N): ");
        String saveInput = toolbox.readStringFromCmd();
        saveResults = saveInput.equalsIgnoreCase("Y");

        ArrayList<String> results = new ArrayList<>();
        int correctAnswers = 0;

        for (FlashCard flashCard : flashCards) {
            System.out.println("Question: " + flashCard.getQuestion());
            System.out.print("Your answer: ");
            String userAnswer = toolbox.readStringFromCmd();
            boolean isCorrect = userAnswer.equalsIgnoreCase(flashCard.getAnswer());
            if (isCorrect) {
                System.out.println("Right!");
                correctAnswers++;
            } else {
                System.out.println("Wrong! The correct answer is: " + flashCard.getAnswer());
            }
            results.add(flashCard.getQuestion() + "," + userAnswer + "," + (isCorrect ? "right" : "wrong"));
        }

        if (saveResults) {
            save(results, correctAnswers, flashCards.size());
        }
    }

    private void save(ArrayList<String> results, int correctAnswers, int totalQuestions) {
        try (PrintStream out = new PrintStream("save.txt")) {
            for (String result : results) {
                out.println(result);
            }
            double percentage = (correctAnswers / (double) totalQuestions) * 100;
            out.println(correctAnswers + "," + totalQuestions + "," + String.format("%.1f", percentage));
        } catch (FileNotFoundException e) {
            System.err.println("Error saving results: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        Quiz quiz = new Quiz("flashcards.txt");
        quiz.play();
    }
}