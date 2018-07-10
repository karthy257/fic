% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fic.lm.R
\name{fic.lm}
\alias{fic.lm}
\title{Focused Information Criterion for linear models}
\usage{
\method{fic}{lm}(wide, inds, inds0 = NULL, gamma0 = 0, focus = NULL,
  focus_deriv = NULL, X = NULL, Xwt = NULL, sub = NULL, B = 0,
  loss = loss_mse, ...)
}
\arguments{
\item{wide}{Fitted model object containing the wide model.}

\item{inds}{matrix or vector of indicators for which parameters are included in the submodel or submodels to be assessed.

A matrix should be supplied if multiple submodels are to be assessed.  This should have number of rows equal to the number of submodels to be assessed, and number of columns equal to the total number of parameters in the wide model.  It contains 1s in the positions where the parameter is included in the submodel, and 0s in positions where the parameter is excluded.  This should always be 1 in the positions defining the narrow model, as specified in `inds0`.}

\item{inds0}{Vector of indicators specifying the narrow model, in the same format as \code{inds}.  If this is omitted, the narrow model is assumed to be defined by the first row of \code{inds} (if \code{inds} is a matrix), or \code{inds} itself if this is a vector.}

\item{gamma0}{Vector of special values taken by the parameters \eqn{gamma} which define the narrow model.

This defaults to 0, as in covariate selection, where excluded coefficients are fixed to 0. 

This should either be a scalar, assumed to be the same for all parameters fixed in the narrow model, or a vector of length equal to the number of parameters from the wide model which are fixed in the narrow model, that is, the number of entries of inds0 which are zero.}

\item{focus}{An R function with:

\itemize{
\item first argument named \code{par}, denoting a vector of parameters

\item an optional second argument named \code{X}, typically denoting covariate values.  The required format is documented below. 
}

The function should return the focus quantity of interest.  If \code{X} is supplied and has multiple rows, then \code{focus} should return a vector giving the focus for each row of \code{X}.  Otherwise \code{focus} should return a scalar giving the focus value at \code{par}.

Not required if \code{focus_deriv} is specified.

Alternatively, \code{focus} can be a character string naming a built-in focus function supplied by the \pkg{fic} package.  See \code{\link{focus_fns}}.}

\item{focus_deriv}{Vector of partial derivatives of the focus function with respect to the parameters in the wide model.  This is not usually needed, as it can generally be computed automatically and accurately from the function supplied in \code{focus}, using numerical differentiation.}

\item{X}{Second argument of the focus function, typically giving covariate values defining the focus. This can either be a matrix or a vector.

This is optional.  If not supplied, \code{focus} should return a scalar giving the focus value at parameters \code{par}.

To compute focused model comparison statistics for the same focus function evaluated at multiple covariate values, \code{X} should be a matrix, with number of columns equal to the number of parameters in the wide model, and number of rows equal to the number of alternative covariate values.

For a typical regression model, the first parameter will denote an intercept, so the first value of \code{X} should be 1, and the remaining values should correspond to covariates whose coefficients form parameters of the wide model.  See the examples in the vignette.

If just one covariate value is needed, then \code{X} can be a vector of length equal to the number of parameters in the wide model.}

\item{Xwt}{Vector of weights to apply to different covariate values in X.  This should have length equal to the number of alternative values for covariate The averaged FIC is then calculated for a population defined by this distribution of covariate values.   If this argument is omitted, the values are assumed to have equal weight.}

\item{sub}{List of fitted model objects for each submodel to be assessed.  This is optional, and only required if you want the estimate of the focus function under each submodel to be included in the results.}

\item{B}{If B is 0 (the default) the standard analytic formula for the FIC is used with mean square error loss.   If B>0, then the parametric bootstrap method is used with B bootstrap samples.  (TODO ref to other doc)}

\item{loss}{A function returning an estimated loss for a submodel estimate under the sampling distribution of the wide model.  Only applicable when using bootstrapping.  This should have two arguments `sub` and `wide`.  `sub` should be a scalar giving the focus estimate from a submodel.  `wide` should be a vector with a sample of focus estimates from the wide model, e.g. generated by a bootstrap method.  By default this is a function calculating the root mean square error of the submodel estimate.}

\item{...}{Other arguments to the focus function can be supplied here.  Currently no examples of this.}
}
\description{
Focused information criterion for linear models fitted with lm().
This can be used, for example, to compare models with different covariates.  TODO put mtcars in rd example
}