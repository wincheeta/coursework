public class Zoo {
    public static void main(String[] args) {
        Counter counter = new Counter();
        int expectedGuests = 0;

        // Create gates with varying number of guests
        Gate[] gates = {
                new Gate(counter, 100),
                new Gate(counter, 200),
                new Gate(counter, 150),
                new Gate(counter, 250),
                new Gate(counter, 100),
                new Gate(counter, 200),
                new Gate(counter, 150),
                new Gate(counter, 250),
                new Gate(counter, 100),
                new Gate(counter, 200),
                new Gate(counter, 150),
                new Gate(counter, 250)
        };


        // Run gates concurrently
        Thread[] threads = new Thread[gates.length];
        for (int i = 0; i < gates.length; i++) {
            threads[i] = new Thread(gates[i]);
            threads[i].start();
        }

        // Wait for all threads to finish
        for (Thread thread : threads) {
            try {
                thread.join();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }

        // Print results
        System.out.println("Expected guests: " + 700*3);
        System.out.println("Actual count: " + counter.getCount());
    }
}