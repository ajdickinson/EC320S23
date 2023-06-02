#' ---
#' title: "PS05"
#' subtitle: "Total points: 25"
#' author: "Your name here"
#' date: "Due: 2023-06-09 11:59 PST"
#' ---
#' ## __README__
#'
#' Complete the following questions below and show all work. You must submit a compiled `R` report with all code and answers in this document. Compile the report to html or PDF and submit on Canvas. html is preferred. Make sure to write your name above where it says "WRITE YOUR NAME HERE". Include it within the quotation marks.
#' 
#' Before writing answering the following questions, make sure to compile the report to make sure that everything is working properly. As you answer each question, compile after each question to make sure you are not making any errors. If you are experiencing an error, read the error carefully. One tactic is to selectively delete questions/sections until the report compiles. This will help you narrow down where the coding error is occuring.
#' 
#'
#' #### __Data__
#'
#' The data used in this problem set contains information on a random sample of 36,051 births in the United States. Birth weight is commonly used as an indicator of infant health since it is very easily measured and widely reported. Also in the data are indicators for mother's and father's race, marital status, whether the mother smoked or drank alcohol during pregnancy and total gestation time of each pregnancy in weeks. See the codebook at the bottom for a description of each variable.
#'
#' #### __Integrity__
#'
#' If you are suspected of cheating, you will receive a zero—for the assignment and possibly for the course. Cheating includes copying work from your classmates, from the internet, and from previous problem sets. You are encouraged to work with your peers, but everyone must submit their own solutions.
#'
#' ## __Setup__
#'
#' __Q01:__ Load the required packages `tidyverse` and `broom` _(1 points)_
#' 
# Uncomment and write solution here
#'
#' 
#' __Q02:__ Load data with the following code:
#' 
# Read in data from GitHub
#+ warning=FALSE, message=FALSE
natal_df = readr::read_csv(
  "https://raw.githubusercontent.com/ajdickinson/EC320S23/main/problem-sets/ps05/natality.csv"
)
#'
#' _(1 points)_
#'
#' __Q03:__ Sometimes data isn't clean. Drop the unnecessary variable to clean up the data. There is only one, and it should be obvious which one I am referring to.
# Uncomment and write solution here

#' 
#'
#' ## Get to know your data
#'
#' - Print the first 10 observations in the data set. _(1 points)_
# Uncomment and write solution here
#'
#' - What are the dimensions of the data? How many cols/rows? _(1 points)_
# Uncomment and write solution here
#'
#'
#' __Q04:__ Read the _Codebook_ attached at the bottom. Which variable is an indicator for whether the mother is a smoker? _(1 points)_
#' 
#' 
#' 
#' __Q05:__ Create a density plot (`geom_density()`) showing the distribution of birth weights (`birth_wt`). Use the with `cigs` variable as the `fill` aesthetic. Label your plot axis and try to make it look presentable. _(2 points)_
#' 
#+ fig.height = 5, message = FALSE, warning = FALSE, fig.align = "center"
# Uncomment and write solution here

#' 
#' __Q06:__ How does smoking cigarettes _seem_ to shift the distribution of birth weights? _(1 points)_
#'
#' 
#' ## Categorical variables
#' 
#' __Q07:__ Suppose I am interested in the relationship between gestation length and birth weight. Create a scatter plot comparing birth weight to gestation length (That is `birth_wt` on the y-axis and `gestation` on the x-axis). Fit a regression line using `geom_smooth()`. As before, label your plot axis and try to make it look presentable. _(2 points)_
#' 
#' _Hint: Since `gestation` is discrete, it is difficult to see that the number of data points at `gestation == 40` is much higher than `gestation == 30`. This matters a lot when minimizing __RSS__. One way to make it easier to see is to use the `alpha` argument within `geom_point`. `alpha` is a number between `0` and `1` that determines the opacity of the points. Setting `alpha` to a small value may help you see all the data_
#' 
#' 
#+ fig.height = 5, message = FALSE, warning = FALSE, fig.align = "center"
# Uncomment and write solution here
#'
#'
#' __Q08:__ Comment on whether the above relationship between birth weight and gestation length appears to be linear or not. _(1 points)_
#' 
#' 
#' 
#' __Q09:__  Create a new scatter plot comparing logged birth weight to gestation length (That is `log(birth_wt)` on the y-axis and `gestation` on the x-axis). As before, include a `geom_smooth` line, fitting an OLS regression over the data. _(1 points)_
#+ fig.height = 5, message = FALSE, warning = FALSE, fig.align = "center"
# Uncomment and write solution here

#'
#' __Q10:__ Do you think the new fitted line does a better job of fitting the transformed data? Explain. There is not necessarily a correct answer. _(1 points)_
#'  
#'  
#'
#' __Q11:__ Regress `log(birth_wt)` on `gestation` and `cigs`. Report the results _(2 points)_
#' 
# Uncomment and write solution here

#'
#'  __Q12:__ What is the interpretation of the coefficients (including the intercept)? Are the point estimates of `gestation` and `cigs` statistically significant at the 5 percent level? _(2 points)_
#'  
#'  
#'  
#'  __Q13:__ Now regress `log(birth_wt)` on `gestation`, `cigs`, and (all) the indicator variables for the mother's race. Report your results. _(2 points)_
#'  
# Uncomment and write solution here

#'
#' 
#' __Q14:__ What is the interpretation of the coefficient of `mrace_black`? Who is the reference group? What is interpretation of the intercept? _(3 points)_
#' 
#' 
#' 
#' ## Quadratic variables
#' 
#' __Q15:__ Suppose we have reason to believe that marginal change in `gestation` on `birth_wt` is not constant, but decreases after a certain point. Regress `birth_wt` on `gestation` and `gestation_sq`.  _(2 points)_
#' 
#' Note: You will have to generate `gestation_sq` yourself. Call the variable however you like.
#' 
# Uncomment and write solution here

#' 
#' __Q16:__ Calculate the marginal effect of `gestation` on `birth_wt` when the average gestation length is 20 weeks and when the average gestation length is 40 weeks. Interpret both of these marginal effects. _(2 points)_
#' 
#' 
#' ### Codebook
#' 
#' 
#' | Variable              | Description                                                                                     |
#' |-----------------------|-------------------------------------------------------------------------------------------------|
#' | birth_wt              | Weight of the baby at birth (in grams)                                                          |
#' | cigs                  | Whether the mother smoked cigarettes during pregnancy (logical: TRUE or FALSE)                  |
#' | alcohol               | Whether the mother consumed alcohol during pregnancy (logical: TRUE or FALSE)                   |
#' | marital_status        | Marital status of the mother (1 if married, 0 if not married)                                   |
#' | mother_age            | Age of the mother                                                                               |
#' | gestation             | Length of the pregnancy (in weeks)                                                              |
#' | mrace_asian           | Whether the mother is of Asian race (1 if yes, 0 if no)                                         |
#' | mrace_black           | Whether the mother is of Black race (1 if yes, 0 if no)                                         |
#' | mrace_hawaiian        | Whether the mother is of Hawaiian race (1 if yes, 0 if no)                                      |
#' | mrace_native_american | Whether the mother is of Native American race (1 if yes, 0 if no)                               |
#' | mrace_white           | Whether the mother is of White race (1 if yes, 0 if no)                                         |
#' | frace_asian           | Whether the father is of Asian race (1 if yes, 0 if no)                                         |
#' | frace_black           | Whether the father is of Black race (1 if yes, 0 if no)                                         |
#' | frace_hawaiian        | Whether the father is of Hawaiian race (1 if yes, 0 if no)                                      |
#' | frace_native_american | Whether the father is of Native American race (1 if yes, 0 if no)                               |
#' | frace_white           | Whether the father is of White race (1 if yes, 0 if no)                                         |
#' 
#' 
#' 
#' 
#' 
#' 

