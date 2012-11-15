%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File: norm1UV.2sided.Rd
% Package: BAEssd
% Purpose: Documents the suite of functions related to the one-sample normal
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
\name{norm1UV.2sided}
\alias{norm1UV.2sided}

%%% Title
\title{Normal Suite: One Sample, Two Sided, Unknown Variance}

%%% Description
\description{
  Generates the suite of functions related to the one sample normal experiment 
  with a two-sided alternative hypothesis of interest when the variance is
  unknown.
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Usage
%   1. How to call the function.
%   2. Parameter description.

%%% Calling the functions.
\usage{
  norm1UV.2sided(theta0, prob, mu, scale, shape, rate)
}

%%% Parameters
\arguments{
  \item{theta0}{
    Scalar. The critical value of the mean under the null hypothesis:
    theta==theta0.
  }
  
  \item{prob}{
    Scalar. The prior probability of the null hypothesis. Must be a value
    between 0 and 1.
  }
  
  \item{mu}{
    Scalar. The mean of the normal prior density on theta under the alternative
    hypothesis. See documentation for \code{\link{dnorm}}.
  }
  
  \item{scale}{
    Scalar. Used to determine the standard deviation for the normal prior 
    density on theta under the alternative hypothesis. The standard deviation
    is equal to \code{scale*sigma}. See documentation for \code{\link{dnorm}}.
  }
  
  \item{shape}{
    Scalar. The shape parameter for the gamma prior on the inverse of the
    unknown standard deviation \code{sigma2}. See documenation for 
    \code{\link{dgamma}}.
  }
  
  \item{rate}{
    Scalar. The rate parameter for the gamma prior on the inverse of the 
    unknown standard deviation \code{sigma2}. See documentation for
    \code{\link{dgamma}}.
  }
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% More Details
%   1. Detailed description of function and parameter explanation.
%   2. Description of the what is returned by the function.

%%% Details
\details{
  \code{norm1UV.2sided} is used to generate a suite of functions for a 
  one-sample normal experiment with a two-sided alternative hypothesis when the
  variance is unknown. That is, when
    \deqn{X \sim Normal(\theta,\sigma^2)}{%
          X ~ Normal(theta,sigma2)}
    \deqn{H_0: \theta = \theta_0 \quad vs.
            \quad H_1: \theta \neq \theta_0}{%
          H0: theta == theta0   vs.   H1: theta != theta0}
       
  using the following prior on theta and sigma2
    \deqn{\pi(\theta|\sigma^2) = u*I(\theta=\theta_0) +
            (1-u)*I(\theta \neq \theta_0)Normal(\mu,(scale \sigma)^2)}{%
          pi(theta|sigma2) = u*I(theta==theta0) + 
            (1-u)*I(theta!=theta0)Normal(mu,(scale*sigma)^2),}
            
    \deqn{\pi(\sigma^2) = InverseGamma(shape,rate)}{%
          pi(sigma2) = InverseGamma(shape,rate),}
          
  where Normal(mu,tau2) is Normal density with mean \code{mu} and variance
  \code{tau2} and u is the prior probability of the null hypothesis 
  (\code{prob}).
          
  The functions that are generated are useful in examining the prior and 
  posterior densities of the parameters \code{theta} and \code{sigma2}, as well 
  as constructing the Bayes Factor and determining the sample size via an 
  average error based approach.
  
  The arguments of \code{norm1UV.2sided} are passed to each of the additional
  functions upon their creation as default values. That is, if \code{mu} is
  set to 1 in the call to \code{norm1UV.2sided}, each of the functions returned
  will have the defaualt value of 1 for \code{mu}. If an argument is not
  specified in the call to \code{norm1UV.2sided}, then it remains a required
  parameter in all functions created.
}

%%% Value
\value{
  \code{norm1UV.2sided} returns a list of 5 functions:
  \item{logm}{
    Returns a list of three vectors: the log marginal density under
    the null hypothesis (\code{logm0}), the log marginal density under the 
    alternative hypothesis (\code{logm1}), the log marginal density 
    (\code{logm}). Each are evaluated at the observed data provided.  The 
    function takes the following usage:
    \preformatted{logm(xbar, s2, n, theta0, prob, mu, scale, shape, rate)}
    \itemize{
      \item \code{xbar}: Vector.  Observed sample mean from the experiment.
      
      \item \code{s2}: Vector. Observed sample standard deviation from the
      experiment.
      
      \item \code{n}: Scalar. Sample size.
      
      \item Remaining parameters described above for \code{norm1UV.2sided}.
    }
  }
  
  \item{logbf}{
    Returns a vector. The value of the log Bayes Factor given the observed
    data provided and the prior parameters specified.  The function has the
    following usage:
    \preformatted{logbf(xbar, s2, n, theta0, prob, mu, scale, shape, rate)}
    For details on the arguments, see \code{logm} above.
  }
  
  \item{prior}{
    Returns a vector. The value of the prior density.  The function has the 
    following usage:
    \preformatted{prior(theta, sigma2, theta0, prob, mu, scale, shape, rate)}
    \itemize{
      \item \code{theta}: Vector. The quantiles of the mean at which to 
      evaluate the prior.
      
      \item \code{sigma2}: Vector. The quantiles of the standard deviation at
      which to evaluate the prior.
      
      \item Remaining parameters described above for \code{norm1UV.2sided}
    }
  }
  
  \item{post}{
    Returns a vector. The value of the posterior density.  The function has the
    following usage:
    \preformatted{post(theta, sigma2, xbar, s2, n, theta0, prob, mu, scale, 
    shape, rate)}
    \itemize{
      \item \code{theta}: Vector. The quantiles of the mean at which to 
      evaluate the posterior.
      
      \item \code{sigma2}: Vector. The quantiles of the standard deviation at
      which to evaluate the psterior.
      
      \item \code{xbar}: Vector.  Observed sample mean from the experiment.
      
      \item \code{s2}: Vector. Observed sample standard deviation from the
      experiment.
      
      \item \code{n}: Scalar. Sample size.
      
      \item Remaining parameters described above for \code{norm1UV.2sided}
    }
  }
  
  \item{ssd.norm1UV.2sided}{
    Sample size calculations for this particular set-up. The function has the
    following usage:
    \preformatted{ssd.norm1UV.2sided(alpha, w, theta0, prob, mu, scale, shape, 
    rate, m = 2500, minn = 3, maxn = 1000, all = FALSE)}
    See \code{\link{ssd}} for more details.  The suite-specific parameters are
    described above for \code{norm1UV.2sided}. Note that this example will not
    work with \code{ssd.norm1KV}.
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
\code{\link{norm2KV.2sided}},\code{\link{ssd}},\code{\link{BAEssd}}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% R Examples
\examples{
############################################################
# Generate the suite of functions for a one-sample normal
# with a two-sided test. Consider the hypothesis
#      H0: theta==0  vs.  H1: theta!=0
#
# with a normal prior for theta with prior mean 2 and 
# scale of 1/3 for the standard deviation. The prior proability
# of the null hypothesis is set to 0.5. The prior density
# on sigma2 is taken to be InverseGamma with parameters
# 11 and 30 for the shape and rate.

# generate suite
f8 <- norm1UV.2sided(theta0=0,prob=0.5,mu=2,scale=(1/3),shape=11,rate=30)

# attach suite
attach(f8)

# calculate the Bayes Factor for the following observed data
#   n = 30, xbar = 1, s2 = 2
logbf(xbar=1,s2=2,n=30)

# perform sample size calculation with TE bound of 0.25 and weight 0.5
ssd.norm1UV.2sided(alpha=0.25,w=0.5)

# detain suite
detach(f8)
}
