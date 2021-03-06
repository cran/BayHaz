\name{BPSpostSample}
\alias{BPSpostSample}
\title{Function to Sample Hazard Rates from BPS Posteriors}
\description{A function to generate a random sample of hazard rates from the posterior distribution originated by a
first order autoregressive BPS prior through the observation of a sequence of possibly right censored times to event.}
\usage{BPSpostSample(hyp, times, obs = NULL, mclen = 10, burnin = 0, thin = 1, df = 10, etastar = NULL)}
\arguments{
  \item{hyp}{list of hyperparameters (as generated by \code{\link{BPSpriorElicit}})}
  \item{times}{vector of (possibly right censored) times to event}
  \item{obs}{vector of censoring indicators (0 = censored, 1 = exact)}
  \item{mclen}{requested sample size}
  \item{burnin}{burn-in parameter}
  \item{thin}{thinning parameter}
  \item{df}{degrees of freedom for the multivariate Student-t proposal distribution}
  \item{etastar}{posterior mode and corresponding hessian in list format (as generated by \code{\link{optim}} with \code{hessian = TRUE})}
}
\details{A Markov chain sample of length \code{mclen} from the posterior distribution
originated by \code{hyp} through the observation of \code{times} and \code{obs} is generated
using a taylored proposal density Metropolis-Hastings sampler (starting at the posterior mode);
see Chib \& Greenberg (1995).

The first \code{burnin} states of the Markov chain are discarded, then one every \code{thin} is kept.

If \code{obs} is \code{NULL}, it is assumed that all observations are exact (no censoring).
}
\value{A list with seven components:
  \item{hyp}{list of hyperparameters identifying the BPS prior that originated the posterior distribution
                    from which the sample was extracted (copy of the input argument)}
  \item{dat}{dataframe with two variables (\code{times} and \code{obs}) containing the observations
                   on which the posterior distribution is based}
  \item{burnin}{burn-in parameter used (copy of the input argument)}
  \item{thin}{thinning parameter used (copy of the input argument)}
  \item{df}{degrees of freedom used for the multivariate Student-t proposal distribution (copy of the input argument)}
  \item{etastar}{posterior mode and corresponding hessian in list format (copy of the input argument
                         or computed via \code{\link{optim}} if the input argument was NULL)}
  \item{eta}{matrix with \code{mclen} rows (and \code{length(hyp$knots)-hyp$ord} columns) containing the spline weights}
}
\note{If \code{mclen} is equal to zero \code{eta} will be a chain of length one containing the posterior mode.}
\references{
Chib, S. \& E. Greenberg (1995). Understanding the Metropolis-Hastings algorithm.
\emph{American Statistician} 49, 327--335.
}
\seealso{\code{\link{BayHaz-package}}, \code{\link{BPSevalHR}}, \code{\link{BPSplotHR}}, \code{\link{BPSpost2mcmc}}}
\examples{
# set RNG seed (for example reproducibility only)
set.seed(1234)

# select a BPS prior distribution
hypars<-BPSpriorElicit(r0 = 0.1, H = 1, T00 = 50, ord = 4, G = 3, c = 0.9)
# load a data set
data(earthquakes)

# find the posterior mode
postmode<-BPSpostSample(hypars, times = earthquakes$ti, obs = earthquakes$ob, mclen = 0)
# evaluate the posterior mode hazard rate at year multiples
BPSevalHR(time = seq(0,50), sample = postmode)

# generate a posterior sample
post<-BPSpostSample(hypars, times = earthquakes$ti, obs = earthquakes$ob, etastar = postmode$etastar)
# plot some posterior hazard rate summaries
BPSplotHR(post, tu = "Year")
}
\keyword{distribution}
\keyword{survival}
\keyword{smooth}
