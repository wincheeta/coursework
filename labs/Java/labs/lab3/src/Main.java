public class Main {
    public static void main(String[] args) {
        WordGroup one = new WordGroup("You can discover more about a person in an hour of play than in a year of conversation and the other with");
        WordGroup two = new WordGroup("When you play play hard when you work dont play at all");

        String[] ONE = one.getWordArray();
        String[] TWO = two.getWordArray();

        for (String s : ONE) {
            System.out.println(s);
        }
        for (String s : TWO) {
            System.out.println(s);
        }

        for (String s : one.getWordCounts().keySet()) {
            System.out.println(s + ": " + one.getWordCounts().get(s));
        }
        for (String s : two.getWordCounts().keySet()) {
            System.out.println(s + ": " + two.getWordCounts().get(s));
        }

    }
}
