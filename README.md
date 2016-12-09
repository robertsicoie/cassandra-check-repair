**Overview**
This is a simple script that scans a Cassandra cluster and checks if there are any ongoing repair jobs. If there are no repair jobs currently running, it takes a snapshot of the node and then it runs nodetool repair.

The purpose of this script is to help in manually running nodetool repairs.

If you want to schedule repairs you should use tools like cassandra-reaper.
 
**Usage**
Copy *check-repair* to one of the nodes in your cluster.

check-repair.sh <hostname> <username> <password>

Run this script for each node of your cluster. A new repair job will not be started if there already is a running repair job.

Before running repair, this script will create a snapshot of the target node.
