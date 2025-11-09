// NOTE: you do not need to understand the details of this class
// It is written in a slightly odd way so that we can test the behaviour of the cyclic queue
// Nonetheless, the tests still make some assumptions about it that are _not correct_

/**
 * Represents a runnable task that performs some work on a {@link NumberQueue}
 */
public abstract class QueueWorker implements Runnable {
    /**
     * The {@link NumberQueue} to be used
     */
    protected final NumberQueue queue;

    /**
     * A flag indicating whether the queue worker should stop working
     */
    private volatile boolean shouldStop = false;

    /**
     * The the sum of values observed by the {@link QueueWorker}
     */
    private volatile int totalOfWork = 0;

    /**
     * A flag indicating whether the queue worker should stop working
     */
    private volatile boolean errored = false;

    /**
     * Synchronisation object
     */
    private Object lock = new Object();

    /**
     * Initalises a new QueueWorker for the given {@link NumberQueue}
     * @param queue
     */
    public QueueWorker(NumberQueue queue) {
        this.queue = queue;
    }

    /**
     * Sets the flag that indicates whether the {@link QueueWorker} should stop working
     */
    public void setShouldStop() {
        this.shouldStop = true;
    }

    /**
     * Gets the total amount of work performed by the {@link QueueWorker}
     */
    public int getTotalOfWork() {
        synchronized (lock) {
            return this.totalOfWork;
        }
    }

    /**
     * Gets a flag indicating whether the worker errored.
     */
    public boolean getErrored() {
        return this.errored;
    }

    /**
     * Performs some work, returning the value worked by the {@link QueueWorker}
     */
    protected abstract int action();

    /**
     * Runs the {@link QueueWorker}, stopping if the 'should stop' flag is set or an exception is throw by the worker.
     */
    @Override
    public void run() {
        try {
            while (!this.shouldStop && !errored) {
                runOnce();
            }
        } catch (Exception e) {
            errored = true;
            return;
        }
    }

    /**
     * Runs the {@link QueueWorker} exactly once, regardless whether the `should stop flag is set.
     */
    public void runOnce() {
        int work = action();
        synchronized (lock) {
            totalOfWork += work;
        }
    }
}