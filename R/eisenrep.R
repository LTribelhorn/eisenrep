#' @title Calculates Reputation as defined by Eisenegger (2005)
#'
#' @description This Package calculates the Reputation of a Subject following the methods developed by Eisenegger (2005). The Input needs to be a dataframe containing texts (eg. Tweets, Articles, etc.), their rating ("positiv", "negativ", "ambivalent", "neutral") and optionally a column with numeric values used as weigth-factor (eg. Nr of Retweets, Nr of Recipients, Centrality of Agent, etc.).
#'
#' @param data
#'
#' @param rating
#'
#' @param weigth
#'
#' @return Dataframe with the calculated Reputationindex (or Indices)
#'
#' @examples eisenrep(df, rating, centrality)
#'
#' @export

eisenrep <- function(data, rating, weigth) {

  if(nrow(data) > 1){
    if (missing(weigth)){
      rating <- deparse(substitute(rating))
      if((sum(data[,rating]=="positiv") + sum(data[,rating]=="negativ") +
          sum(data[,rating]=="neutral") +  sum(data[,rating]=="ambivalent")) == 0){
        RepIndex <- NA
        print(paste("The unweighted Reputationindex (following Eisenegger, 2005) can't be calculated because the denominator is 0.", sep = ""))
      } else {
        RepIndex <- ((sum(data[,rating]=="positiv") - sum(data[,rating]=="negativ"))/(sum(data[,rating]=="positiv") + sum(data[,rating]=="negativ")+ sum(data[,rating]=="neutral") + sum(data[,rating]=="ambivalent")))*100
        print(paste("The unweighted Reputationindex (following Eisenegger, 2005) is ", RepIndex, ".", sep = ""))
      }
      return(data.frame("RepIndex"=RepIndex))
    }
    else {
      rating <- deparse(substitute(rating))
      weigth <- deparse(substitute(weigth))
      if((sum(data[,weigth])*(sum(data[,rating]=="positiv") +
                              sum(data[,rating]=="negativ")+
                              sum(data[,rating]=="neutral") +
                              sum(data[,rating]=="ambivalent"))) == 0){
        gRepIndex <- NA
        print(paste("The weighted Reputationindex (following Eisenegger, 2005) can't be calculated because the denominator is 0.", sep = ""))
      } else {
        gRepIndex <- ((sum(data[,rating]=="positiv")*sum(data[data[,rating]=="positiv", weigth])) - (sum(data[,rating]=="negativ")*sum(data[data[,rating]=="negativ", weigth])))/(sum(data[,weigth])*(sum(data[,rating]=="positiv") + sum(data[,rating]=="negativ")+ sum(data[,rating]=="neutral") + sum(data[,rating]=="ambivalent")))*100
        print(paste("The weighted Reputationindex (following Eisenegger, 2005) is ", gRepIndex, ".", sep = ""))
      }

      if((sum(data[,rating]=="positiv") + sum(data[,rating]=="negativ") +
          sum(data[,rating]=="neutral") +  sum(data[,rating]=="ambivalent")) == 0){
        RepIndex <- NA
        print(paste("The unweighted Reputationindex (following Eisenegger, 2005) can't be calculated because the denominator is 0.", sep = ""))
      } else {
        RepIndex <- ((sum(data[,rating]=="positiv") - sum(data[,rating]=="negativ"))/(sum(data[,rating]=="positiv") + sum(data[,rating]=="negativ")+ sum(data[,rating]=="neutral") + sum(data[,rating]=="ambivalent")))*100
        print(paste("The unweighted Reputationindex (following Eisenegger, 2005) is ", RepIndex, ".", sep = ""))
      }

      return(data.frame("gRepIndex"=gRepIndex, "RepIndex"=RepIndex))
    }
  } else{
    if (missing(weigth)){
      return(data.frame("RepIndex"=NA))
    } else{
      return(data.frame("gRepIndex"=NA, "RepIndex"=NA))
    }
  }
}
