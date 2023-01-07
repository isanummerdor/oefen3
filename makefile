##main build rule
all: output/plot_Antwerp.pdf output/plot_all.pdf

##Sub builds
data/reviews.csv data/listings.csv: src/download.R
	R --vanilla < src/download.R

temp/aggregated_df.csv: src/run_Antwerp.R data/reviews.csv data/listings.csv
	R --vanilla < src/run_Antwerp.R

temp/pivot_table.csv: src/pivot_table.R temp/aggregated_df.csv
	R --vanilla < src/pivot_table.R

output/plot_Antwerp.pdf: src/plot_Antwerp.R temp/pivot_table.csv
	R --vanilla < src/plot_Antwerp.R
	
output/plot_all.pdf: temp/aggregated_df.csv src/plot_all.R
	R --vanilla < src/plot_all.R