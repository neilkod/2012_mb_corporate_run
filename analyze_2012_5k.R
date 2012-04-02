library(ggplot2)
# load the raw data
raw_data = read.csv('/Users/nkodner/Dropbox/development/python/2012_mb_corporate_run/data/results_2012.tsv',header=FALSE, sep='\t',stringsAsFactors=FALSE)

# assign column names
names(raw_data) <- c('overall_position','gender_position','bib','name','time','seconds','minutes','gender','team')
# convert gender to a factor
raw_data$gender <- as.factor(raw_data$gender)

# split the cbs runners into a separate data frame
cbsi_runners <- raw_data[raw_data$team == 'Cbs Interactive', ]

# subset of all CBSi male and female runners
cbsi_male <- cbsi_runners[cbsi_runners$gender == "M",]

cbsi_female <- cbsi_runners[cbsi_runners$gender == "F",]



# display the male and female summaries
summary(cbsi_male$minutes)

summary(cbsi_female$minutes)

# boxplot of cbsi male vs female finishers
p <- ggplot(cbsi_runners,aes(gender,minutes))
p + geom_boxplot(aes(alpha=.4,fill=gender)) + coord_flip() + geom_point(shape=4,size=6,aes(colour=cbsi_runners$gender)) + opts(title="Finishing times for CBSi 5k participants - 2012 Mercedes-Benz Corporate Challenge, Ft. Lauderdale")

# cbsi male-female density plot
m <- ggplot(cbsi_runners,aes(x=minutes))
m + geom_density(aes(alpha=.65,fill=factor(gender))) + scale_x_continuous(limits =c(10,90)) + opts(title="Distribution of finishing times for CBSi 5k participants")

# density plot of all participants
x <- ggplot(raw_data,aes(x=minutes))
x + geom_density(aes(alpha=.65,fill=factor(gender))) + scale_x_continuous(limits =c(10,90)) + opts(title="Distribution of finishing times for all 5k participants")


# find top 15 teams, by count
teams <- ddply(raw_data,"team",function(dat) c(nrow(dat), median(dat$minutes),mean(dat$minutes)))
names(teams) <- c('team','count','median_time_in_minutes','mean_time_in_minutes')

# facet with teams with > 25 members
n=25
top_teams <- teams[teams$count > n,]

z <- ggplot(merge(raw_data,top_teams),aes(x=minutes))
z + geom_density(aes(alpha=.65,fill=factor(gender))) + scale_x_continuous(limits =c(10,90)) + opts(title=paste("Distribution of M/F finishing times for companies > ", n, " runners")) + facet_wrap(~team, ncol=6)

# male/female specific team summaries. I don't like this approach
male_runners <- raw_data[raw_data$gender == "M",]
female_runners <- raw_data[raw_data$gender == "F",]
male_team_stats <- ddply(male_runners,"team",function(dat) c(nrow(dat), median(dat$minutes),mean(dat$minutes)))
names(male_team_stats) <- c('team','count','median_time_in_minutes','mean_time_in_minutes')

female_team_stats <- ddply(female_runners,"team",function(dat) c(nrow(dat), median(dat$minutes),mean(dat$minutes)))
names(female_team_stats) <- c('team','count','median_time_in_minutes','mean_time_in_minutes')

all_team_summary<-merge(male_team_stats,female_team_stats,by="team")

faster_women <- all_team_summary[all_team_summary$mean_time_in_minutes.x > all_team_summary$mean_time_in_minutes.y, ]
q <- ggplot(merge(raw_data,faster_women),aes(x=minutes))
q + geom_density(aes(alpha=.65,fill=factor(gender))) + scale_x_continuous(limits =c(10,90)) + opts(title="teams with faster women") + facet_wrap(~team, ncol=6)

# male vs female mean finishing times
qplot(all_team_summary,aes(x=mean_time_in_minutes.x,y=mean_time_in_minutes.y))

#produce an ecdf
plot(ecdf(raw_data$minutes),col="red",verticals=TRUE,main="ecdf of 5k finishers(red) and CBSi (orange)",sub="minutes")
lines(ecdf(cbsi_runners$minutes),col="orange")






