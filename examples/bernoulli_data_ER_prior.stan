data {
  int<lower=1> n;
  array[n, n] int<lower=0> X;
  int M;
  array[2] real<lower=0> rates_prior;
  array[2] real<lower=0> rho_prior;
}
parameters {
  positive_ordered[2] rates;
  real<lower=0, upper=1> rho;
}
model {
  rates ~ beta(rates_prior[1], rates_prior[2]);
  rho ~ beta(rho_prior[1], rho_prior[2]);

  for (i in 1:n) {
    for (j in i + 1:n) {
      real log_mu_ij_0 = binomial_lpmf(X[i, j] | M, rates[1]);
      real log_mu_ij_1 = binomial_lpmf(X[i, j] | M, rates[2]);

      real log_nu_ij_0 = bernoulli_lpmf(0 | rho);
      real log_nu_ij_1 = bernoulli_lpmf(1 | rho);

      real z_ij_0 = log_mu_ij_0 + log_nu_ij_0;
      real z_ij_1 = log_mu_ij_1 + log_nu_ij_1;
      if (z_ij_0 > z_ij_1) {target += z_ij_0 + log1p_exp(z_ij_1 - z_ij_0);}
      else {target += z_ij_1 + log1p_exp(z_ij_0 - z_ij_1);}
    }
  }
}
generated quantities {
  array[n, n] real Q;
  for (i in 1:n) {
    Q[i, i] = 0;
    for (j in i+1:n) {
      real log_mu_ij_0 = binomial_lpmf(X[i, j] | M, rates[1]);
      real log_mu_ij_1 = binomial_lpmf(X[i, j] | M, rates[2]);

      real log_nu_ij_0 = bernoulli_lpmf(0 | rho);
      real log_nu_ij_1 = bernoulli_lpmf(1 | rho);

      real z_ij_0 = log_mu_ij_0 + log_nu_ij_0;
      real z_ij_1 = log_mu_ij_1 + log_nu_ij_1;
      Q[i, j] = 1 / (1 + exp(z_ij_0 - z_ij_1));
      Q[j, i] = Q[i, j];
    }
  }
}
