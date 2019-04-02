# AssigmentProblem
The assignment problem is a fundamental combinatorial optimization problem. It consists of finding, in a weighted bipartite graph, a matching in which the sum of weights of the edges is as large as possible. A common variant consists of finding a minimum-weight perfect matching.

In its most general form, the problem is as follows:

The problem instance has a number of agents and a number of tasks. Any agent can be assigned to perform any task, incurring some cost that may vary depending on the agent-task assignment. It is required to perform all tasks by assigning exactly one agent to each task and exactly one task to each agent in such a way that the total cost of the assignment is minimized.

This module implement two methods, solve_with_brute_force and solve_with_linear_programming that, given a number matrix with the weight of the task-agent assigment it returns all the combinations with the minimum sum.
