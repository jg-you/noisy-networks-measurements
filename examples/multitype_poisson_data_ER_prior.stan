data {
  int<lower=1> n;
  int<lower=0> X[n, n];
  int T; // number of edge types
  real<lower=0> rates_std_prior[T];
}
parameters {
  positive_ordered[T] rates;
  simplex[T] rho;
}
model {
  for (k in 1:T)
  {
    rates[k] ~ normal(1, rates_std_prior[k]);
  }

  for (i in 1:n) {
    for (j in i + 1:n) {
      vector[T] z_ij;
      vector[T] z_max_vector;
      real z_max;
      for (k in 1:T) {
        real log_mu_ij_k = poisson_lpmf(X[i, j] | rates[k]);
        real log_nu_ij_k = log(rho[k]);
  
        z_ij[k] = log_mu_ij_k + log_nu_ij_k;
      }
      z_max = max(z_ij);
      z_max_vector = rep_vector(z_max, T);
      target += z_max + log_sum_exp(z_ij - z_max_vector);
    }
  }
}
generated quantities {
  real Q[n ,n, T];
  for (i in 1:n) {
    for (k in 1:T) {
      Q[i, i, k] = 0;
    }
    for (j in i+1:n) {
      vector[T] z_ij;
      real accu;
      for (k in 1:T)
      {
        real log_mu_ij_k = poisson_lpmf(X[i, j] | rates[k]);
        real log_nu_ij_k = log(rho[k]);

        z_ij[k] =  log_mu_ij_k + log_nu_ij_k;
      }
      for (k in 1:T)
      {
        accu = 0;
        for (k_prime in 1:T)
        {
          accu += exp(z_ij[k_prime] - z_ij[k]);
        }
        Q[i, j, k] = 1 / accu;
        Q[j, i, k] = Q[i, j, k];
      }
    }
  }
}
