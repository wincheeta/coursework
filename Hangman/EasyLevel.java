import java.util.ArrayList;

public class EasyLevel extends Level {
    EasyLevel() {
        super(10);
        this.set_word(new EasyWord(this.get_word()));
    }

    public int compareTo(Character o) {
        return 0;
    }
    public String get_word() {
        ArrayList<String> med = Word.read().get("Easy");
        int index = (int)(Math.random() * med.size());
        return med.get(index);
    }
}