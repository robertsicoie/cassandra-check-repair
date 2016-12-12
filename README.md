Cassandra Check Repair
======================

Overview
--------
This is a simple script that:

1. Finds a list of cluster nodes from node "localhost".
2. On EACH of those: 
   * Scans every node in the cluster and checks if there are any ongoing repair jobs.
   * If there are no repair jobs currently running, it takes a snapshot of the node and then it runs nodetool repair -pr.

The purpose of this script is to help in manually running nodetool repairs.

If you want to schedule repairs you should use tools like cassandra-reaper, but that solution is a magnitude more complex.
 
Usage
-----
Copy *check-repair* to one of the nodes in your cluster.

~~~~
check-repair.sh
~~~~

Before running repair, this script will create a snapshot of the target node.
