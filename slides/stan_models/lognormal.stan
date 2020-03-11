data {
  int<lower=1> N_obs;
  vector[N_obs] rt;
}
parameters {
  real<lower=0> sigma;
  real mu;
}
model {
  target += normal_lpdf(mu | 6, 1.5);
  target += normal_lpdf(sigma | 0, 1)  -
    normal_lccdf(0 | 0, 1);
  target += lognormal_lpdf(rt | mu, sigma); 
}
generated quantities {
  vector[N_obs] rt_sim;
  // posterior predictive
  for(i in 1:N_obs) {
    rt_sim[i] = lognormal_rng(mu, sigma);
  }
}
