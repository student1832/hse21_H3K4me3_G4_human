library(ggplot2)
library(dplyr)
# library(tidyr)   # replace_na
# library(tibble)  # column_to_rownames

###

NAME <- 'XF.hg19'
#NAME <- 'XF.hg38'
#NAME <- 'XL.hg19'
#NAME <- 'XL.hg38'
OUT_DIR <- 'C:/AniS/3_КУРС/bioinf/pr21/Results'

###

bed_df <- read.delim(paste0('C:/AniS/3_КУРС/bioinf/pr21/', NAME, '.bed'), as.is = TRUE, header = FALSE)
colnames(bed_df) <- c('chrom', 'start', 'end', 'name', 'score')
bed_df$len <- bed_df$end - bed_df$start
head(bed_df)

# hist(bed_df$len)

ggplot(bed_df) +
  aes(x = len) +
  geom_histogram() +
  ggtitle(NAME, subtitle = sprintf('Number of peaks = %s', nrow(bed_df))) +
  theme_bw()
ggsave(paste0('len_hist.', NAME, '.pdf'), path = OUT_DIR)



