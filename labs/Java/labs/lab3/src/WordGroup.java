import java.util.HashMap;
import java.util.HashSet;

public class WordGroup {
    private String words;

    public WordGroup(String words) {
        this.words = words.toLowerCase();

    }

    public String[] getWordArray() {
        return words.split(" ");
    }

    public HashSet<String> getWordSet(WordGroup a) {
        HashSet<String> hash = new HashSet<String>();
        for (String word : a.getWordArray()) {
            hash.add(word);
        }
        for (String word : this.getWordArray()) {
            hash.add(word);
        }
        return hash;
    }

    public HashMap<String, Integer> getWordCounts() {
        HashMap<String,Integer> hash = new HashMap<String,Integer>();
        for (String word : this.getWordArray()) {
            Integer count = hash.get(word);
            if (count == null) {
                hash.put(word, 1);
            }
            else {
                hash.put(word, ++count);
            }
        }
        return hash;

    }


}
