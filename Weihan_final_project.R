
##install.packages("tibble")
##install.packages("ggplot2")
library(tibble)
#read in raw data table 
setwd("/Users/weihan/Desktop/Winter_2019/computation_for_biologist/Final_project")

in.file = "Gran_KDctrl_peaks.csv"

peaks_file <- read.csv(in.file)

#get rid of the first 25 lines, which are standard-formatted label information from the MACS2 peak calling program.We dont need
#these informations for downstream analysis
peaks_file <- peaks_file[-c(1:25),]

#assign column names 
peaks_file_colnames <- c("chr","start","end","length", "abs_summit","pileup","log10_p_value","fold_enrichment","log10_q_value","name")
colnames(peaks_file) <- peaks_file_colnames

#convert each column to the correct data type
peaks_file$chr <- as.character(peaks_file$chr)
peaks_file$name <- as.character(peaks_file$name)
peaks_file$start<-as.numeric(levels(peaks_file$start))[peaks_file$start]
peaks_file$end<-as.numeric(levels(peaks_file$end))[peaks_file$end]
peaks_file$length<-as.numeric(levels(peaks_file$length))[peaks_file$length]
peaks_file$abs_summit<-as.numeric(levels(peaks_file$abs_summit))[peaks_file$abs_summit]
peaks_file$pileup<-as.numeric(levels(peaks_file$pileup))[peaks_file$pileup]
peaks_file$log10_p_value<-as.numeric(levels(peaks_file$log10_p_value))[peaks_file$log10_p_value]
peaks_file$fold_enrichment<-as.numeric(levels(peaks_file$fold_enrichment))[peaks_file$fold_enrichment]
peaks_file$log10_q_value<-as.numeric(levels(peaks_file$log10_q_value))[peaks_file$log10_q_value]

#Rank the top peaks by log10(q value) (q value is simply FDR corrected p value).
peaks_file <- peaks_file[order(peaks_file$log10_q_value,decreasing = TRUE),]
#examine the structure and summary statistics of the ranked file
str(peaks_file)
summary(peaks_file$length)
#select the top 1000 peaks for analysis
peaks_file_top1000 <- peaks_file[c(1:1000),]
head(peaks_file_top1000)

#plot a histogram of distribution of the read length.Ideally this distribution should be right skewed
#most peaks should have read length of several hundread base pairs.

pdf(file = paste0(in.file, 'peaks_number_vs_length.pdf'), width = 5, height = 6)
hist(peaks_file$length, 
     xlab = "Peak Length(unit: bp)", 
     ylab="number of peaks", 
     main = "length distribution of most significant peaks")
dev.off()


#zoom into where most peaks are located
library(ggplot2)
pdf(file = paste0(in.file, 'zoomed_peaks_number_vs_length.pdf'), width = 5, height = 6)
ggplot(peaks_file, aes(peaks_file$length)) + 
        geom_histogram(binwidth = 200, breaks=seq(0,3000, by=100), col='black', fill='blue', alpha=0.7) +
        labs(x="Peak Length(unit: bp)",y="number of peaks",title = "length distribution of most significant peaks" )
dev.off()


#generate files with the correct format to input to MEME-Chip MOTIF analysis software. You can specify
#how many +/- base pairs of region you want to cover to call a peak, by specifying a number after"abs_summit"
peak_file_MEME_input <- data.frame(peaks_file_top1000$chr, peaks_file_top1000$abs_summit-200,peaks_file_top1000$abs_summit+200, peaks_file_top1000$name)

#download the MEME-Chip input file to current working directory
write.table(peak_file_MEME_input, paste0(in.file,".peak_file_MEME_input.txt"), sep="\t")




