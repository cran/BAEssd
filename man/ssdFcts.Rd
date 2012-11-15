%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File: ssdFcts.Rd
% Package: BAEssd
% Purpose: Documents the ssd functions.
%
% Author: Eric Reyes
% Date: 18 Jun 2010
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
\name{ssdFcts}
\alias{ssdFcts}
\alias{ssd}
\alias{ssd.binom}
\alias{ssd.norm1KV}
\alias{ssd.norm1KV.2sided}
\alias{ssd.norm2KV.2sided}
\alias{ssd.norm1UV.2sided}
\alias{print.BAEssd}

%%% Title
\title{Sample Size Calculations via Bayesian Average Errors}

%%% Description
\description{
  A Bayesian average error based approach to sample size determination. These
  functions compute the required sample size for various designs common to 
  clinical trials. A specified Total Error rate is maintain and more emphasis
  can be placed on controlling Average Type-I Error or Type-II Error.
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Usage
%   1. How to call the function.
%   2. Parameter description.

%%% Calling the functions.
\usage{
  ssd.binom(alpha, w, logm, minn = 2, maxn = 1000, two.sample = FALSE,
            all = FALSE, \dots)
  ssd.norm1KV(alpha, w, logm, minn = 2, maxn = 1000, all = FALSE, \dots)
}

%%% Parameters
\arguments{
  \item{alpha}{
    Scalar. The bound to maintain on the Total Error rate. Must be a decimal
    between 0 and 1.
  }
  
  \item{w}{
    Scalar. The weight to be given to Average Type-I Error. Larger values of
    w control Type-I error rates more. Must be a decimal between 0 and 1.
  }
  
  \item{logm}{
    Function. Computes the log marginal (prior predictive density) under H0 and
    H1. This function should return a list that contains two components:
      \tabular{ll}{
        \code{logm0} \tab vector giving marginal density under H0.\cr
        \code{logm1} \tab vector giving marginal density under H1.\cr
      }
      
    The first parameter of this function should be the observed data.
    See details for necessary form. The second parameter should be the sample
    size. 
  }
  
  \item{minn, maxn}{
    Scalar. The minimum and maximum sample size to consider.
  }
  
  \item{all}{
    Boolean. If \code{FALSE} (default), the function terminates when an 
    acceptable sample size is found or when \code{maxn} is reached. If
    \code{TRUE}, the function will only terminate when \code{maxn} is reached.
    This is useful for tracing out the Average Error as a function of sample
    size.
  }
  
  \item{two.sample}{
    Boolean. If \code{FALSE} (default), one sample experiment is assumed. If
    \code{TRUE}, two sample experiment is assumed.
  }
  
  \item{\dots}{
    Additional parameters to be passed to \code{logm} if necessary.
  }
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% More Details
%   1. Detailed description of function and parameter explanation.
%   2. Description of the what is returned by the function.

%%% Details
\details{
  Sample size calculations are dependent upon the knowledge of the marginal
  density under each hypothesis. The function \code{logm} should provide these
  densities. 
  
  For a one-sample binomial experiment, the first argument of \code{logm} should
  be a vector in which each entry represents a different number of successes
  out of n independent binary trials. For a two-sample binomial experiment, the
  first argument of \code{logm} should be a matrix, in which each row represents
  the number of successes for each of the samples out of n indpendent trials.
  For an example see \code{\link{binom1.1sided}}.
  
  For a one-sample normal experiment with known variance, the first argument
  shoul be a vector of different sample means. For an example see
  \code{\link{norm1KV.1sided}}.
  
  In addition, there are a few functions specific to a given situation (or 
  suite); these are 
    \itemize{
      \item \preformatted{ssd.norm1KV.2sided(alpha, w, sigma, theta0, prob, mu, 
      tau, minn = 2, maxn = 1000, all = FALSE)}
      
      \item \preformatted{ssd.norm2KV.2sided(alpha, w, sigma, prob, mu0, tau0,
      mu1, tau1, mu2, tau2, m = 2500, minn = 2, maxn = 1000, all = FALSE)}
      
      \item \preformatted{ssd.norm1UV.2sided(alpha, w, theta0, prob, mu, scale,
      shape, rate, m = 2500, minn = 3, maxn = 1000, all = FALSE)}
    }
    
  The only parameter unique to these functions is 
    \itemize{
      \item \code{m}: The number of Monte Carlo replicates to use in computing 
      the average errors.
    }
    
  The \code{logm} function is not required as the function is specific to that
  suite. Instead, various parameters unique to that suite are required.  See
  the corresponding suite for details.
}
  
%%% Value
\value{
  An object of class "BAEssd" which is a list containing the following elements:
  
  \item{call}{
    The call to the function.
  }
  
  \item{history}{
    Dataframe. Contains one row for each sample size considered during the
    function evaluation. Each row records the sample size attempted, the
    average type-I and type-II errors, the total weighted error, and the total
    error.
  }
  
  \item{n}{
    Scalar. The chosen sample size with attributes related to the function call
    and total error.
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
  \code{\link{summary.BAEssd}},\code{\link{plot.BAEssd}},
  \code{\link{binom1.1sided}},\code{\link{binom1.2sided}},
  \code{\link{binom2.1sided}},\code{\link{binom2.2sided}},
  \code{\link{norm1KV.1sided}},\code{\link{norm1KV.2sided}},
  \code{\link{norm2KV.2sided}},\code{\link{norm1UV.2sided}}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% R Examples
\examples{
############################################################
# Computing a sample size for a one-sample binomial
# experiment with a two-sided alternative.

# load suite of functions
f1 <- binom1.2sided(p0=0.5,prob=0.5,a=1,b=1)

# calculate sample size for total error bound of 0.25 and weight 0.5
attach(f1)
ss1 <- ssd.binom(alpha=0.25,w=0.5,logm=logm,two.sample=FALSE)
detach(f1)

# see results
ss1

# examine structure
str(ss1)


############################################################
# Computing a sample size for a one-sample normal
# experiment with a two-sided alternative using the
# functions internal to the suite.

# load suite of functions
f2 <- norm1KV.2sided(sigma=5,theta0=0,prob=0.5,mu=2,tau=1)

# calculate sample size for total error bound of 0.25 and weight 0.5
attach(f2)
ss2 <- ssd.norm1KV.2sided(alpha=0.25,w=0.5)
detach(f2)

# see results
ss2
}