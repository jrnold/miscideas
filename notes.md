## Prior Data by Simulating Data

The inspiration for this was reading over a propsed prior complexity prior:

- Daniel P. Simpson, Håvard Rue, Thiago G. Martins, Andrea Riebler, Sigrunn H. Sørbye. Penalising model component complexity: A principled, practical approach to constructing priors. https://arxiv.org/abs/1403.4630

It penalizes a model to simpler forms; but it still seems to require that the model be nested.

If we want to penalize (regularize/shrink) a model towards another model, why not

1. Estimate the prior model
2. Draw samples from the posterior predictive distribution
3. Estimate the complicated model with original and sampled data - the sampled data discounted.

Question: Is this  just equivalent a mixture model or Bayesian model averaging?


## Shrinkage for Treatment Effects

- Han, Carvalho, He, and Puelz. REGULARIZATION AND CONFOUNDING IN LINEAR REGRESSION FOR TREATMENT EFFECT ESTIMATION. https://arxiv.org/pdf/1602.02176.pdf
- Belloni,  Chernozhukov, and Hansen. 2014. High-Dimensional Methods and Inference on Structural and Treatment Effects. https://www.aeaweb.org/articles?id=10.1257/jep.28.2.29

Idea: this is more a Bayesian version of the model in Belloni et al. Instead of estimating the equations separately, estimate
them simultaneously, and share information about sparsity by using the same
$$
y_i = \alpha + \tau x + \sum_{k = 1}^{K} \beta_k x_{i,k} + \epsilon_i \\
y_i = \beta_0 + \tau x + \sum_{k = 1}^{K} \beta_k x_{i,k} + \epsilon_i \\

$$


## Omitted Variable Bias

This set of papers provide some methods to estimate the bounds of potential omitted variable bias

- Nunn, Nathan, and Leonard Wantchekon. 2011. "The Slave Trade and the Origins of Mistrust in Africa." American Economic Review, 101(7): 3221-52.
DOI: 10.1257/aer.101.7.3221. See section IV.B "Using Selection on Observables to Assess the Bias from Unobservables"
- "Selection on Observed and Unobserved Variables: Assessing the Effectiveness of Catholic Schools" Joseph G. Altonji, Todd E. Elder, and Christopher R. Taber Journal of Political Economy 2005 113:1, 151-184
- Oster. "Unobservable Selection and Coefficient Stability: Theory and Evidence" https://www.brown.edu/research/projects/oster/sites/brown.edu.research.projects.oster/files/uploads/Unobservable_Selection_and_Coefficient_Stability_0.pdf
- Pischke and Schwandt. 2016. "Poorly Measured Confounders are More Useful on the Left Than on the Right" http://ai2-s2-pdfs.s3.amazonaws.com/7da3/396ab253bcaadd4f449f3ee4182863052083.pdf

Question: What would the equivalent Bayesian model look like? What would the generative model be - with the omitted variable values as parameters?
What does the equivalent prior to the proportional selection on observables assumption which those papers rely on.

### Ideas

Jotting down a few ideas ..

Suppose the true equation is
$$
y_i = \tau x_i + \beta z_i + \gamma \zeta_i + \epsilon_i
$$
where $y$, $x$, and $z$ are observed, and the others, including the omitted variable ($\omega$) are not.

What else do we know? or assume?
$$
\E(\epsilon_i) = 0
$$

$$
The omitted variable should be uncorrelated with $z_i$ (or at least the part of z_i that is correlated with x_i)
$$
\Cov(\omega_i, \zeta_i) = 0
$$


Put a prior on the overall explanatory power of the regression: as in https://cran.r-project.org/web/packages/rstanarm/vignettes/lm.html?
I think the g-prior since it is interpretable as the $R^2$ of the regresssion would also work.

Basically we want priors (or implied) over the covariance of $x$ and $\zeta$ and $y$ and $z$? ($\gamma$).

If the input was a fixed value of the covariance between $x$ and the omitted variable $\zeta_i$, then the uniform circular distribution could
be used to draw values of $\zeta_i$ in a "distribution free" way.


Model the entire thing with priors on components of the covariance matrix of $y$, $x$, $z$ and $\omega$?

Question: isn't this *just* SEM? Has it been done before as an SEM? So what's new? My guess would be even if done as SEM,
it was via MLE - so couldn't effectively use priors to identify the omitted varible. Even if done before, new Bayesian methods
like HMC may allow flexibility in the choice of priors so not as constrained by choosing only conjugate priors.
