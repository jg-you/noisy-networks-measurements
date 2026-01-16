data {
  int<lower=1> n;
  array[n, n] int<lower=0> X;
  int T; // number of edge types
  // [[Additional data go here]]
}
parameters {
  // [[Parameters go here]]
  //
  // For example:
  // real<lower=0,upper=1> theta;
}
model {
  // [[Priors go here]]
  //
  // For example:
  // theta ~ beta(1, 1/2);

  for (i in 1:n) {
    for (j in i + 1:n) {
      vector[T] z_ij;
      vector[T] z_max_vector;
      real z_max;
      for (k in 1:T) {
        // [[Data model goes here]]
        real log_mu_ij_k = ;
        // [[Network model goes here]]
        real log_nu_ij_k = ;

        // Boilerplate code below, do not modify
        z_ij[k] = log_mu_ij_k + log_nu_ij_k;
      }
      z_max = max(z_ij);
      z_max_vector = rep_vector(z_max, T);
      target += z_max + log_sum_exp(z_ij - z_max_vector);
    }
  }
}
generated quantities {
  // Generate edge probability matrix
  array[n, n, T] real Q;
  for (i in 1:n) {
    for (k in 1:T) {
      Q[i, i, k] = 0;
    }
    for (j in i+1:n) {
      vector[T] z_ij;
      real accu;
      for (k in 1:T)
      {
        // [[Data model goes here]]
        real log_mu_ij_k = ;
        // [[Network model goes here]]
        real log_nu_ij_k = ;

        // Boilerplate code below, do not modify
        z_ij[k] = log_mu_ij_k + log_nu_ij_k;
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
