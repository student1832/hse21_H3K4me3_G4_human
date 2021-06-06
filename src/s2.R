#install.packages("dplyr")


library(ggplot2)
library(dplyr)
# library(tidyr)   # replace_na
# library(tibble)  # column_to_rownames

###

NAME <- 'XF.hg19'
#NAME <- 'XF.hg38'
#NAME <- 'XL.hg19'
#NAME <- 'XL.hg38'
OUT_DIR <- 'C:/AniS/3_КУРС/bioinf/pr21'

###

bed_df <- read.delim(paste0('C:/AniS/3_КУРС/bioinf/pr21/', NAME, '.bed'), as.is = TRUE, header = FALSE)
colnames(bed_df) <- c('chrom', 'start', 'end', 'name', 'score')
bed_df$len <- bed_df$end - bed_df$start
head(bed_df)

bed_df <- bed_df %>%
  arrange(-len) %>%
  filter(len < 50000)

ggplot(bed_df) +
  aes(x = len) +
  geom_histogram() +
  ggtitle(NAME, subtitle = sprintf('Number of peaks = %s', nrow(bed_df))) +
  theme_bw()
ggsave(paste0('len_hist.', NAME, '.filtered.pdf'), path = OUT_DIR)

bed_df %>%
  select(-len) %>%
  write.table(file='C:/AniS/3_КУРС/bioinf/pr21/XF.hg19.filtered.bed',
              col.names = FALSE, row.names = FALSE, sep = '\t', quote = FALSE)

