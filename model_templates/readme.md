# Template list



## Generic templates

Incomplete model templates. Use as a base to implement custom models. Portions of the code that must be modified are marked with double square brackets, like so: `[[ ]]`.  The available templates are:

* [`generic_undir.stan`](generic_undir.stan): Generic template for measurement of undirected graph. 
* [`generic_dir.stan`](generic_dir.stan): Generic template for measurement of directed graph. 

See `stan` reference manual for details on how to use various [probability mass functions](https://mc-stan.org/docs/2_23/functions-reference/discrete-distributions.html#discrete-distributions) and [probability density functions](https://mc-stan.org/docs/2_23/functions-reference/continuous-distributions.html#continuous-distributions). 

## Examples


* [`poisson_data_ER_prior.stan`](poisson_data_ER_prior.stan): Takes a symmetric matrix of number of observations `X` as input. Models `X[i,j]` as drawn from a Poisson variable, with success rate determined by presence or absence of the edge `(i,j)`. Uses an Erdös-Rényi prior.
* [`bernoulli_data_ER_prior.stan`](bernoulli_data_ER_prior.stan): Takes as input a symmetric matrix of number of observations `X`, and a total number of observations `M`. Models `X[i,j]` as the outcome of `M` draws, with success rate determined by presence or absence of the edge `(i,j)`. Uses an Erdös-Rényi prior.
* [`poisson_data_SCM_prior.stan`](poisson_data_SCM_prior.stan): Same as Poisson data model above, but uses a soft configuration model as the network prior.
* [`bernoulli_data_SCM_prior.stan`](bernoulli_data_SCM_prior.stan): Same as Bernoulli data model above, but uses a soft configuration model as the network prior.



## Accelerated versions



* [`fast_poisson.stan`](fast_poisson.stan): Accelerated version of `poisson.stan`. Takes two vectors  `X` and `Y` as input . The entry `X[i]` of `X` gives the number of pairs of nodes that are measured as interacting `Y[i]` times. Return the matrix `Q` in vector format matching `X` and `Y`.
* [`fast_bernoulli.stan`](fast_bernoulli.stan): Accelerated version of `bernoulli.stan`. Takes as input two vectors  `X` and `Y`, and a total number of observations `M`. The entry `X[i]` of `X` gives the number of pairs of nodes that are measured as  interacting `Y[i]` times, out of `M` measurements. Return the matrix `Q` in vector format matching `X` and `Y`.

