import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Random;

// Incorrect: This always returns {0}

public class DAGSort {

	/**
	 * This method takes a directed acyclic graph as input and returns a
	 * topological sort of the nodes. Nodes are assumed to be laballed from 0 to
	 * (number of nodes) - 1.
	 *
	 * 
	 * @param edges
	 *            An array representing the edges of the graph. Each row
	 *            contains the immediate out-neighbours of a particular node.
	 *            E.g., edges[0] = {1,2,5} means there are edges from node 0 to
	 *            nodes 1, 2 and 5.
	 * @return A valid topological order of the nodes, i.e., every node must
	 *         appear before its out-neighbours in this order.
	 * @throws CycleDetectedException
	 *             If the input graph has cycles.
	 * @throws NullPointerException
	 *             If null is provided as a parameter.
	 * @throws InvalidNodeException
	 *             If the edges parameter contains edges that are not labelled
	 *             from 0 to (edges.length - 1)
	 */
	public static int[] sortDAG(int[][] edges) throws CycleDetectedException, InvalidNodeException {
		return new int[] {0};
	}

	

}

class CycleDetectedException extends Exception {
	public CycleDetectedException() {
		super();
	}
}

class InvalidNodeException extends Exception {
	public InvalidNodeException() {
		super();
	}

	public InvalidNodeException(String s) {
		super(s);
	}
}
