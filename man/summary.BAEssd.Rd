%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File: summary.BAEssd.Rd
% Package: BAEssd
% Purpose: Documents the summary method for the BAEssd class.
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
\name{summary.BAEssd}
\alias{summary.BAEssd}
\alias{print.summary.BAEssd}

%%% Title
\title{Summarizing BAE Sample Size Calculations}

%%% Description
\description{
  \code{summary} method for class \code{BAEssd}.
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Usage
%   1. How to call the function.
%   2. Parameter description.

%%% Calling the functions.
\usage{
  \method{summary}{BAEssd}(object, ...)
}

%%% Parameters
\arguments{
  \item{object}{
    BAEssd object. Result from a Bayesian Average Error based sample size
    calculation.
  }
  
  \item{...}{
    Additional parameters passed to or from other methods.
  }
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% More Details
%   1. Detailed description of function and parameter explanation.
%   2. Description of the what is returned by the function.

%%% Details
\details{
  Creates a nice printout giving the Average Errors at the chosen sample size.
}
  
%%% Value
\value{
  Vector with 5 elements: 
  \item{n}{Selected sample size.}
  \item{AE1}{Average Bayes Type-I Error rate for the selected sample size.}
  \item{AE2}{Average Bayes Type-II Error rate for the selected sample size.}
  \item{TWE}{Total Weighted Error for the selected sample size.}
  \item{TE}{Total Error for the selected sample size.}
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
\code{\link{ssd}}, \code{\link{summary}}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% R Examples
\examples{
############################################################
# One-sample normal experiment with known variance.

# load suite of functions
f1 <- norm1KV.2sided(sigma=5,theta0=0,prob=0.5,mu=2,tau=1)

# compare results of fast method with general method
attach(f1)
ss1 <- ssd.norm1KV(alpha=0.25,w=0.5,logm=logm)
ss2 <- ssd.norm1KV.2sided(alpha=0.25,w=0.5)
detach(f1)

# look at structure
str(summary(ss1))
}
