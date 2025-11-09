class Counter {
    private int count = 0;

    public synchronized void addOne() {
        count++;
    }

    public synchronized int getCount() {
        return count;
    }
}