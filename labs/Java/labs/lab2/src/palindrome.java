class Palindrome {
    public static void main(String[] args) {
        boolean a = palindrome2("tattarattat");
        System.out.println(a);
    }

    public static String palindrome(String s) {
        if (s.length() == 1) {
            return s;
        } else {
            return s.substring(s.length()-1, s.length()) + palindrome(s.substring(0, s.length()-1));
        }
    }

    public static boolean palindrome2(@org.jetbrains.annotations.NotNull String s) {
        return s.equals(palindrome(s));
    }
}
