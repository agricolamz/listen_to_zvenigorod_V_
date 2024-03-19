setwd("/home/agricolamz/work/articles/2023_DiaL2/zvenigorod_V")
library(tidyverse)
df <- readxl::read_xlsx("V_zvenigorod.xlsx")

df |>
  mutate(audio = str_remove(source, ".eaf"),
         audio = str_c(audio, "-", round(time_start*1000)),
         audio = str_c(audio, "-", round(time_end*1000)),
         audio = str_c(audio, ".wav")) |>
  select(sentence, audio) |>
  distinct() |>
  mutate(id = 1:n()) |>
  write_csv("result.csv")

df <- read_csv("result.csv")

setwd("audio/")
map(seq_along(df$audio), function(i){
  file.copy(str_c("~/Desktop/zv/", df$audio[i]),
            str_c(df$id[i], ".wav"))
})

