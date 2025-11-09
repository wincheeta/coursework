public class Leaf<T> implements Node<T> {
    public Leaf(T value) {
        this.value = value;
    }

    private T value;

    public T getValue() {
        return this.value;
    }
}
