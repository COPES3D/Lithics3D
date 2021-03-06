% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/geom_poly_angles.R
\name{poly_angles}
\alias{poly_angles}
\title{Interior polygon angles}
\usage{
poly_angles(coords)
}
\arguments{
\item{coords}{An Nx2 matrix-like object containing ordered xy point
coordinates of the polygon vertices, one per row. First and last coordinates
must match.}
}
\value{
a vector of interior angles (in degrees) at each input vertex (in
input order). Note that if the majority of angles are negative, the polygon
was drawn counter-clockwise; if the majority are positive, the polygon was
drawn clockwise.
}
\description{
Calculates interior angles at each vertex of a
non-self-intersecting polygon, in input order. Useful, for instance, in
determining the angles of a mesh cross-section.
}
\note{
Will trigger an error with self-intersecting or degenerate polygons.
}
\examples{
p <- data.frame(x=c(1,4,3,4,1,1), y=c(1,1,2,3,3,1))
plot(p, type="l", asp=1)
p.a <- poly_angles(p)
text(p$x, p$y, labels=p.a[1:(nrow(p) - 1)], pos=3) # Show angles
text(p$x, p$y, labels=rownames(p)[1:(nrow(p) - 1)], pos=1) # Show vertex ID
}
\author{
Cornel M. Pop
}
