public class Steps {

    public static void main(String[] args) {
        System.out.println(step(100));
    }

    public static int step(int n) {
        if (n==1) return 1;
        if (n==2) return 2;
        return step(n-1) + step(n-2);
    }
}
