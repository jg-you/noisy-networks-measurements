data {
  int<lower=1> n;
  int<lower=0> X[n, n];
  real<lower=0> rates_std_prior[2];
  real<lower=0> rho_prior[2];
}
parameters {
  positive_ordered[2] rates;
  real<lower=0, upper=1> rho;
  simplex[n] lambda;
  real<lower = 0> scale;
}
model {
  rates[1] ~ normal(1, rates_std_prior[1]);
  rates[2] ~ normal(1, rates_std_prior[2]);
  rho ~­ beta(rho_prior[1], rho_prior[2]);
  scale ~ exponential(100);

  for (i in 1:n) {
    for (j in i + 1:n) {
      real log_mu_ij_0 = poisson_lpmf(X[i, j] | rates[1]);
      real log_mu_ij_1 = poisson_lpmf(X[i, j] | rates[2]);

      real r = inv_logit(scale * lambda[i] * lambda[j]);
      real log_nu_ij_0 = bernoulli_lpmf(0 | r);
      real log_nu_ij_1 = bernoulli_lpmf(1 | r);

      real z_ij_0 = log_mu_ij_0 + log_nu_ij_0;
      real z_ij_1 = log_mu_ij_1 + log_nu_ij_1;
      if (z_ij_0 > z_ij_1) {target += z_ij_0 + log1p_exp(z_ij_1 - z_ij_0);}
      else {target += z_ij_1 + log1p_exp(z_ij_0 - z_ij_1);}
    }
  }
}
generated quantities {
  real Q[n ,n];
  for (i in 1:n) {
    Q[i, i] = 0;
    for (j in i+1:n) {
      real log_mu_ij_0 = poisson_lpmf(X[i, j] | rates[1]);
      real log_mu_ij_1 = poisson_lpmf(X[i, j] | rates[2]);

      real r = inv_logit(scale * lambda[i] * lambda[j]);
      real log_nu_ij_0 = bernoulli_lpmf(0 | r);
      real log_nu_ij_1 = bernoulli_lpmf(1 | r);

      real z_ij_0 = log_mu_ij_0 + log_nu_ij_0;
      real z_ij_1 = log_mu_ij_1 + log_nu_ij_1;
      Q[i, j] = 1 / (1  + exp(z_ij_0 - z_ij_1));
      Q[j, i] = Q[i, j];
    }
  }
}
