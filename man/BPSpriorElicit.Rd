\name{BPSpriorElicit}
\alias{BPSpriorElicit}
\title{Function to Set Hyperparameters of BPS Priors}
\description{
A function to set the hyperparameters of a first order autoregressive BPS prior distribution,
approximately assigning constant prior mean hazard rate and corresponding coefficient of variation.
}
\usage{BPSpriorElicit(r0 = 1, H = 1, T00 = 1, ord = 4, G = 30, c = 0.9)}
\arguments{
  \item{r0}{prior mean hazard rate (\eqn{r_0})}
  \item{H}{corresponding coefficient of variation}
  \item{T00}{time-horizon of interest (\eqn{T_\infty})}
  \item{ord}{spline order (\eqn{k})}
  \item{G}{number of internal spline knots}
  \item{c}{correlation coefficient between two consecutive spline weights}
  }
\details{
A first order autoregressive BPS prior hazard rate is defined, for \eqn{0<t<T_\infty}, by
\deqn{\rho(t)=\exp\{\sum_{j=1}^{G+k-2} \eta_j B_j(t)\}}
where:
\itemize{
  \item \eqn{\eta_j} is the \eqn{j}-th element of a normally distributed vector of spline weights (see below for details)
  \item \eqn{B_j(t)} is the \eqn{j}-th B-spline basis function of order \eqn{k}, evaluated at \eqn{t},
             defined on a grid of \eqn{G+2k-2} equispaced knots with first internal knot at \eqn{0}
			 and last internal knot at \eqn{T_\infty} (see \code{\link{splineDesign}} for details)
}

The spline weights form a stationary AR(1) process with mean \eqn{m}, variance \eqn{w} and lag-one autocorrelation \eqn{c}.
The elicitation procedure takes \eqn{w = H^2} and \eqn{m = \log r_0 - 0.5 * w}, based on the mean and variance formulas
for the log-normal distribution. As B-spline basis functions form a partition of unity within internal nodes,
the mean of \eqn{\rho(t)} is approximately equal to \eqn{r0}, for \eqn{0<t<T_\infty}, and its standard deviation to \eqn{Hr_0}.
}
\value{
A list with nine components:
  \item{r0}{prior mean hazard rate (copy of the input argument)}
  \item{H}{corresponding coefficient of variation (copy of the input argument)}
  \item{T00}{time-horizon of interest (copy of the input argument)}
  \item{ord}{spline order (copy of the input argument)}
  \item{G}{number of internal spline knots (copy of the input argument)}
  \item{c}{correlation coefficient between two consecutive spline weights (copy of the input argument)}
  \item{knots}{full grid of spline knots}
  \item{m}{mean of spline coefficients}
  \item{w}{variance of spline coefficients}
}
\seealso{\code{\link{BayHaz-package}}, \code{\link{BPSpriorSample}}, \code{\link{BPSpostSample}}}
\examples{
# ten events per century with unit coefficient of variation and fifty year time horizon
# cubic splines with minimal number of knots and strongly correlated spline weights
hypars<-BPSpriorElicit(r0 = 0.1, H = 1, T00 = 50, ord = 4, G = 3, c = 0.9)
}
\keyword{distribution}
\keyword{survival}
\keyword{smooth}
