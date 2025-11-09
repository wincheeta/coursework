class Fizzbuz {
    public static void main(String[] args) {
        final long startTime = System.currentTimeMillis();
        for (int i = 1; i <= 999; i++) {
            String out = "";
            if (i % 3 == 0 && i % 5 == 0) {
                out = "fizzbuzz";
            }
            else if (i % 3 == 0) {
                out = "fizz";
            }
            else if (i % 5 == 0) {
                out = "buzz";
            }
            if  (out.equals("")) {
                System.out.println(i);
            } else {
                System.out.println(out);
            }
        }
        final long endTime = System.currentTimeMillis();

        System.out.println("Total execution time: " + (endTime - startTime));
    }
}
