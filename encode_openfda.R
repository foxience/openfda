substance.index <- read.csv('./substance.index.100',
                            header = FALSE,
                            col.names = c("label", "count"))
reaction.index <- read.csv('./reaction.index.1000',
                            header = FALSE,
                            col.names = c("label", "count"))

input.patient <- c(patient$onsetAge,
                   switch(patient$sex,
                          '1' = c(1, 0),
                          '2' = c(0, 1),
                          c(0.5, 0.5)))

input.substances <- ifelse(substance.index$label %in% substances$substance, 1, 0)
input.substances <- c(input.substances,
                      ifelse(sum(input.substances) < length(substances$substance), 1, 0))
input.reactions <- ifelse(reaction.index$label %in% reactions$reactionName, 1, 0)
input.reactions <- c(input.reactions,
                     ifelse(sum(input.reactions) < length(reactions$reactionName), 1, 0))
input <- c(input.patient, input.substances, input.reactions)