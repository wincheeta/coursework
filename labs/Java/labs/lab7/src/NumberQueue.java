/**
 * Represents a First-In First-Out queue of integers with a maximum capacity.
 */
public interface NumberQueue {
    /**
     * Removes and returns the least-recently enqueued element from the queue.
     * @return The dequeued element.
     * @throws IllegalStateException If the queue is empty
     */
    int dequeue();

    /**
     * Enqueue an integer to the queue
     * @param n The element to be enqueue.
     * @throws IllegalStateException If the queue is full
     */
    void enqueue(int n);

    /**
     * Determines whether the queue is empty
     * @return <code>true</code> if the queue is empty, otherwise <code>false</code>
     */
    boolean isEmpty();

    /**
     * Determines whether the queue is full
     * @return <code>true</code> if the queue is full, otherwise <code>false</code>
     */
    boolean isFull();
}