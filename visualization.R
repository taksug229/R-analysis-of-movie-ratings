getwd()
setwd("Set your working directory here")
movies <- read.csv("P2-Movie-Ratings.csv")
head(movies)
colnames(movies) <- c("Film", "Genre","CriticRating","AudienceRating","BudgetMillions","Year")
str(movies)
summary(movies)

# Set Year as factor
factor(movies$Year)
movies$Year <- factor(movies$Year)

summary(movies)
str(movies)

#------------------Aesthetics
library(ggplot2)

ggplot(data=movies, aes(x=CriticRating, y=AudienceRating)) 

#add geometry
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating)) + 
  geom_point()

#add color
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, 
                        color=Genre)) + 
  geom_point()

#add size
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, 
                        color=Genre, size=Genre)) + 
  geom_point()

#add size - better way
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, 
                        color=Genre, size=BudgetMillions)) + 
  geom_point()
#>>> This #1 (we will improve it)

#------------------Plotting with Layers

p <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, 
                             color=Genre, size=BudgetMillions)) 

#point
p + geom_point()

#lines
p + geom_line()

#multiple layers
p + geom_point() + geom_line()
p + geom_line() + geom_point()

#------------------Overriding Aesthetics

q <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating,
                             color=Genre, size=BudgetMillions))

#add geom layer
q + geom_point()

#overriding aes
#example 1
q + geom_point(aes(size=CriticRating))

#example 2
q + geom_point(aes(color=BudgetMillions))

#q remains the same
q + geom_point()

#example 3
q + geom_point(aes(x=BudgetMillions)) +
  xlab("Budget Millions $$$")

#example 4
p + geom_line() + geom_point()
#reduce line size
q + geom_line(size=1) + geom_point()

#------------------ Mapping vs Setting

r <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating))
r + geom_point()

#add color
#1. Mapping (What we've done so far):
r + geom_point(aes(color=Genre))

#Setting:
r + geom_point(color="DarkGreen")
#ERROR
#r + geom_point(aes(color="DarkGreen"))

#1. Mapping
r + geom_point(aes(size=BudgetMillions))
#2. Setting
r + geom_point(size=10)
#ERROR
#r + geom_point(aes(size=10))

#------------------ Histograms and Density Charts

s <- ggplot(data=movies, aes(x=BudgetMillions))
s + geom_histogram(binwidth = 10)

#add color
s + geom_histogram(binwidth = 10, aes(fill=Genre))
#add a border
s + geom_histogram(binwidth = 10, aes(fill=Genre), color="Black")
#>>> 3 (we will improve it)

#somtimes you may need density charts:
s + geom_density(aes(fill=Genre))
s + geom_density(aes(fill=Genre), position="stack")

#------------------ Starting Layer Tips

t <- ggplot(data=movies, aes(x=AudienceRating))
t + geom_histogram(binwidth = 10,
                   fill = "White", color = "Blue")

#another way:
t <- ggplot(data=movies)
t + geom_histogram(binwidth = 10,
                   aes(x=AudienceRating),
                   fill = "White", color = "Blue")

#>>> 4 
t + geom_histogram(binwidth = 10,
                   aes(x=CriticRating),
                   fill = "White", color = "Blue")

#>>> 5

t <- ggplot()

#------------------ Statistical Transformation

?geom_smooth

u <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating,
                             color=Genre))
u + geom_point() + geom_smooth(fill=NA)


#boxplots
u <- ggplot(data=movies, aes(x=Genre, y=AudienceRating,
                             color=Genre))

#boxplot critic rating
#u <- ggplot(data=movies, aes(x=Genre, y=CriticRating,
                             #color=Genre))

u + geom_boxplot()
u + geom_boxplot(size=1.2)
u + geom_boxplot(size=1.2) + geom_point()
#tip / hack:
u + geom_boxplot(size=1.2) + geom_jitter()
#another way:
u + geom_jitter() + geom_boxplot(size=1.2, alpha=0.5)
#>>> 6

#------------------ Using Facets

v <- ggplot(data=movies, aes(x=BudgetMillions))
v + geom_histogram(binwidth = 10, aes(fill=Genre),
                   color="Black")

#facets
v + geom_histogram(binwidth = 10, aes(fill=Genre),
                   color="Black") +
  facet_grid(Genre~., scales="free")

#scatterplots:
w <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating,
                             color=Genre))
w + geom_point(size=3)

#facets
w + geom_point(size=3) +
  facet_grid(Genre~.)

w + geom_point(size=3) +
  facet_grid(.~Year)

w + geom_point(size=3) +
  facet_grid(Genre~Year)

w + geom_point(size=3) +
  geom_smooth() +
  facet_grid(Genre~Year)

w + geom_point(aes(size=BudgetMillions)) +
  geom_smooth() +
  facet_grid(Genre~Year)
#>>> 1 (but still will improve)

#------------------ Coordinates

#Today:
#limits
#zoom

m <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating,
                             size=BudgetMillions,
                             color=Genre))
m + geom_point()

m + geom_point() + 
  xlim(50,100) +
  ylim(50,100)

#won't work well always
n <- ggplot(data=movies, aes(x=BudgetMillions))
n + geom_histogram(binwidth = 10, aes(fill=Genre), color="Black")

n + geom_histogram(binwidth = 10, aes(fill=Genre), color="Black") +
  ylim(0,50)

#instead - zoom:
n + geom_histogram(binwidth = 10, aes(fill=Genre), color="Black") +
  coord_cartesian(ylim=c(0,50))

#imporve #1:
w + geom_point(aes(size=BudgetMillions)) +
  geom_smooth() +
  facet_grid(Genre~Year) +
  coord_cartesian(ylim=c(0,100))

#------------------ Theme

o <- ggplot(data=movies, aes(x=BudgetMillions))
h <- o + geom_histogram(binwidth = 10, aes(fill=Genre), color="Black")

h

#axis label
h + 
  xlab("Money Axis") +
  ylab("Number of Movies")

#label formatting
h + 
  xlab("Money Axis") +
  ylab("Number of Movies") +
  theme(axis.title = element_text(color="DarkGreen", size=30),
        axis.title.y = element_text(color="Red", size=30))

#tick mark formatting
h + 
  xlab("Money Axis") +
  ylab("Number of Movies") +
  theme(axis.title = element_text(color="DarkGreen", size=30),
        axis.title.y = element_text(color="Red", size=30),
        axis.text.x = element_text(size=20),
        axis.text.y = element_text(size=20))

?theme

#legend formatting
h + 
  xlab("Money Axis") +
  ylab("Number of Movies") +
  theme(axis.title = element_text(color="DarkGreen", size=30),
        axis.title.y = element_text(color="Red", size=30),
        axis.text.x = element_text(size=20),
        axis.text.y = element_text(size=20),
        
        legend.title = element_text(size=30),
        legend.text = element_text(size=20),
        legend.position = c(1,1),
        legend.justification = c(1,1)
        )

#title
h + 
  xlab("Money Axis") +
  ylab("Number of Movies") +
  ggtitle("Movie Budget Distribution") +
  theme(axis.title = element_text(color="DarkGreen", size=30),
        axis.title.y = element_text(color="Red", size=30),
        axis.text.x = element_text(size=20),
        axis.text.y = element_text(size=20),
        
        legend.title = element_text(size=30),
        legend.text = element_text(size=20),
        legend.position = c(1,1),
        legend.justification = c(1,1),
        
        plot.title = element_text(color="DarkBlue",
                                  size=40, 
                                  family="Courier"))
