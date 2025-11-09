public class ConcurrentCyclicQueue extends CyclicQueue {
    public ConcurrentCyclicQueue(int capacity) {
        super(capacity);
    }

    @Override
    public synchronized void enqueue(int element) {
        while (isFull()) {
            try {
                wait();
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
        }
        super.enqueue(element);
        notifyAll();
    }

    @Override
    public synchronized int dequeue() {
        while (isEmpty()) {
            try {
                wait();
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
        }
        int element = super.dequeue();
        notifyAll();
        return element;
    }
}