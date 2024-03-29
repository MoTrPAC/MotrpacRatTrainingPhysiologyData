% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_pre_post.R
\name{plot_pre_post}
\alias{plot_pre_post}
\title{Plot pre and post-training values}
\usage{
plot_pre_post(x, pre, post, stats = NULL, ymin, ymax)
}
\arguments{
\item{x}{\code{data.frame} with pre and post values. The data should be
filtered to a specific age and sex.}

\item{pre}{character; name of a column in \code{x} containing pre-training
values.}

\item{post}{character; name of a column in \code{x} containing post-training
values.}

\item{stats}{\code{data.frame} with post - pre stats for each training group.
The data should be filtered to a specific measure, age, and sex.}

\item{ymin}{numeric; lower bound on y-axis.}

\item{ymax}{numeric; lower bound on y-axis.}
}
\value{
A \code{ggplot} object.
}
\description{
Create a \code{ggplot2} object with a line for each sample that
spans from its pre-training to post-training value.
}
\details{
Lines are colored according to whether the change from pre to post
is an increase (red) or decrease (blue). If the pre and post values are the
same (no change), a black point is used instead of a line. Originally, the
post end of each line terminated in an arrow, but the final figure panels
were too small to display them properly. Also, the arrows were somewhat
misleading when the post - pre differences were small enough to be hidden
by the arrow heads.
}
