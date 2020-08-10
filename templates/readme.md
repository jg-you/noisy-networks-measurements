Model templates, that can be used to implement custom models withouth writing boilerplate code.
Portions of the code that must be modified are marked with double square brackets, like so: `[[ ]]`.
The available templates are:

* [`undir.stan`](generic_undir.stan): Generic template for measurement of undirected graph.
* [`dir.stan`](generic_dir.stan): Generic template for measurement of directed graph. 
* [`undir_multitype.stan`](generic_undir_multitype.stan): Generic template for measurement of undirected graph with many edge types. 

See `stan` reference manual for details on how to use various [probability mass functions](https://mc-stan.org/docs/2_23/functions-reference/discrete-distributions.html#discrete-distributions) and [probability density functions](https://mc-stan.org/docs/2_23/functions-reference/continuous-distributions.html#continuous-distributions). 
