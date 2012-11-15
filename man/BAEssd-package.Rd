%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File: BAEssd-package.Rd
% Package: BAEssd
% Purpose: Overview page for package.
%
% Author: Eric Reyes
% Date: 15 Nov 2012
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
\name{BAEssd-package}
\alias{BAEssd-package}
\alias{BAEssd}
\docType{package}

%%% Title
\title{Bayesian Average Error approach to Sample Size Determination}

%%% Description
\description{
  Employes a Bayesian average error based approach to sample size determination.
  Several functions are included for sample size calculation for common designs
  in clinical trials including one- and two-sample binary and normal responses.
  These functions are grouped in "suites" that pertain to each type of example.
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% More Details
%   1. Detailed description of function and parameter explanation.
%   2. Description of the what is returned by the function.

%%% Details
\details{
  \tabular{ll}{
    Package: \tab BAEssd\cr
    Type: \tab Package\cr
    Version: \tab 1.0.1\cr
    Date: \tab 2010-06-18\cr
    Suggests: \tab mvtnorm\cr
    License: \tab GPL-2\cr
    LazyLoad: \tab yes\cr
  }

  Before any calculations can be made, first identify the example of interest
  and the corresponding suite of functions:
    \tabular{ll}{
      \code{binom1.1sided} \tab One sample, binary response, one-sided
                                hypothesis.\cr
      \code{binom1.2sided} \tab One sample, binary response, two-sided
                                hypothesis.\cr
      \code{binom2.1sided} \tab Two indepednent samples, binary response,
                                one-sided hypothesis.\cr
      \code{binom2.2sided} \tab Two independent samples, binary response,
                                two-sided hypothesis.\cr
      \code{norm1KV.1sided} \tab One sample, normal response, known variance,
                                 one-sided hypothesis.\cr
      \code{norm1KV.2sided} \tab One sample, normal response, known variance,
                                 two-sided hypothesis.\cr
      \code{norm1UV.2sided} \tab One sample, normal response, unknown variance,
                                 two-sided hypothesis.\cr
      \code{norm2KV.2sided} \tab Two independent samples, normal response, \cr
                            \tab known variance, two-sided hypothesis.\cr
    }
    
  After selecting the suite of functions of interest, the suite must be
  generated with appropriate parameters. Then, the corresponding \code{ssd}
  function can be used to calculate the sample size. The two primary constraints
  for choosing a sample size are the bound on the Total Error to maintain and
  the weight given to controlling the Average Type-I Error (as opposed to the
  Average Type-II Error). 
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% References
%   1. References to outside literature.
%   2. Author name.

%%% References

%%% Author


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% R Examples
\examples{
############################################################
# Calculate the sample size required for a one-sample 
# normal experiment with known variance (sigma2=25) with
# the hypothesis of interest being
#     H0: theta==0   vs.   H1: theta!=0
#
# where theta is the mean of the normal distribution. For
# details on the prior used, see documentation for
# norm1KV.2sided().

# generate suite of functions
f1 <- norm1KV.2sided(sigma=5,theta0=0,prob=0.5,mu=2,tau=1)

# attach suite
attach(f1)

# calculate sample size for TE bound of 0.25 and weight 0.5
ssd.norm1KV.2sided(alpha=0.25,w=0.5)

# detach suite
detach(f1)


############################################################
# Calculate the sample size required for a two-sample 
# experiment with a binary response in which the hypothesis
# of interest is
#     H0: p1==p2   vs.   H1: p1!=p2
#
# where p1 is the response rate for group 1 and p2 is the
# response rate for group 2, independent samples. For
# details on the prior used, see documentation for
# binom2.2sided().

# generate suite of functions
f2 <- binom2.2sided(prob=0.5,a0=1,b0=1,a1=1,b1=1,a2=1,b2=1)

# attach suite
attach(f2)

# calculate sample size for TE bound of 0.25 and weight 0.5
#   - here the log marginal distribution (logm) is part of the suite.
ssd.binom(alpha=0.25,w=0.5,logm=logm,two.sample=TRUE)

# detach suite
detach(f2)
}
