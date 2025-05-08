################################################
## File Organization for "Listening to Lakes" ##
## Author: Bennett McAfee ######################
################################################

library(tidyverse)
library(xml2)

setwd(dirname(rstudioapi::getSourceEditorContext()$path))

dirs <- list.dirs(path = getwd(), recursive = FALSE)
dirs <- dirs[grepl(".Rproj.user", dirs, fixed = TRUE) == FALSE]
dirs <- dirs[grepl("annotations", dirs, fixed = TRUE) == FALSE]

log_df <- data.frame("recordID" = character(),
                     "recordStartTime" = character(),
                     "recordStopTime" = character(),
                     "tempDegC" = numeric(),
                     "recordingPath" = character(),
                     "annotationPath" = character())

for (parentdir in dirs){
  dir <- paste0(parentdir, "/8567")
  files <- list.files(dir)
  files <- files[grepl(".offloadLog.txt", files, fixed = TRUE) == FALSE]
  recordings <- files[grepl(".sud", files, fixed = TRUE)]
  recordings <- tools::file_path_sans_ext(recordings)
  
  for (recordID in recordings){
    xml_file <- read_xml(paste0(dir, "/", recordID, ".log.xml"))
    StartTime <- xml_attr(xml_find_first(xml_file, "//WavFileHandler[@SamplingStartTimeLocal]"), "SamplingStartTimeLocal")
    StopTime <- xml_attr(xml_find_first(xml_file, "//WavFileHandler[@SamplingStopTimeLocal]"), "SamplingStopTimeLocal")
    temperature <- as.numeric(xml_text(xml_find_first(xml_file, "//TEMPERATURE")))/100
    
    new_entry <- data.frame("recordID" = recordID,
                            "recordStartTime" = StartTime,
                            "recordStopTime" = StopTime,
                            "tempDegC" = temperature,
                            "recordingPath" = paste0(dir, "/", recordID, ".wav"),
                            "annotationPath" = paste0(getwd(), "/annotations/", recordID, ".Table.1.selections.txt"))
    log_df <- rbind(log_df, new_entry)
  }
}

write.csv(log_df, file = "audio_and_annotation_file_guide.csv", row.names = FALSE)
