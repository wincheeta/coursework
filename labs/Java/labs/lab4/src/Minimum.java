import java.util.Arrays;

public class Minimum < T extends Comparable <T > > implements TreeMin <T
        > {

    public T minimum(Node<T> node) {
        if (node == null) {
            throw new IllegalArgumentException("Node is null");
        }

        if (node instanceof Leaf) {
            return ((Leaf<T>) node).getValue();
        } else if (node instanceof Branch) {
            Branch<T> branch = (Branch<T>) node;
            T leftMin = minimum(branch.getLeft());
            T rightMin = minimum(branch.getRight());
            return leftMin.compareTo(rightMin) < 0 ? leftMin : rightMin;
        } else {
            throw new IllegalArgumentException("Unknown node type");
        }
    }


//    @Override
//    public T minimum ( T [] array ) {
//        if ( array == null || array.length == 0 ) {
//            throw new IllegalArgumentException( "array is null" );
//        }
//        if (array.length == 1) { return array[0]; }
//        else {
//            int len = array.length;
//            T a = array[0];
//            T b = minimum(Arrays.copyOfRange(array, 1, len));
//            if (a.compareTo(b) < 0) {
//                return a;
//            }
//            else {
//                return b;
//            }
//        }
//    }


}