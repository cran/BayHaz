\name{BayHaz-package}
\alias{BayHaz-package}
\alias{BayHaz}
\docType{package}
\title{R Functions for Bayesian Hazard Rate Estimation}
\description{A suite of R functions for Bayesian estimation of smooth hazard rates via Compound Poisson Process (CPP)
                    and Bayesian Penalized Spline (BPS) priors.}
\details{\tabular{ll}{
Package: \tab BayHaz\cr
Type: \tab Package\cr
Version: \tab 0.1-3\cr
Date: \tab 2007-10-07\cr
License: \tab GPL Version 2 or later\cr}
This package provides UseRs with functions to use CPP prior distributions for Bayesian analysis of times to event;
see La Rocca (2005). It also handles first order autoregressive BPS hazard rates, based on Hennerfeind \emph{et al.} (2006).
Prior elicitation, posterior computation, and visualization are dealt with. For illustrative purposes,
a data set in the field of earthquake statistics is supplied. Package 'coda' is suggested for output diagnostics.}
\author{
Luca La Rocca \url{http://www-dimat.unipv.it/luca}

Mantainer: Luca La Rocca \email{luca.larocca@unimore.it}
}
\references{
La Rocca, L. (2005). On Bayesian Nonparametric Estimation of Smooth Hazard Rates with a View to Seismic Hazard Assessment.
\emph{Research Report} n. 38-05, Department of Social, Cognitive and Quantitative Sciences, Reggio Emilia, Italy.

Hennerfeind, A., Brezger, A. \& Fahrmeir, L. (2006). Geoadditive survival models.
\emph{Journal of the American Statistical Association} 101, 1065--1075.
}
\seealso{\code{\link{CPPpriorElicit}},  \code{\link{CPPpostSample}}, \code{\link{CPPplotHR}},
\code{\link{BPSpriorElicit}},  \code{\link{BPSpostSample}}, \code{\link{BPSplotHR}},
\code{\link{earthquakes}}, \code{\link{CPPpost2mcmc}}, \code{\link{BPSpost2mcmc}}}
\examples{
# the following analysis uses CPP hazard rates but can be easily adapted to BPS hazard rates

# set RNG seed (for example reproducibility only)
set.seed(1234)

# select a CPP prior distribution (with default number of CPP jumps)
hypars<-CPPpriorElicit(r0 = 0.1, H = 1, T00 = 50, M00 = 2, extra = 0)

# plot some sample prior hazard rates
CPPplotHR(CPPpriorSample(ss = 10, hyp = hypars), tu = "Year")

# load a data set
data(earthquakes)

# generate a posterior sample
post<-CPPpostSample(hypars, times = earthquakes$ti, obs = earthquakes$ob)

# check that no additional CPP jumps are needed:
# if this probability is not negligible,
# go back to prior selection stage and increase 'extra'
ecdf(post$sgm[,post$hyp$F])(post$hyp$T00+3*post$hyp$sd)

# plot some posterior hazard rate summaries
CPPplotHR(post , tu = "Year")

# save the posterior sample to file for later use
save(post, file = "post.rda")

# convert the posterior sample into an MCMC object
post<-CPPpost2mcmc(post)

# take advantage of package 'coda' for output diagnostics
pdf("diagnostics.pdf")
traceplot(post)
autocorr.plot(post, lag.max = 5)
par(las = 2) # for better readability of the cross-correlation plot
crosscorr.plot(post)
dev.off()
}
\keyword{package}
\keyword{survival}
\keyword{smooth}
