library(data.table);library(stringr)

getLastWords = function(input, n = 1){
  # Removing extra spaces and uppercases inputted by user
  input = gsub("[[:space:]]+", " ", str_trim(tolower(input)))
  input = gsub("'", "", input)
  
  # Separate into individual words
  words = unlist(strsplit(input, " "))
  
  if (length(words) < n){
    stop("Not enough terms!")
  }
  
  start = length(words)-n+1
  end = length(words)
  tempWords = words[start:end]
  
  paste(tempWords, collapse=" ")
}

predNextWord = function(inputString){
  
  input = gsub("[[:space:]]+"," ", str_trim(tolower(inputString)))
  allMatches = tks[6]
  fivegmatches = tks[6]
  fgmatches = tks[6]
  tgmatches = tks[6]
  bgmatches = tks[6]
  
  if(length(unlist(gregexpr("[[:space:]][[:alpha:]]", input))) >= 3){
    input = getLastWords(input, n = 4)
    fivegmatches = fiveg[firstWords == input, .(lastWord, probability)]
    if(nrow(fivegmatches) >= 5){
      allMatches = fivegmatches
    } else {
      input = getLastWords(input, n = 3)
      fgmatches = fg[firstWords == input & !(lastWord %in% fivegmatches$lastWord), .(lastWord, probability)]
      if(nrow(fgmatches) > 0){
        allMatches = as.data.table(rbind(fivegmatches, fgmatches))
      } else {
        input = getLastWords(input, n = 2)
        tgmatches = tg[firstWords == input & !(lastWord %in% fgmatches$lastWord), .(lastWord, probability)]
        if(nrow(tgmatches) > 0){
          allMatches = as.data.table(rbind(allMatches, tgmatches))
        } else {
          input = getLastWords(input, n = 1)
          bgmatches = bg[firstWords == input & !(lastWord %in% tgmatches$lastWord), .(lastWord, probability)]
          if(nrow(bgmatches) > 0){
            allMatches = as.data.table(rbind(allMatches, bgmatches))
          } else {
            allMatches = tks
          }
        }
      }
    }
  } else if(length(unlist(gregexpr("[[:space:]][[:alpha:]]", input))) == 2){
    fgmatches = fg[firstWords == input, .(lastWord, probability)]
    if(nrow(fgmatches) >=5){
      allMatches = fgmatches
    } else {
      input = getLastWords(input, n = 2)
      tgmatches = tg[firstWords == input & !(lastWord %in% fgmatches$lastWord), .(lastWord, probability)]
      if(nrow(tgmatches) > 0){
        allMatches = as.data.table(rbind(fgmatches, tgmatches))
      } else {
        input = getLastWords(input, n = 1)
        bgmatches = bg[firstWords == input & !(lastWord %in% tgmatches$lastWord), .(lastWord, probability)]
        if(nrow(bgmatches) > 0){
          allMatches = as.data.table(rbind(allMatches, bgmatches))
        } else {
          allMatches = tks
        }
      }
    }
  } else if(unlist(gregexpr("[[:space:]][[:alpha:]]", input)) > 0){
    tgmatches = tg[firstWords == input, .(lastWord, probability)]
    if(nrow(tgmatches) >= 5){
      allMatches = tgmatches
    } else {
      input = getLastWords(input, n = 1)
      bgmatches = bg[firstWords == input & !(lastWord %in% tgmatches$lastWord), .(lastWord, probability)]
      if(nrow(bgmatches) > 0){
        allMatches = as.data.table(rbind(tgmatches, bgmatches))
      } else {
        allMatches = tks
      }
    }
  } else {
    bgmatches = bg[firstWords == input, .(lastWord, probability)]
    if(nrow(bgmatches) > 0){
      allMatches = bgmatches
    } else {
      allMatches = tks
    }
  }
  
  allMatches = allMatches[order(-probability)]
  allMatches = setnames(allMatches,
                        old = c("lastWord","probability"),
                        new = c("Prediction","Probability"))
  if(nrow(allMatches) > 5){
    allMatches = allMatches[1:5,]
  }
  
  allMatches = allMatches[is.na(allMatches$Prediction) == FALSE]
  
  allMatches
  
}

