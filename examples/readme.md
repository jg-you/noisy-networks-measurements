# Template list

## Models obtained by modifying the [`undir.stan`](../templates/undir.stan) template

* [`poisson_data_ER_prior.stan`](poisson_data_ER_prior.stan): Takes a symmetric matrix of number of observations `X` as input. Models `X[i,j]` as drawn from a Poisson variable, with success rate determined by presence or absence of the edge `(i,j)`. Uses an Erdös-Rényi prior. 
* [`bernoulli_data_ER_prior.stan`](bernoulli_data_ER_prior.stan): Takes as input a symmetric matrix of number of observations `X`, and a total number of observations `M`. Models `X[i,j]` as the outcome of `M` draws, with success rate determined by presence or absence of the edge `(i,j)`. Uses an Erdös-Rényi prior.
* [`poisson_data_SCM_prior.stan`](poisson_data_SCM_prior.stan): Same as Poisson data model above, but uses a soft configuration model as the network prior.
* [`bernoulli_data_SCM_prior.stan`](bernoulli_data_SCM_prior.stan): Same as Bernoulli data model above, but uses a soft configuration model as the network prior.


## Models obtained by modifying the [`undir_multitype.stan`](../templates/undir_multitype.stan) template

* [`multitype_poisson_data_ER_prior.stan`](multitype_poisson_data_ER_prior.stan): Takes a symmetric matrix of number of observations `X` as input. Models `X[i,j]` as drawn from a Poisson variable, with success rate determined by presence or absence of the edge `(i,j)`. **Uses multiple edge types**.  Uses a generalized Erdös-Rényi prior.



## Accelerated versions (no templates)

* [`fast_poisson.stan`](fast_poisson.stan): Accelerated version of `poisson.stan`. Takes two vectors  `X` and `Y` as input . The entry `X[i]` of `X` gives the number of pairs of nodes that are measured as interacting `Y[i]` times. Return the matrix `Q` in vector format matching `X` and `Y`.
* [`fast_bernoulli.stan`](fast_bernoulli.stan): Accelerated version of `bernoulli.stan`. Takes as input two vectors  `X` and `Y`, and a total number of observations `M`. The entry `X[i]` of `X` gives the number of pairs of nodes that are measured as  interacting `Y[i]` times, out of `M` measurements. Return the matrix `Q` in vector format matching `X` and `Y`.

