#' Decide whether a graph is a tree.
#'
#' \code{is_tree} decides whether a graph is a tree, and optionally returns a
#' possible root vertex if the graph is a tree.
#'
#' An undirected graph is a tree if it is connected and has no cycles.
#' In the directed case, a possible additional requirement is that all edges
#' are oriented away from a root (out-tree or arborescence) or all edges are 
#' oriented towards a root (in-tree or anti-arborescence). This test can be
#' controlled using the mode parameter.
#' 
#' By convention, the null graph (i.e. the graph with no vertices) is considered
#' not to be a tree.
#'
#' @param graph An igraph graph object
#' @param mode Whether to consider edge directions in a directed graph.
#'   \sQuote{all} ignores edge directions; \sQuote{out} requires edges to be
#'   oriented outwards from the root, \sQuote{in} requires edges to be oriented
#'   towards the root.
#' @param details Whether to return only whether the graph is a tree (\code{FALSE})
#'   or also a possible root (\code{TRUE})
#' @return When \code{details} is \code{FALSE}, a logical value that indicates
#'   whether the graph is a tree. When \code{details} is \code{TRUE}, a named
#'   list with two entries: \item{res}{Logical value that indicates whether the
#'   graph is a tree.} \item{root}{The root vertex of the tree; undefined if
#'   the graph is not a tree.}
#'
#' @keywords graphs
#' @examples
#'
#' g <- make_tree(7, 2)
#' is_tree(g)
#' is_tree(g, details=TRUE)
#'
#' @export
is_tree <- is_tree

#' Convert a tree graph to its Prufer sequence
#'
#' \code{to_prufer} converts a tree graph into its Prufer sequence.
#'
#' The Prufer sequence of a tree graph with n labeled vertices is a sequence of
#' n-2 numbers, constructed as follows. If the graph has more than two vertices,
#' find a vertex with degree one, remove it from the tree and add the label of
#' the vertex that it was connected to to the sequence. Repeat until there are
#' only two vertices in the remaining graph.
#'
#' @param graph The graph to convert to a Prufer sequence
#' @return The Prufer sequence of the graph, represented as a numeric vector of
#' vertex IDs in the sequence.
#'
#' @seealso \code{\link{make_from_prufer}} to construct a graph from its
#' Prufer sequence
#' @keywords graphs
#' @examples
#'
#' g <- make_tree(13, 3)
#' to_prufer(g)
#'
#' @export
to_prufer <- to_prufer

#' Create an undirected tree graph from its Prufer sequence
#'
#' \code{make_from_prufer} creates an undirected tree graph from its Prufer
#' sequence.
#'
#' The Prufer sequence of a tree graph with n labeled vertices is a sequence of
#' n-2 numbers, constructed as follows. If the graph has more than two vertices,
#' find a vertex with degree one, remove it from the tree and add the label of
#' the vertex that it was connected to to the sequence. Repeat until there are
#' only two vertices in the remaining graph.
#'
#' @param prufer The Prufer sequence to convert into a graph
#' @return A graph object.
#'
#' @seealso \code{\link{to_prufer}} to convert a graph into its Prufer sequence
#' @keywords graphs
#' @examples
#'
#' g <- make_tree(13, 3)
#' to_prufer(g)
#'
#' @export
make_from_prufer <- make_from_prufer

#' @rdname make_from_prufer
#' @param ... Passed to \code{make_from_prufer}
#' @export
from_prufer <- function(...) constructor_spec(make_from_prufer, ...)

#' Sample trees randomly and uniformly
#'
#' \code{sample_tree} generates a random with a given number of nodes uniform
#' at random from the set of labelled trees.
#'
#' In other words, the function generates each possible labelled tree with the
#' given number of nodes with the same probability.
#'
#' @param n The number of nodes in the tree
#' @param directed Whether to create a directed tree. The edges of the tree are
#' oriented away from the root.
#' @param method The algorithm to use to generate the tree. \sQuote{prufer}
#' samples Prufer sequences uniformly and then converts the sampled sequence to
#' a tree. \sQuote{lerw} performs a loop-erased random walk on the complete
#' graph to uniformly sampleits spanning trees. (This is also known as Wilson's
#' algorithm). The default is \sQuote{lerw}. Note that the method based on
#' Prufer sequences does not support directed trees at the moment.
#' @return A graph object.
#'
#' @keywords graphs
#' @examples
#'
#' g <- sample_tree(100, method="lerw")
#'
#' @export
sample_tree <- sample_tree

#' Samples from the spanning trees of a graph randomly and uniformly
#'
#' \code{sample_spanning_tree} picks a spanning tree of an undirected graph
#' randomly and uniformly, using loop-erased random walks.
#'
#' @param graph The input graph to sample from. Edge directions are ignored if
#' the graph is directed.
#' @param vid When the graph is disconnected, this argument specifies how to
#' handle the situation. When the argument is zero (the default), the sampling
#' will be performed component-wise, and the result will be a spanning forest.
#' When the argument contains a vertex ID, only the component containing the
#' given vertex will be processed, and the result will be a spanning tree of the
#' component of the graph.
#' @return An edge sequence containing the edges of the spanning tree. Use
#' \code{\link{subgraph.edges}} to extract the corresponding subgraph.
#'
#' @keywords graph
#' @seealso \code{\link{subgraph.edges}} to extract the tree itself
#' @examples
#'
#' g <- make_full_graph(10) %du% make_full_graph(5)
#' edges <- sample_spanning_tree(g)
#' forest <- subgraph.edges(g, edges)
#'
#' @export
sample_spanning_tree <- sample_spanning_tree