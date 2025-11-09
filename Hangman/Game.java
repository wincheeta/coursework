import java.io.Serializable;

interface Game extends Serializable {
    public static Level game = null;

    public Level difficulty();
    public boolean gameOver();
}
