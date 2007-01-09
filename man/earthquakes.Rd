\name{earthquakes}
\alias{earthquakes}
\docType{data}
\title{Waiting Times between Strong Earthquakes in the Appennino Abruzzese}
\description{This data set gives the waiting times (in years) between earthquakes with moment maginitude
greater than 5.1, in the Italian seismogenic zone 923, from year 1650 to year 2002, as obtained by La Rocca (2005)
based on the catalogue by Gruppo di Lavoro CPTI (2004).
}
\usage{data(earthquakes)}
\format{
  A data frame with 47 observations on the following 2 variables:
  \describe{
    \item{\code{ti}}{earthquake inter-event times (years)}
    \item{\code{ob}}{censoring indicators (0 = right censored, 1 = exact)}
  }
}
\note{All observations are exact, except for the last one (a characteristic of this kind of data).}
\source{
Gruppo di Lavoro CPTI (2004). Catalogo Parametrico dei Terremoti Italiani, versione 2004 (CPTI04).
INGV, Bologna, \url{http://emidius.mi.ingv.it/CPTI}. In Italian. 
}
\references{
Luca La Rocca (2005). On Bayesian Nonparametric Estimation of Smooth Hazard Rates with a View to Seismic Hazard Assessment.
\emph{Research Report n. 38-05}, Department of Social, Cognitive and Quantitative Sciences, Reggio Emilia, Italy.
}
\seealso{\code{\link{BayHaz-package}}}
\examples{
# load data set
data(earthquakes)

# show data set structure
str(earthquakes)
}
\keyword{datasets}
