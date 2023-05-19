#' ---
#' title: "PS04"
#' author: "YOUR NAME HERE"
#' date: "Due: 2023-05-23 11:59 PST"
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
#' The data from this problem set are a sample of district level data from the state of Massachusetts in 1998. It can be loaded into memory through installing the `AER` package from CRAN (i.e., `install.packages("AER")`).
#'
#' The Massachusetts data are district-wide averages for public elementary school districts in 1998. The data analyzed here are the overall total score, which is the sum of the scores on the English, Math, and Science portions of the test. Data on the student-teacher ratio, the percent of students receiving a subsidized lunch and on the percent of students still learning english are averages for each elementary school district for the 1997–1998 school year and were obtained from the Massachusetts department of education. Data on average district income are from the 1990 US Census.
#'
#'
#' #### __Integrity__
#'
#' If you are suspected of cheating, you will receive a zero—for the assignment and possibly for the course. Cheating includes copying work from your classmates, from the internet, and from previous problem sets. You are encouraged to work with your peers, but everyone must submit their own solutions.
#'
#' ## __Setup__
#'
#' __Q01:__ Load the required packages `tidyverse`, `broom`, and `AER`
#'
#' 
#' __Q02:__ Load data with the following code `data("MASchools")`. Now an object named `MASchools` should be loaded into your R environment. _Feel free to rename the object if you wish._
#'
#'
#' - Print the first 10 observations in the dataset by using the function `head()`. Hint: Type `?head()` in the console.
# Write code here after un-commenting
#'
#' __Q03:__ Read the documentation of the data by typing `?MASchools`. Describe in words what the following variables mean:
#'
#' - `district`
#' - `municipality`
#' - `stratio`
#' - `score4`
#' - `expereg`
#' - `income`
#'
#'
#' ## __Getting to know your data__
#'
#' __Q04:__ The following functions help users look the data printed on the screen:
#'
#' - `str`
#' - `glimpse`
#' - `View()` 
#'
#' Use one or all of these functions to solution the following. 
#'
#' - What observation level is the data at? 
#' - What type of data is this (recall data types from the review lecture).
#'
#' __Q05:__ Use `dplyr` functions to find the answer the following questions about the data. 
#'
#' - How many different school districts/municipalities are there?
# Write code here after un-commenting
#'
#' - Which municipality spends the most money on each child? 
# Write code here after un-commenting
#'
#' - Of the non-missing data, what is the average 4th grade test score? Hint: Read about the argument `na.rm` in the help file for the `mean` function
# Write code here after un-commenting
#'
#'
#'
#' __Q06:__ Plot the histogram of test scores for 4th graders. Make it look nice by adding a title and labels to your axis. Maybe try to give it some color. If you would like, install the `ggthemes` package (`install.packages("ggthemes")`) and read the documentation. It has a ton of themes choices that will style your plot.
#+ fig.width=5, fig.height=5 
# Write code here after un-commenting
#'
#' ## __Inference__
#'
#' __Q07:__ Suppose we are interested in the relationship between 4th grade test scores and class room size. We specify the following model:
#'
#' $$
#' \text{Scores}_i = \beta_0 + \beta_1 \text{Class Size}_i + u_i
#' $$
#'
#' Before running any regressions,
#'
#' - Write down a two tailed hypothesis test for $\beta_1$
#' 
#' - Briefly describe the intuition behind the argument of a hypothesis test.
#'
#' __Q08:__ It is always important to plot your data. Make a scatter plot of the variables in this regression. Like before, try to make it look presentable.
#+ fig.width=5, fig.height=5 
# Write code here after un-commenting
#'
#' __Q09:__ Run the above regression in `R` using the `lm` command. Before doing so, read the help file for the `tidy()` and `glance()` functions from the `broom` package. 
#' 
#' - Present the output of the regression as a `tibble` using the `tidy()` function and interpret the estimates. 
# Write code here after un-commenting
#'
#' - Is the point estimate for $\beta_1$ statistically significant? 
#' 
#' - What is the 95% confidence interval surrounding this estimate? Hint, read the help file for `tidy()`
# Write code here after un-commenting
#'
#' - What do we conclude with respect to our earlier hypothesis test? 
#' 
#' - Find the $R^2$ by using the `glance()` function? 
# Write code here after un-commenting
#'
#' - Does class size explain a lot of the variation in test scores?
#' 
#' 
#' __Q10:__ Describe in math, and in words, what the exogeniety assumption requires. Explain why this regression may violate this assumption.
#'
#'
#' __Q11:__ What is the formula for omitted variable bias? If we were to include a variable on school funding, what would you expect the sign to be? Are we over or under estimating $\beta_1$? Explain.
#'
#'
#' __Q12:__ On your old scatter plot, add another `geom` layer using `geom_smooth`. Read the help file (`?geom_smooth`) to plot the `lm` method, which is the same regression in __Q09__. Do your point estimates line up with your fitted line using `geom_smooth`.
#' 
#'
#' __Q13:__ Suppose we would like to control for school funding using in the following specification:
#'
#' $$
#' \text{Scores}_i = \beta_0 + \beta_1 \text{Class Size}_i + \text{Funding}_i + u_i
#' $$
#'
#' - Run this regression, using the variable `expreg` for school funding, and as before, interpret the coefficients and report the $R^2$.
# Write code here after un-commenting
#' 
#' - Does this regression improve on the $R^2$ found in the SLR above?
#' 
#'  __Q13:__ Based on the change in our point estimate of $\beta_2$ when we add $\text{Funding}_i$, what sign is the bias created by omitting this variable? Does this match your expectation from before?
#' 
#'
#' __Q14:__ Try to find a regression with an $R^2$ above 0.5 by adding additional regressors.
# Write code here after un-commenting
#'
#' - Now find the adjusted $R^2$ (using `glance()`). Is it bigger or smaller than the standard $R^2$?
# Write code here after un-commenting
#'
#' 