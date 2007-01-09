\name{CPPpriorElicit}
\alias{CPPpriorElicit}
\title{Function to Set Hyperparameters of CPP Priors}
\description{
A function to set the hyperparameters of a CPP prior distribution, following the procedure described in La Rocca (2005).
}
\usage{CPPpriorElicit(r0 = 1, H = 1, T00 = 1, M00 = 1, extra = 0)}
\arguments{
  \item{r0}{prior mean hazard rate (\eqn{r_0})}
  \item{H}{corresponding coefficient of variation}
  \item{T00}{time-horizon of interest (\eqn{T_\infty})}
  \item{M00}{number of extremes within the time-horizon in a "typical" hazard rate trajectory (\eqn{M_\infty})}
  \item{extra}{number of additional CPP jumps (compared with default)}
}
\details{
A CPP prior hazard rate is defined, for \eqn{0<t<T_\infty}, by
\deqn{\rho(t)=\xi_0 k_0(t)+\sum_{j=1}^{F} \xi_j k(t-\sigma_j)}
where:
\itemize{
  \item \eqn{\sigma_j} is the time of the \eqn{j}-th jump of a CPP process with gamma distributed jump-sizes
  \item \eqn{\xi_j} is the \eqn{j}-th jump-size of the above process
  \item \eqn{k} is a zero-mean Gaussian density (kernel)
  \item \eqn{F} is a positive integer such that (with high probability) \eqn{\sigma_{F+1}} is much larger than \eqn{T_\infty}
  \item \eqn{\xi_0} is an independent random variable with the same distribution as \eqn{\xi_j}
  \item \eqn{k_0} is a suitable function such that the mean of \eqn{rho(t)} does not depend on \eqn{t}
}
The elicitation procedure makes the mean of \eqn{rho(t)} identically equal to \eqn{r_0}
and its standard deviation approximately equal to \eqn{Hr_0}. An exponential distribution
is selected for the jump-sizes. The kernel bandwidth choice is based on \eqn{M_\infty} (and \eqn{T_\infty}).
}
\value{
A list with nine components:
  \item{r0}{prior mean hazard rate (copy of the input argument)}
  \item{H}{corresponding coefficient of variation (copy of the input argument)}
  \item{T00}{time-horizon of interest (copy of the input argument)}
  \item{M00}{number of extremes within the time-horizon in a "typical" hazard rate trajectory (copy of the input argument)}
  \item{a}{shape parameter of the jump-size distribution (always equal to 1)}
  \item{sd}{standard deviation of the Gaussian kernel (bandwidth)}
  \item{q}{expected number of CPP jumps per time unit}
  \item{b}{rate parameter of the jump-size distribution}
  \item{F}{maximum number of jumps within the time-horizon (with high probability)}
}
\note{As the default value of \code{F} is computed \emph{a priori}, additional jumps may be needed \emph{a posteriori}.}
\references{
Luca La Rocca (2005). On Bayesian Nonparametric Estimation of Smooth Hazard Rates with a View to Seismic Hazard Assessment.
\emph{Research Report n. 38-05}, Department of Social, Cognitive and Quantitative Sciences, Reggio Emilia, Italy.
}
\seealso{\code{\link{BayHaz-package}}, \code{\link{CPPpriorSample}}, \code{\link{CPPpostSample}}}
\examples{
# ten events per century with unit coefficient of variation
# fifty year time horizon with a couple of extremes in a "typical" trajectory
hypars<-CPPpriorElicit(r0 = 0.1, H = 1, T00 = 50, M00 = 2)
}
\keyword{distribution}
\keyword{survival}
\keyword{smooth}
