import org.junit.Test;
import static org.junit.Assert.*;

    public class DAGSortTest {

        @Test
        public void testValidDAG() throws CycleDetectedException, InvalidNodeException {
            int[][] edges = {
                    {1, 2},
                    {3},
                    {3},
                    {}
            };
            int[] result = DAGSort.sortDAG(edges);
            assertTrue(isValidTopologicalSort(result, edges));
        }

        private boolean isValidTopologicalSort(int[] order, int[][] edges) {
            int[] position = new int[order.length];
            for (int i = 0; i < order.length; i++) {
                position[order[i]] = i;
            }
            for (int u = 0; u < edges.length; u++) {
                for (int v : edges[u]) {
                    if (position[u] > position[v]) {
                        return false;
                    }
                }
            }
            return true;
        }

        @Test
        public void testSingleNode() throws CycleDetectedException, InvalidNodeException {
            int[][] edges = {{}};
            int[] expected = {0};
            assertArrayEquals(expected, DAGSort.sortDAG(edges));
        }

        @Test
        public void testEmptyGraph() throws CycleDetectedException, InvalidNodeException {
            int[][] edges = {};
            int[] expected = {};
            assertArrayEquals(expected, DAGSort.sortDAG(edges));
        }

        @Test(expected = NullPointerException.class)
        public void testNullInput() throws CycleDetectedException, InvalidNodeException {
            DAGSort.sortDAG(null);
        }

        @Test(expected = InvalidNodeException.class)
        public void testInvalidNode() throws CycleDetectedException, InvalidNodeException {
            int[][] edges = {
                    {1, 2},
                    {3},
                    {4}, // Invalid node 4
                    {}
            };
            DAGSort.sortDAG(edges);
        }

        @Test(expected = CycleDetectedException.class)
        public void testCycleDetection() throws CycleDetectedException, InvalidNodeException {
            int[][] edges = {
                    {1},
                    {2},
                    {0} // Cycle here
            };
            DAGSort.sortDAG(edges);
        }
    }

