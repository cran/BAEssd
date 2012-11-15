%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File: GammaGamma.Rd
% Package: BAEssd
% Purpose: Documents functions related to the Gamma-Gamma distribution.
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
\name{GammaGamma}
\alias{GammaGamma}
\alias{dggamma}
\alias{rggamma}

%%% Title
\title{The Gamma-Gamma Distribution}

%%% Description
\description{
  Density and random generation for the Gamma-Gamma distribution with parameters
  \code{shape1}, \code{rate1}, and \code{shape2}.
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Usage
%   1. How to call the function.
%   2. Parameter description.

%%% Calling the functions.
\usage{
  dggamma(x, shape1, rate1, shape2)
  rggamma(n, shape1, rate1, shape2)
}

%%% Parameters
\arguments{
  \item{x}{
    Vector. Quantiles.
  }
  
  \item{n}{
    Scalar. Number of random variates to generate (sample size).
  }
  
  \item{shape1, rate1}{
    Vector. Shape and rate parameters for y-distribution. Must be strictly
    positive.
  }
  
  \item{shape2}{
    Vector. Shape parameter for conditional x-distribution. Must be a
    positive integer.
  }
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% More Details
%   1. Detailed description of function and parameter explanation.
%   2. Description of the what is returned by the function.

%%% Details
\details{
  A Gamma-Gamma distribution with parameters \code{shape1 = a}, \code{rate1 = r} 
  and \code{shape2 = b} has density
  
    \deqn{f(x) = \frac{r^a}{\Gamma{(a)}}\frac{\Gamma{(a+b)}}{\Gamma{(b)}}
                 \frac{x^{b-1}}{(r+x)^(a+b)}}{%
          f(x) = [(r^a)/(Gamma(a))][Gamma(a+b)/Gamma(b)]
                 [x^(b-1)/(r+x)^(a+b)]}
       
  for \eqn{x > 0} where \eqn{a,r > 0} and \eqn{b = 1,2,\ldots}.
  
  The distribution is generated using the following scheme:
    \enumerate{
      \item Generate Y ~ Gamma(shape=\code{shape1},rate=\code{rate1}).
      \item Generate X ~ Gamma(shape=\code{shape2},rate=Y).
    }
    
  Then, X follows a Gamma-Gamma distribution.
}
  
%%% Value
\value{
  \code{dggamma} gives the density, and \code{rggamma} gives random variates.
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% References
%   1. References to outside literature.
%   2. Author name.

%%% References
\references{
  Bernardo JM, Smith AFM. (1994) \emph{Bayesian Theory}. Wiley, New York. 
}

%%% Author


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Additional Notes
%   1. Notes.
%   2. Other functions one should reference.

%%% See also
\seealso{
\code{\link{dgamma}}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% R Examples
\examples{
############################################################
# Construct a plot of the density function with median and
# quantiles marked.

# define parameters
shape1 <- 4
rate1 <- 4
shape2 <- 20

# construct density plot
x <- seq(0.1,150,0.1)
plot(dggamma(x,shape1,rate1,shape2)~x,
     type="l",lwd=2,main="",xlab="x",ylab="Density f(x)")
     
# determine median and quantiles
set.seed(123)
X <- rggamma(5000,shape1,rate1,shape2)
quants <- quantile(X,prob=c(0.25,0.5,0.75))

# add quantities to plot
abline(v=quants,lty=c(3,2,3),lwd=2)


############################################################
# Consider the following set-up:
#   Let x ~ N(theta,sigma2), sigma2 is unknown variance.
#   Consider a prior on theta and sigma2 defined by
#      theta|sigma2 ~ N(mu,(r*sigma)^2)
#      sigma2 ~ InverseGamma(a/2,b/2), (b/2) = rate.
#
#   We want to generate random variables from the marginal
#   (prior predictive) distribution of the sufficient
#   statistic T = (xbar,s2) where the sample size n = 25.

# define parameters
a <- 4
b <- 4
mu <- 1 
r <- 3
n <- 25


# generate random variables from Gamma-Gamma
set.seed(123)
shape1 <- a/2
rate1 <- b
shape2 <- 0.5*(n-1)

Y <- rggamma(5000,shape1,rate1,shape2)

# generate variables from a non-central t given Y
df <- n+a-1
scale <- (Y+b)*(1/n + r^2)/(n+a-1)

X <- rt(5000,df=df)*sqrt(scale) + mu

# the pair (X,Y) comes from the correct marginal density

# mean of xbar and s2, and xbar*s2
mean(X)
mean(Y)
mean(X*Y)
}
