#' @title Calculates Reputation as defined by Eisenegger (2005)
#'
#' @description This Package calculates the Reputation of a Subject following the methods developed by Eisenegger (2005). The Input needs to be a dataframe containing texts (eg. Tweets, Articles, etc.), their rating ("positive", "negative", "ambivalent") and optionally a column with numeric values used as weigth (eg. Nr of Retweets, Nr of Recipients, Centrality of Agent, etc.).
#'
#' @param data
#'
#' @param rating
#'
#' @param weigth
#'
#' @return List with the calculated Reputationindex (or Indices)
#'
#' @examples eisenrep(df, rating, centrality)
#'
#' @export

eisenrep <- function(data, rating, weigth) {

  if (missing(weigth)){
    rating <- deparse(substitute(rating))
    RepIndex <- ((sum(data[,rating]=="positiv") - sum(data[,rating]=="negativ"))/(sum(data[,rating]=="positiv") + sum(data[,rating]=="negativ") + sum(data[,rating]=="ambivalent")))*100
    print(paste("The unweighted Reputationindex (following Eisenegger, 2005) is ", RepIndex, ".", sep = ""))
    return(list("RepIndex"=RepIndex))
  }
  else {
    rating <- deparse(substitute(rating))
    weigth <- deparse(substitute(weigth))
    gRepIndex <- ((sum(data[,rating]=="positiv")*sum(data[data[,rating]=="positiv", weigth])) - (sum(data[,rating]=="negativ")*sum(data[data[,rating]=="negativ", weigth])))/(sum(data[,weigth])*(sum(data[,rating]=="positiv") + sum(data[,rating]=="negativ") + sum(data[,rating]=="ambivalent")))*100
    RepIndex <- ((sum(data[,rating]=="positiv") - sum(data[,rating]=="negativ"))/(sum(data[,rating]=="positiv") + sum(data[,rating]=="negativ") + sum(data[,rating]=="ambivalent")))*100
    print(paste("The weighted Reputationindex (following Eisenegger, 2005) is ", gRepIndex, ".", sep = ""))
    print(paste("The unweighted Reputationindex (following Eisenegger, 2005) is ", RepIndex, ".", sep = ""))
    return(list("gRepIndex"=gRepIndex, "RepIndex"=RepIndex))
  }
}
