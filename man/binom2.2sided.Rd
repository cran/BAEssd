%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File: binom2.2sided.Rd
% Package: BAEssd
% Purpose: Documents the suite of functions related to the two-sample binomial
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
\name{binom2.2sided}
\alias{binom2.2sided}

%%% Title
\title{Binomial Suite: Two Sample, Two Sided}

%%% Description
\description{
  Generates the suite of functions related to the two sample binomial experiment 
  with a two-sided alternative hypothesis of interest.
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Usage
%   1. How to call the function.
%   2. Parameter description.

%%% Calling the functions.
\usage{
  binom2.2sided(prob, a0, b0, a1, b1, a2, b2)
}

%%% Parameters
\arguments{
  \item{prob}{
    Scalar. The prior probability that the null hypothesis is true. Must be a
    value between 0 and 1.
  }
  
  \item{a0}{
    Scalar. Shape1 parameter for prior Beta distribution under the null
    hypothesis that the two parameters are equal. See documentation for 
    \code{\link{dbeta}}.
  }
  
  \item{b0}{
    Scalar. Shape2 parameter for prior Beta distribution under the null
    hypothesis that the two parameters are equal. See documentation for 
    \code{\link{dbeta}}.
  }
  
  \item{a1}{
    Scalar. Shape1 parameter for prior Beta distribution for the parameter
    governing sample 1 under the alternative hypothesis. See documentation for 
    \code{\link{dbeta}}.
  }
  
  \item{b1}{
    Scalar. Shape2 parameter for prior Beta distribution for the parameter
    governing sample 1 under the alternative hypothesis. See documentation for 
    \code{\link{dbeta}}.
  }
  
  \item{a2}{
    Scalar. Shape1 parameter for prior Beta distribution for the parameter
    governing sample 2 under the alternative hypothesis. See documentation for 
    \code{\link{dbeta}}.
  }
  
  \item{b2}{
    Scalar. Shape2 parameter for prior Beta distribution for the parameter
    governing sample 2 under the alternative hypothesis. See documentation for 
    \code{\link{dbeta}}.
  }
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% More Details
%   1. Detailed description of function and parameter explanation.
%   2. Description of the what is returned by the function.

%%% Details
\details{
  \code{binom2.2sided} is used to generate a suite of functions for a two-sample
  binomial experiment with a two-sided alternative hypothesis. That is, when
    \deqn{X_j|p_j \sim Binomial(n,p_j), \quad independent}{%
          X[j]|p[j] ~ Binomial(n,p[j]), independent}
    \deqn{H_0: p_1 = p_2 \quad vs. \quad H_1: p_1 \neq p_2}{%
          H0: p[1] == p[2]   vs.   H1: p[1] != p[2]}
       
  using the following prior on p[1] and p[2]
    \deqn{\pi(p) = u*I(p_1=p_2)Beta(a_0,b_0) + 
           (1-u)*I(p_1\neq p_2)Beta(a_1,b_1)Beta(a_2,b_2)}{%
          pi(p) = u*(p[1]==p[2])Beta(a0,b0) + 
           (1-u)*(p[1]!=p[2])Beta(a1,b1)Beta(a2,b2),}
          
  where Beta(a,b) is Beta density with parameters \code{a} and \code{b} and
  \code{u} is the prior probability of the null hypothesis (\code{prob}).
          
  The functions that are generated are useful in examining the prior and 
  posterior densities of the parameter \code{p}, as well as constructing the
  Bayes Factor and determining the sample size via an average error based
  approach.
  
  The arguments of \code{binom2.2sided} are passed to each of the additional
  functions upon their creation as default values. That is, if \code{a0} is
  set to 1 in the call to \code{binom2.2sided}, each of the functions returned
  will have the defaualt value of 1 for \code{a0}. If an argument is not
  specified in the call to \code{binom2.2sided}, then it remains a required
  parameter in all functions created.
}

%%% Value
\value{
  \code{binom2.2sided} returns a list of 4 functions:
  \item{logm}{
    Returns a list of three vectors: the log marginal density under
    the null hypothesis (\code{logm0}), the log marginal density under the 
    alternative hypothesis (\code{logm1}), the log marginal density 
    (\code{logm}). Each are evaluated at the observed data provided. This
    function is passed to \code{\link{ssd.binom}} to calculate required sample
    sizes.  This function takes the following usage:
    \preformatted{logm(x, n, prob, a0, b0, a1, b1, a2, b2)}
    \itemize{
      \item \code{x}: Matrix with two columns.  Each row represents the number
      of successes in sample 1 and sample 2, respectively, observed out of
      \code{n} independent Bernoulli trials.
      
      \item \code{n}: Scalar. The number of independent Bernoulli trials.
      
      \item Remaining parameters described above for \code{bionom2.2sided}.
    }
  }
  
  \item{logbf}{
    Returns a vector. The value of the log Bayes Factor given the observed
    data provided and the prior parameters specified.  The function has the
    following usage:
    \preformatted{logbf(x, n, prob, a0, b0, a1, b1, a2, b2)}
    For details on the parameters, see \code{logm} above.
  }
  
  \item{prior}{
    Returns a vector. The value of the prior density.  The function takes the 
    following usage:
    \preformatted{prior(p, prob, a0, b0, a1, b1, a2, b2)}
    \itemize{
      \item \code{p}: Matrix with 2 columns.  Each row is a vector of length 2
      corresponding to a 2-dimensional quantile at which to compute the density.
      The first column represents the parameter for sample 1, and the second
      column, the parameter for sample 2.
      
      \item Remaining parameters described above for \code{binom2.2sided}.
    }
  }
  
  \item{post}{
    Returns a vector. The value of the posterior density.  The function takes
    the following usage:
    \preformatted{post(p, x, n, prob, a0, b0, a1, b1, a2, b2)}
    \itemize{
      \item \code{p}: Matrix with 2 columns.  Each row is a vector of length 2
      corresponding to a 2-dimensional quantile at which to compute the density.
      The first column represents the parameter for sample 1, and the second
      column, the parameter for sample 2.
      
      \item \code{x}: Vector of length 2.  Element 1 represents the number of
      successes for sample 1 and element 2 the number of successes in sample 2.
      
      \item Remaining parameters described above for \code{binom2.2sided}.
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
\code{\link{binom2.1sided}},\code{\link{norm1KV.1sided}},
\code{\link{norm1KV.2sided}},\code{\link{norm2KV.2sided}}
\code{\link{norm1UV.2sided}},\code{\link{ssd}},\code{\link{BAEssd}}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% R Examples
\examples{
############################################################
# Generate the suite of functions for a one-sample binomial
# with a two-sided test. Consider the hypothesis
#      H0: p[1]==p[2]   vs.  H1: p[1]!=p[2]
#
# with a uniform prior on p under the null and a uniform
# prior on p[1] and p[2] under the alternative with a 0.5
# probability of the null hypothesis being true.

# generate suite
f4 <- binom2.2sided(prob=0.5,a0=1,b0=1,a1=1,b1=1,a2=1,b2=1)

# attach suite
attach(f4)

# calculate the Bayes factor when the observed data are
#   n = 30, x[1] = 10, x[2] = 20
logbf(x=matrix(c(10,20),ncol=2,nrow=1),n=30)

# perform sample size calculation with TE bound of 0.25 and weight 0.5
ssd.binom(alpha=0.25,w=0.5,logm=logm,two.sample=TRUE)

# detain suite
detach(f4)
}
