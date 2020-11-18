library("tidyverse")
library("gganimate")
library("lubridate")

download.file("https://www.opendata.nhs.scot/dataset/b318bddf-a4dc-4262-971f-0ba329e09b87/resource/427f9a25-db22-4014-a3bc-893b68243055/download/trend_ca_20201117.csv", "ladata.csv")

# read data

dflachart <- read_csv("ladata.csv") %>%
  mutate(date2=ymd(Date)) %>%
  filter(month(date2)>7 & year(date2) > 2019)


plotlachart <- dflachart %>%
  ggplot(aes(x=date2, y=DailyPositive)) +
           geom_col() +
           ylab("Daily Cases") +
           xlab("") +
           scale_x_date(date_labels = "%B") +
           transition_states(CAName, state_length = 30, 
                             transition_length = 0,
                             wrap=FALSE) +
           view_follow() +
           theme_light() +
           ggtitle('{next_state} - recent days incomplete as reporting lag')
animate(plotlachart, nframes=32, duration = 120, renderer = av_renderer())
anim_save("plotlachart.mp4")

