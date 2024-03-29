% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_fiber_type.R
\name{plot_fiber_type}
\alias{plot_fiber_type}
\title{Plot fiber area by fiber type and group}
\usage{
plot_fiber_type(
  x,
  response,
  conf,
  stats,
  muscle = "MG",
  sex = "Female",
  age = "6M",
  ymin,
  ymax
)
}
\arguments{
\item{x}{a \code{data.frame} with columns \code{"response"}, \code{"type"},
\code{"group"}, \code{"muscle"}, \code{"age"}, \code{"sex"}, and the column
given by \code{response}.}

\item{response}{character; name of a column in \code{x}. Used to plot
individual data points.}

\item{conf}{a \code{data.frame} with columns "muscle", "age", "sex", "group",
"response_mean", "lower.CL", and "upper.CL".}

\item{stats}{\code{data.frame} with columns "muscle", "type", "age", "sex",
"contrast", "type", "p.value", and "signif".}

\item{muscle}{character; skeletal muscle to plot. Either "LG", "MG", "PL", or
"SOL" (lateral gastrocnemius, medial gastrocnemius, plantaris, or soleus).}

\item{sex}{character; sex of rats to plot. Either "Female" or "Male".}

\item{age}{character; age of rats to plot. Either "6M" or "18M".}

\item{ymin}{numeric; lower y-axis limit.}

\item{ymax}{numeric; upper y-axis limit.}
}
\description{
Plot fiber area by fiber type and group
}
