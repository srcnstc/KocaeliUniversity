# Solution to Traveling Salesman Problem with Genetic Algorithm

# version 1.0.0
A pharmaceutical representative will visit each province in Turkey once and return with what he started. The shortest path sequence is required to be found by genetic algorithm. In this context, the selection method for the approach to be used in the creation of the genetic algorithm structure, the sequential selection and the crossover method is Order Crossover. Change Registration: 01.01.2016

Designer | Subject  |
---| --- |
Sercan SATICI | Solution to Traveling Salesman Problem with Genetic Algorithm |


Method | Definition  |
---| --- |
Solution to Traveling Salesman Problem with Genetic Algorithm | 1-A set of solutions from all possible solutions in the search space is encoded as a sequence. Here, random processing is usually done. An initial population is created. (Three initial populations, P1, P2 and P3, were created), 2- The fitness value is calculated for each sequence. The fitness values ​​found show the solution quality of the sequences. (The total distances for each population have been calculated and the population with the least distance as the fitness value has been defined as the most suitable), 3- A group of sequences is randomly selected according to a certain probability value. Crossover and mutation operations are performed on the selected sequences. (The probability value was chosen as 1/3 of the length of the sequence, that is, approximately 0.333. The sequences on which the crossover will be made are the two most suitable populations with the least distance, and the Row-Based Crossover operation was performed), 4- The new population is replaced by the old population. (Two populations P1, P2 in which the cross was made with row-based crossover, the two individuals resulting from C1, C2 were written instead of the two populations with the lowest, that is, the highest distance), 5- The above operations are continued until the stopping criterion is met. (less than 55,000 km total distance is taken as a sufficient condition), 6- The most suitable sequence is chosen as the solution. |
Input |  "TravellingSalesman.m" "ilmesafe.xls" |
Output | Optimal route (Provinces are represented by license plate numbers) |
