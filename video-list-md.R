# Script to generate the text and links for a video download markup page

# Number of Units and number of Modules per unit
module <- c(6, 6, 5, 7, 8, 8, 6, 7, 6)

for(i in 1:9) {
  print(paste0("##Unit ", i, "  "))
  for(j in 0:module[i]) {
    if(j == 0) {
      text <- paste0("[Unit ", i, ", Overview/Weekly Teaser]")
      address <- paste0("(https://s3-us-west-1.amazonaws.com/prod-edx/MedStats/Video240p/", "Unit+", i, "+Module+", j ,".mp4)  ")
      print(paste0(text, address))
    } else {
    text <- paste0("[Unit ", i, ", Module ", j, "]")
    address <- paste0("(https://s3-us-west-1.amazonaws.com/prod-edx/MedStats/Video240p/", "Unit+", i, "+Module+", j ,".mp4)  ")
    print(paste0(text, address))
    }
  }
}
