%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File: binom1.2sided.Rd
% Package: BAEssd
% Purpose: Documents the suite of functions related to the one-sample binomial
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
\name{binom1.2sided}
\alias{binom1.2sided}

%%% Title
\title{Binomial Suite: One Sample, Two Sided}

%%% Description
\description{
  Generates the suite of functions related to the one sample binomial experiment 
  with a two-sided alternative hypothesis of interest.
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Usage
%   1. How to call the function.
%   2. Parameter description.

%%% Calling the functions.
\usage{
  binom1.2sided(p0, prob, a, b)
}

%%% Parameters
\arguments{
  \item{p0}{
    Scalar. The value of p under null hypothesis Ho: p==p0. Must be a value
    between 0 and 1.
  }
  
  \item{prob}{
    Scalar. The prior probability that the null hypothesis is true. Must be a
    value between 0 and 1.
  }
  
  \item{a}{
    Scalar. Shape1 parameter for prior Beta distribution. See documentation for 
    \code{\link{dbeta}}.
  }
  
  \item{b}{
    Scalar. Shape2 parameter for prior Beta distribution. See documentation for 
    \code{\link{dbeta}}.
  }
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% More Details
%   1. Detailed description of function and parameter explanation.
%   2. Description of the what is returned by the function.

%%% Details
\details{
  \code{binom1.2sided} is used to generate a suite of functions for a one-sample
  binomial experiment with a two-sided alternative hypothesis. That is, when
    \deqn{X \sim Binomial(n,p)}{%
          X ~ Binomial(n,p)}
    \deqn{H_0: p = p_0 \quad vs. \quad H_1: p \neq p_0}{%
          H0: p == p0   vs.   H1: p != p0}
       
  using the following prior on p
    \deqn{\pi(p) = u*I(p=p_0) + (1-u)*I(p\neq p_0)Beta(a,b)}{%
          pi(p) = u*(p==p0) + (1-u)*(p!=p0)Beta(a,b),}
          
  where Beta(a,b) is Beta density with parameters \code{a} and \code{b} and
  \code{u} is the prior probability of the null hypothesis (\code{prob}).
          
  The functions that are generated are useful in examining the prior and 
  posterior densities of the parameter \code{p}, as well as constructing the
  Bayes Factor and determining the sample size via an average error based
  approach.
  
  The arguments of \code{binom1.2sided} are passed to each of the additional
  functions upon their creation as default values. That is, if \code{p0} is
  set to 0.5 in the call to \code{binom1.2sided}, each of the functions returned
  will have the defaualt value of 0.5 for \code{p0}. If an argument is not
  specified in the call to \code{binom1.2sided}, then it remains a required
  parameter in all functions created.
}

%%% Value
\value{
  \code{binom1.2sided} returns a list of 4 functions:
  \item{logm}{
    Returns a list of three vectors: the log marginal density under
    the null hypothesis (\code{logm0}), the log marginal density under the 
    alternative hypothesis (\code{logm1}), the log marginal density 
    (\code{logm}). Each are evaluated at the observed data provided. This
    function is passed to \code{\link{ssd.binom}} to calculate required sample
    sizes.  The function has the following usage:
    \preformatted{logm(x, n, p0, prob, a, b)}
    \itemize{
      \item \code{x}: Vector. Number of successes observed, out of \code{n} 
        independent Bernoulli trials.
      \item \code{n}: Scalar. Sample size, the number of independent 
        Bernoulli trials.
      \item Remaining parameters specified above for \code{binom1.1sided}.}
  }
  
  \item{logbf}{
    Returns a vector: the value of the log Bayes Factor given the observed
    data provided and the prior parameters specified.  The function has the 
    following usage:
    \preformatted{logbf(x, n, p0, prob, a, b)}
    For details on the parameters, see above function \code{logm}
  }
  
  \item{prior}{
    Returns a vector: the value of the prior density.  The function has the
    following usage:
    \preformatted{prior(p, p0, prob, a, b)}
    \itemize{
      \item \code{p}: Scalar. Quantiles for the prior distribution.
      \item Remaining parameters specified above for \code{binom1.1sided}.}
  }
  
  \item{post}{
    Returns a vector: the value of the posterior density.  The function has the
    following usage:
    \preformatted{post(p, x, n, p0, prob, a, b)}
    \itemize{
      \item \code{p}: Scalar.  Quantiles for the posterior distribution.
      \item \code{x}: Scalar.  Number of successes observed, out of \code{n}       
        independent Bernoulli trials.
      \item Remaining parameters specified above for \code{binom1.1sided}.}
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
\code{\link{binom1.1sided}},\code{\link{binom2.1sided}},
\code{\link{binom2.2sided}},\code{\link{norm1KV.1sided}},
\code{\link{norm1KV.2sided}},\code{\link{norm2KV.2sided}}
\code{\link{norm1UV.2sided}},\code{\link{ssd}},\code{\link{BAEssd}}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% R Examples
\examples{
############################################################
# Generate the suite of functions for a one-sample binomial
# with a two-sided test. Consider the hypothesis
#      H0: p==0.5   vs.  H1: p!=0.5
#
# with a uniform prior on p under the alternative and a
# prior probability of the null hypothesis equal to 0.5.

# generate suite
f2 <- binom1.2sided(p0=0.5,prob=0.5,a=1,b=1)

# attach suite
attach(f2)

# plot prior and posterior given x = 25, n = 30
#  - don't forget that point mass is not shown on plot
ps <- seq(0.01,0.99,0.01)
p1 <- prior(ps)
p2 <- post(ps,x=25,n=30)

plot(c(p1,p2)~rep(ps,2),type="n",ylab="Density",xlab="p",main="")
lines(p1~ps,lty=1,lwd=2)
lines(p2~ps,lty=2,lwd=2)

# perform sample size calculation with TE bound of 0.25 and weight 0.5
ssd.binom(alpha=0.25,w=0.5,logm=logm)

# detain suite
detach(f2)
}
