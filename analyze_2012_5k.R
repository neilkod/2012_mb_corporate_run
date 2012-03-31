# load the raw data
raw_data = read.csv('/Users/nkodner/Dropbox/development/python/2012_mb_corporate_run/data/results_2012.tsv',header=FALSE, sep='\t',stringsAsFactors=FALSE)

# assign column names
names(raw_data) <- c('overall_position','gender_position','bib','name','time','seconds','minutes','gender','team')
# convert gender to a factor
raw_data$gender <- as.factor(raw_data$gender)

# split the cbs runners into a separate data frame
cbsi_runners <- raw_data[raw_data$team == 'Cbs Interactive', ]
