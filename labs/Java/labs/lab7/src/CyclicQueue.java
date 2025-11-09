public class CyclicQueue implements NumberQueue
{
    protected int head = 0;
    protected int tail = 0;
    protected int[] buffer;

    public CyclicQueue(int size)
    {
        buffer = new int[size + 1];
    }

    @Override
    public void enqueue(int v)
    {
        if (isFull())
            throw new IllegalStateException("Cannot enqueue to a full queue");

        buffer[head] = v;
        head = (head + 1) % buffer.length;
    }

    @Override
    public int dequeue()
    {
        if (isEmpty())
            throw new IllegalStateException("Cannot dequeue from a full queue");

        var res = buffer[tail];
        tail = (tail + 1) % buffer.length;
        return res;
    }

    @Override
    public boolean isFull()
    {
        return (head + 1) % buffer.length == tail;
    }

    @Override
    public boolean isEmpty()
    {
        return (head == tail);
    }
}