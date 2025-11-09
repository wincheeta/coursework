import java.util.ArrayList;

class MedLevel extends Level {
    MedLevel() {
        super(8);
        this.set_word(new MedWord(this.get_word()));
    }

    public int compareTo(Character o) {
        return 0;
    }

    public String get_word() {
        ArrayList<String> med = Word.read().get("Medium");
        int index = (int)(Math.random() * med.size());
        return med.get(index);
    }
}