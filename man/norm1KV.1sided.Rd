%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File: norm1KV.1sided.Rd
% Package: BAEssd
% Purpose: Documents the suite of functions related to the one-sample normal
%          experiment with one-sided alternative.
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
\name{norm1KV.1sided}
\alias{norm1KV.1sided}

%%% Title
\title{Normal Suite: One Sample, One Sided, Known Variance}

%%% Description
\description{
  Generates the suite of functions related to the one sample normal experiment 
  with a one-sided alternative hypothesis of interest when the variance is
  known.
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Usage
%   1. How to call the function.
%   2. Parameter description.

%%% Calling the functions.
\usage{
  norm1KV.1sided(sigma, theta0, mu, tau)
}

%%% Parameters
\arguments{
  \item{sigma}{
    Scalar. The known standard deviation of the population of interest.
  }
  
  \item{theta0}{
    Scalar. The critical value of the mean under the null hypothesis:
    theta<=theta0.
  }
  
  \item{mu}{
    Scalar. The mean of the normal prior density on theta. See documentation 
    for \code{\link{dnorm}}.
  }
  
  \item{tau}{
    Scalar. The standard deviation for the normal prior density on theta. See
    documentation for \code{\link{dnorm}}.
  }
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% More Details
%   1. Detailed description of function and parameter explanation.
%   2. Description of the what is returned by the function.

%%% Details
\details{
  \code{norm1KV.1sided} is used to generate a suite of functions for a 
  one-sample normal experiment with a one-sided alternative hypothesis when the
  variance is known. That is, when
    \deqn{X \sim Normal(\theta,\sigma^2)}{%
          X ~ Normal(theta,sigma2)}
    \deqn{H_0: \theta \leq \theta_0 \quad vs.
            \quad H_1: \theta > \theta_0}{%
          H0: theta <= theta0   vs.   H1: theta > theta0}
       
  using the following prior on theta
    \deqn{\pi(\theta) = Normal(\mu,\tau^2)}{%
          pi(theta) = Normal(mu,tau2),}
          
  where Normal(mu,tau2) is Normal density with mean \code{mu} and variance
  \code{tau2}.
          
  The functions that are generated are useful in examining the prior and 
  posterior densities of the parameter \code{theta}, as well as constructing the
  Bayes Factor and determining the sample size via an average error based
  approach.
  
  The arguments of \code{norm1KV.1sided} are passed to each of the additional
  functions upon their creation as default values. That is, if \code{mu} is
  set to 1 in the call to \code{norm1KV.1sided}, each of the functions returned
  will have the defaualt value of 1 for \code{mu}. If an argument is not
  specified in the call to \code{norm1KV.1sided}, then it remains a required
  parameter in all functions created.
}

%%% Value
\value{
  \code{norm1KV.1sided} returns a list of 4 functions:
  \item{logm}{
    Returns a list of three vectors: the log marginal density under
    the null hypothesis (\code{logm0}), the log marginal density under the 
    alternative hypothesis (\code{logm1}), the log marginal density 
    (\code{logm}). Each are evaluated at the observed data provided.  The
    function takes the following usage:
    \preformatted{logm(xbar, n, sigma, theta0, mu, tau)}
    \itemize{
      \item \code{xbar}: Vector. Observed sample mean from the experiment.
      
      \item \code{n}: Scalar. Sample Size.
      
      \item Remaining parameters described above for \code{norm1KV.1sided}.
    }
  }
  
  \item{logbf}{
    Returns a vector. The value of the log Bayes Factor given the observed
    data provided and the prior parameters specified.  The function has the
    following usage:
    \preformatted{logbf(xbar, n, sigma, theta0, mu, tau)}    
    See \code{logm} above for details on the parameters of the function.
  }
  
  \item{prior}{
    Returns a vector. The value of the prior density.  The function has the
    following usage:
    \preformatted{prior(theta, mu, tau)}
    \itemize{
      \item \code{theta}: Vector. The quantiles at which to evaluate the prior.
      
      \item Remaining parameters described above for \code{norm1KV.1sided}.
    }
  }
  
  \item{post}{
    Returns a vector. The value of the posterior density.  The function has
    the following usage:
    \preformatted{post(theta, xbar, n, sigma, mu, tau)}
    \itemize{
      \item \code{theta}: Vector. The quantiles at which to evaluate the prior.
      
      \item \code{xbar}: Vector. Observed sample mean from the experiment.
      
      \item \code{n}: Scalar. Sample Size.
      
      \item Remaining parameters described above for \code{norm1KV.1sided}.
    }
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
\code{\link{norm1KV.2sided}},\code{\link{norm2KV.2sided}}
\code{\link{norm1UV.2sided}},\code{\link{ssd}},\code{\link{BAEssd}}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% R Examples
\examples{
############################################################
# Generate the suite of functions for a one-sample normal
# with a one-sided test. Consider the hypothesis
#      H0: theta<=0  vs.  H1: theta>0
#
# with a normal prior for theta with prior mean 2 and 
# prior standard deviation 1. The known standard 
# deviation for the population is 5.

# generate suite
f5 <- norm1KV.1sided(sigma=5,theta0=0,mu=2,tau=1)

# attach suite
attach(f5)

# plot the prior and posterior density when the observed data is
#  n = 30, xbar = 1.
mus <- seq(-5,5,0.01)
mu1 <- prior(mus)
mu2 <- post(mus,xbar=1,n=30)

plot(c(mu1,mu2)~rep(mus,2),type="n",ylab="Density",xlab="mu",main="")
lines(mu1~mus,lty=1,lwd=2)
lines(mu2~mus,lty=2,lwd=2)

# perform sample size calculation with TE bound of 0.25 and weight 0.5
ssd.norm1KV(alpha=0.25,w=0.5,logm=logm)

# detain suite
detach(f5)
}
