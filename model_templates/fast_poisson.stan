data {
  int n;    // number of non-empty pairs class
  int X[n]; // number of pairs of nodes in each classes
  int Y[n]; // number of observations for each class
  // Prios
  real<lower=0> rates_std_prior[2];
  real<lower=0> rho_prior[2];
}
parameters {
  positive_ordered[2] rates;
  real<lower=0, upper=1> rho;
}
model {
  rates[1] ~ normal(1, rates_std_prior[1]);
  rates[2] ~ normal(1, rates_std_prior[2]);
  rho ~­ beta(rho_prior[1], rho_prior[2]);

  for (i in 1:n)
  {

    real log_mu_i_0 = poisson_lpmf(Y[i] | rates[1]);
    real log_mu_i_1 = poisson_lpmf(Y[i] | rates[2]);
    real log_nu_i_0 = bernoulli_lpmf(0 | rho);
    real log_nu_i_1 = bernoulli_lpmf(1 | rho);

    real z = 0;
    real z_i_0 = log_mu_i_0 + log_nu_i_0;
    real z_i_1 = log_mu_i_1 + log_nu_i_1;
    if (z_i_0 > z_i_1) {z += z_i_0 + log1p_exp(z_i_1 - z_i_0);}
    else {z += z_i_1 + log1p_exp(z_i_0 - z_i_1);}
    target += X[i] * z;
  }
}
generated quantities {
  real Q[K];
  for (i in 1:n) {
    real log_mu_i_0 = poisson_lpmf(Y[i] | rates[1]);
    real log_mu_i_1 = poisson_lpmf(Y[i] | rates[2]);
    real log_nu_i_0 = bernoulli_lpmf(0 | rho);
    real log_nu_i_1 = bernoulli_lpmf(1 | rho);
    real z_i_0 = log_mu_i_0 + log_nu_i_0;
    real z_i_1 = log_mu_i_1 + log_nu_i_1;
    Q[i] = 1 / (1 + exp(z_i_1 - z_i_0));
  }
}


