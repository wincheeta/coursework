import java.util.Scanner;
import java.util.concurrent.TimeUnit;

public class Hangman implements Game {
    private static Level game;

    public static void main(String[] args) throws InterruptedException {
        do {
            Player me = new Player();
            game = new Hangman().difficulty();
            try {
            game.displayWord();
            while (game.gameOver()==0) {
                game.makeGuess(me.takeGuess());
            }}
            catch(Exception e) {
                continue;
            }
            TimeUnit.SECONDS.sleep(2);
        }
        while (game != null);
        System.out.println("     __________\n" +
                "    |/         \\\n" +
                "    |          |\n" +
                "    |          0\n" +
                "    |         -|-\n" +
                "    |         / \\\n" +
                "    |\\____________");
    }

    @Override
    public Level difficulty() {
        Scanner sc = new Scanner(System.in);
        while(true) {
            System.out.print("--------------\n" +
                    "| 1 | easy   |\n" +
                    "| 2 | medium |\n" +
                    "| 3 | hard   |\n" +
                    "| 4 | exit   |\n" +
                    "--------------\n");
            System.out.print("Enter difficulty: ");
            String difficulty = sc.nextLine();
            switch (difficulty.toLowerCase()) {
                case "1" -> {
                    System.out.println("Easy selected");
                    return new EasyLevel();
                }
                case "easy" -> {
                    System.out.println("Easy selected");
                    return new EasyLevel();
                }
                case "2" -> {
                    System.out.println("Medium selected");
                    return new MedLevel();
                }
                case "medium" -> {
                    System.out.println("Medium selected");
                    return new MedLevel();
                }
                case "3" -> {
                    System.out.println("Hard selected");
                    return new HardLevel();
                }
                case "hard" -> {
                    System.out.println("Hard selected");
                    return new HardLevel();
                }
                case "4" -> {
                    System.out.println("Exit selected");
                    return null;
                }
                case "exit" -> {
                    System.out.println("Exit selected");
                    return null;
                }
            }
        }
    }

    @Override
    public boolean gameOver() {
        return game.gameOver()!=0;
    }


}