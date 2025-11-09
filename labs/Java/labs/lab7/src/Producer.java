import java.util.Random;

public class Producer extends QueueWorker{
    /**
     * Initalises a new QueueWorker for the given {@link NumberQueue}
     *
     * @param queue
     */
    public Producer(NumberQueue queue) {
        super(queue);
    }

    @Override
    protected int action() {
        int in = new Random().nextInt(10)+1;
        this.queue.enqueue(in);
        return in;
    }
}
