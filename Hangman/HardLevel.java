import java.util.ArrayList;

class HardLevel extends Level {
    HardLevel() {
        super(6);
        this.set_word(new HardWord(this.get_word()));
    }

    public int compareTo(Character o) {
        return 0;
    }

    public String get_word() {
        ArrayList<String> med = Word.read().get("Hard");
        int index = (int)(Math.random() * med.size());
        return med.get(index);
    }
}
