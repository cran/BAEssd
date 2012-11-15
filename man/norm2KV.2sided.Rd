%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File: norm2KV.2sided.Rd
% Package: BAEssd
% Purpose: Documents the suite of functions related to the two-sample normal
%          experiment with two-sided alternative.
%
% Author: Eric Reyes
% Date: 21 Jun 2010
% Modified:
%
% Notes:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Header
%   1. Names and aliases.
%   2. Title.
%   3. Description.

%%% Names and aliases
\name{norm2KV.2sided}
\alias{norm2KV.2sided}

%%% Title
\title{Normal Suite: Two Sample, Two Sided, Known Variance}

%%% Description
\description{
  Generates the suite of functions related to the two sample normal experiment 
  with a two-sided alternative hypothesis of interest when the variance is
  known.
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Usage
%   1. How to call the function.
%   2. Parameter description.

%%% Calling the functions.
\usage{
  norm2KV.2sided(sigma, prob, mu0, tau0, mu1, tau1, mu2, tau2)
}

%%% Parameters
\arguments{
  \item{sigma}{
    Scalar. The known standard deviation of the population.
  }
  
  \item{prob}{
    Scalar. The prior probability of the null hypothesis. Must be a value
    between 0 and 1.
  }
  
  \item{mu0}{
    Scalar. The mean of the normal prior density on theta under the null
    hypothesis. See documentation for \code{\link{dnorm}}.
  }
  
  \item{tau0}{
    Scalar. The standard deviation of the normal prior density on theta under 
    the null hypothesis. See documentation for \code{\link{dnorm}}.
  }
  
  \item{mu1}{
    Scalar. The mean of the normal prior density on mean for sample 1 under the 
    alternative hypothesis. See documentation for \code{\link{dnorm}}.
  }
  
  \item{tau1}{
    Scalar. The standard deviation of the normal prior density on mean for
    sample 1 under the alternative hypothesis. See documentation for 
    \code{\link{dnorm}}.
  }
  
  \item{mu2}{
    Scalar. The mean of the normal prior density on mean for sample 2 under the 
    alternative hypothesis. See documentation for \code{\link{dnorm}}.
  }
  
  \item{tau2}{
    Scalar. The standard deviation of the normal prior density on mean for
    sample 2 under the alternative hypothesis. See documentation for 
    \code{\link{dnorm}}.
  }
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% More Details
%   1. Detailed description of function and parameter explanation.
%   2. Description of the what is returned by the function.

%%% Details
\details{
  \code{norm2KV.2sided} is used to generate a suite of functions for a 
  two-sample normal experiment with a two-sided alternative hypothesis when the
  variance is known and the samples are independent. That is, when
    \deqn{X_j \sim Normal(\theta_j,\sigma^2)}{%
          X[j] ~ Normal(theta[j],sigma2)}
    \deqn{H_0: \theta_1 = \theta_2 \quad vs. 
            \quad H_1: \theta_1 \neq \theta_2}{%
          H0: theta[1] == theta[2]   vs.   H1: theta[1] != theta[2]}
       
  using the following prior on theta[1] and theta[2]
    \deqn{\pi(\theta) = u*I(\theta_1=\theta_2)Normal(\mu_0,\tau_0^2) +
            (1-u)*I(\theta_1 \neq \theta_2)
            Normal(\mu_1,\tau_1^2)Normal(\mu_2,\tau_2^2)}{%
          pi(theta) = u*I(theta[1]==theta[2])Normal(mu0,tau0^2) + 
            (1-u)*I(theta[1]!=theta[2])Normal(mu1,tau1^2)Normal(mu2,tau2^2),}
          
  where Normal(mu,tau^2) is Normal density with mean \code{mu} and variance
  \code{tau^2} and u is the prior probability of the null hypothesis 
  (\code{prob}).
          
  The functions that are generated are useful in examining the prior and 
  posterior densities of the parameter \code{theta}, as well as constructing 
  the Bayes Factor and determining the sample size via an average error based 
  approach.
  
  The arguments of \code{norm2KV.2sided} are passed to each of the additional
  functions upon their creation as default values. That is, if \code{mu0} is
  set to 1 in the call to \code{norm2KVV.2sided}, each of the functions returned
  will have the defaualt value of 1 for \code{mu0}. If an argument is not
  specified in the call to \code{norm2KV.2sided}, then it remains a required
  parameter in all functions created.
}

%%% Value
\value{
  \code{norm2KV.2sided} returns a list of 5 functions:
  \item{logm}{
    Returns a list of three vectors: the log marginal density under
    the null hypothesis (\code{logm0}), the log marginal density under the 
    alternative hypothesis (\code{logm1}), the log marginal density 
    (\code{logm}). Each are evaluated at the observed data provided.  The 
    function takes the following usage:
    \preformatted{logm(xbar, n, sigma, prob, mu0, tau0, mu1, tau1, mu2, tau2)}
    \itemize{
      \item \code{xbar}: Matrix with 2 columns.  Each column represents the
      sample mean for each of the two samples.
      
      \item \code{n}: Scalar. The sample size.
      
      \item Remaining parameters are described above for \code{norm2KV.2sided}.
    }
  }
  
  \item{logbf}{
    Returns a vector. The value of the log Bayes Factor given the observed
    data provided and the prior parameters specified.  The function has the 
    following usage:
    \preformatted{logbf(xbar, n, sigma, prob, mu0, tau0, mu1, tau1, mu2, tau2)}
    For details on the arguments, see \code{logm} above.
  }
  
  \item{prior}{
    Returns a vector. The value of the prior density.  The function takes the
    following usage:
    \preformatted{prior(theta, prob, mu0, tau0, mu1, tau1, mu2, tau2)}
    \itemize{
      \item \code{theta}: Vector. The quantiles at which to evaluate the prior.
      
      \item Remaining paramters are described above for \code{norm2KV.2sided}.
    }
  }
  
  \item{post}{
    Returns a vector. The value of the posterior density.  The function takes
    the following usage:
    \preformatted{post(theta, xbar, n, sigma, prob, mu0, tau0, mu1, tau1, mu2,
    tau2)}
    \itemize{
      \item \code{theta}: Vector. The quantiles at which to evaluate the 
      posterior.
      
      \item \code{xbar}: Vector of length 2. Each element represents the sample
      mean for each of the two samples, respectively.
      
      \item \code{n}: Scalar. The sample size.
      
      \item Remaining paramters are described above for \code{norm2KV.2sided}.
    }
  }
  
  \item{ssd.norm2KV.2sided}{
    Sample size calculations for this particular set-up. The function has the
    following usage:
    \preformatted{ssd.norm2KV.2sided(alpha, w, sigma, prob, mu0, tau0, mu1, 
    tau1, mu2, tau2, m = 2500, minn = 2, maxn = 1000, all = FALSE)}
    See \code{\link{ssd}} for more details.  The suite-specific parameters are
    described above for \code{norm2KV.2sided}.
  }
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% References
%   1. References to outside literature.
%   2. Author name.

%%% References


%%% Author


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Additional Notes
%   1. Notes.
%   2. Other functions one should reference.

%%% See also
\seealso{
\code{\link{binom1.1sided}},\code{\link{binom1.2sided}},
\code{\link{binom2.1sided}},\code{\link{binom2.2sided}},
\code{\link{norm1KV.1sided}},\code{\link{norm1KV.2sided}},
\code{\link{norm1UV.2sided}},\code{\link{ssd}},\code{\link{BAEssd}}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% R Examples
\examples{
############################################################
# Generate the suite of functions for a two-sample normal
# with a two-sided test. Consider the hypothesis
#      H0: theta[1]==theta[2]  vs.  H1: theta[1]!=theta[2]
#
# with a known variance of 3.

# generate suite
f7 <- norm2KV.2sided(sigma=3,prob=0.5,mu0=0,tau0=1,mu1=2,tau1=1,mu2=2,tau2=1)

# attach suite
attach(f7)

# calculate the Bayes Factor for the following observed data
#   n = 30, xbar[1] = -1, xbar[2] = 1
logbf(xbar=matrix(c(-1,1),nrow=1,ncol=2),n=30)

# perform sample size calculation with TE bound of 0.5 and weight 0.9
#  - due to a need for a Monte Carlo implementation of this procedure, this
#    problem can take significantly longer to solve, compared to other examples.
#    Thus, for this example, a large error bound and weight were chosen to 
#    decrease computation time while illustrating the function.
ssd.norm2KV.2sided(alpha=0.5,w=0.9)

# detain suite
detach(f7)
}
