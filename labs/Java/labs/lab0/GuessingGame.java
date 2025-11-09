

public class GuessingGame {
    public static void main(String[] args) {
        Integer numberToGuess, guessedNumber;
        Toolbox myToolbox = new Toolbox();
        System.out.print("Enter your guess: ");
        numberToGuess = myToolbox.getRandomInteger(10) ;
        guessedNumber = 100;
        while (!numberToGuess.equals(guessedNumber)){
            guessedNumber = myToolbox.readIntegerFromCmd();
            if (guessedNumber > numberToGuess) {
                System.out.print("too high\n");
            }else if (guessedNumber < numberToGuess) {
                System.out.print("too low\n");
            }
        }
        System.out.print("right\n");
        System.out.println("The correct number is " + numberToGuess);
    }
}
