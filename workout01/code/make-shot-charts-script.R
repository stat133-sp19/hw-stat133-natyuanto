# Title: Chart Script of Shots
# Description: Visualization phase to create charts from the data of each players
# Input(s): andre-iguodala.csv, draymond-green.csv, kevin-durant.csv, klay-thompson.csv, stephen-curry.csv
# Output(s): Scatterplots

library(ggplot2)

data <- read.csv("../data/shots-data.csv", stringsAsFactors = FALSE)
andre <- data[data$name == "Andre Iguodala", ]
draymond <- data[data$name == "Draymond Green", ]
kevin <- data[data$name == "Kevin Durant", ]
klay <- data[data$name == "Klay Thompson", ]
stephen <- data[data$name == "Stephen Curry", ]

court_file <- "../images/nba-court.jpg"

court_image <- rasterGrob( readJPEG(court_file), width = unit(1, "npc"), height = unit(1, "npc"))

klay_scatterplot <- ggplot(data = klay) + geom_point(aes(x = x, y = y, color = shot_made_flag))
klay_shot_chart <- ggplot(data = klay) + 
  annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) +
  ylim(-50, 420) +
  ggtitle('Shot Chart: Klay Thompson (2016 season)') +
  theme_minimal()
