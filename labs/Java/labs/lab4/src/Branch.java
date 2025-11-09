public class Branch<T> implements Node<T> {
    public Branch(Node<T> left, Node<T> right) {
        this.left = left;
        this.right = right;
    }

    private Node<T> left;
    private Node<T> right;

    public Node<T> getLeft() {
        return this.left;
    }

    public Node<T> getRight() {
        return this.right;
    }
}
