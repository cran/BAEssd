%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File: plot.BAEssd.Rd
% Package: BAEssd
% Purpose: Documents the plot method for the BAEssd class.
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
\name{plot.BAEssd}
\alias{plot.BAEssd}

%%% Title
\title{Plotting Average Errors}

%%% Description
\description{
  Create plots of various average errors as a function of the sample size
  calculated via the Bayesian Average Error based approach.
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Usage
%   1. How to call the function.
%   2. Parameter description.

%%% Calling the functions.
\usage{
  \method{plot}{BAEssd}(x, y = "TE", alpha.line = TRUE, type = "l", 
    xlab = "Sample Size (n)", ylab = NULL, main = NULL, ...)
}

%%% Parameters
\arguments{
  \item{x}{
    BAEssd object. Result from a Bayesian Average Error based sample size
    calculation.
  }
  
  \item{y}{
    Character string. Indicates what type of error should be plotted on the
    y-axis (default being Total Error). One of "TE","TWE","AE1", or "AE2".
  }
  
  \item{alpha.line}{
    Boolean. If \code{TRUE}, a horizontal line - indicating the bound on Total
    Error used in determining the sample size - is added to the plot. 
  }
  
  \item{type, xlab, ylab, main}{
    Character string. See \code{plot.default()} for more details.
  }
  
  \item{\dots}{
    Additional parameters to be passed to plotting functions.
  }
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% More Details
%   1. Detailed description of function and parameter explanation.
%   2. Description of the what is returned by the function.

%%% Details
\details{
  Each \code{BAEssd} object contains a history of the Average Errors for each
  sample size considered. \code{plot.BAEssd} allows for examination of the
  trend in errors as the sample size changes.
}
  
%%% Value



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
  \code{\link{ssd}}, \code{\link{plot.default}}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% R Examples
\examples{
############################################################
# Construct a plot of the Total Error as a function of
# sample size for a one-sample normal experiment with known
# variance.

# load suite of functions
f1 <- norm1KV.2sided(sigma=5,theta0=0,prob=0.5,mu=2,tau=1)

# get TE for many more sample sizes larger than the optimal
attach(f1)
ss1 <- ssd.norm1KV.2sided(alpha=0.25,w=0.5,minn=2,maxn=200,all=TRUE)
ss1
detach(f1)

# create plot of Total Error
plot(ss1)

# create plot of Average Type-I Error
plot(ss1,y="AE1",alpha.line=FALSE)
abline(h=0.05,lty=2)
}