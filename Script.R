# SOURCE CODE FOUND AT : https://chryswoods.com/text_analysis_r/


# Install the relevant packages.

# Provides access to the Project Gutenberg collection of over 60,000 free eBooks.
# Downloading and analyzing works like Pride and Prejudice or Moby Dick.

#install.packages("gutenbergr")


# Provides access to text datasets and lexicons for text analysis.
# Useful for sentiment analysis, as it includes lexicons like AFINN, bing, and nrc.
# Loading sentiment lexicons to analyze the emotional tone of text.

#install.packages("textdata")


# Generates word clouds, which are visual representations of word frequency in a text.
# Visualizing the most frequent words in a document or corpus.

#install.packages("wordcloud")


# A package for creating and analyzing network graphs
# (e.g., social networks, word co-occurrence networks).
# Visualizing how often words appear together in a text.

#install.packages("igraph")


# An extension of ggplot2 for creating network graphs
# and other relational data visualizations.
# Creating a graph to show connections between characters in a novel.

#install.packages("ggraph")


# Provides tools for text mining and text analysis in a tidy format.
# Breaking text into individual words (tokenization) and performing sentiment analysis.

#install.packages("tidytext")


# A collection of R packages designed for data science and data manipulation.
# Cleaning, transforming, and visualizing data in a consistent and efficient way.

#install.packages("tidyverse")



# TOKENIZATION

# Load the libraries

library(tidyverse)
library(tidytext)

text = c("To be, or not to be--that is the question:",
         "Whether 'tis nobler in the mind to suffer",
         "The slings and arrows of outrageous fortune",
         "Or to take arms against a sea of troubles",
         "And by opposing end them.")


text <- tibble(line=1:5, text=text)
text

tokens <- text %>% unnest_tokens(word, text)
tokens

tokens %>% count(word, sort=TRUE)

lines <- readLines("https://chryswoods.com/text_analysis_r/hamlet.txt")
lines

hamlet <- tibble(line=1:length(lines), text=lines)
hamlet

hamlet_tokens <- hamlet %>% unnest_tokens(word, text)
hamlet_tokens %>% count(word, sort=TRUE)

data(stop_words)
stop_words

important_hamlet_tokens <- hamlet_tokens %>% anti_join(stop_words)
important_hamlet_tokens

important_hamlet_tokens %>% count(word, sort=TRUE)


hamlet %>% unnest_tokens(word, text) %>%
  anti_join(stop_words) %>%
  count(word, sort=TRUE)

library(gutenbergr)


Omar <- gutenberg_download(38511)
Omar

Omar <- Omar %>% 
  unnest_tokens(word, text) %>%
  anti_join(stop_words)

counts <- Omar %>% 
  count(word, sort=TRUE) %>%
  filter(n > 50)

counts <- counts %>% mutate(word = reorder(word, n))

counts %>% ggplot(aes(n, word)) + geom_col() + labs(y=NULL)


# SENTIMENT ANALYSIS


sentiments <- get_sentiments("nrc")
sentiments

sentiments %>% count(sentiment)

hound <- gutenberg_download(2852)%>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words)

hound

hound_sentiment <- hound %>% inner_join(sentiments)
hound_sentiment

hound_sentiment %>% 
  filter(sentiment=="positive") %>%
  count(word, sort=TRUE)


hound_sentiment %>%
  filter(sentiment=="joy") %>%
  count(word) %>% 
  summarise(total=sum(n))

hound_sentiment %>% count(sentiment)

hound_sentiment %>%
  count(sentiment) %>%
  mutate(sentiment = reorder(sentiment, n)) %>%
  ggplot(aes(n, sentiment)) + geom_col() + labs(y=NULL)

hound <- gutenberg_download(2852) %>% 
  mutate(linenumber=row_number()) %>% 
  unnest_tokens(word, text) %>% anti_join(stop_words)

hound

hound_sentiments <- hound %>% 
  inner_join(sentiments)

hound_sentiments

hound_blocks <- hound_sentiments %>% 
  count(block=linenumber%/%50, sentiment)

hound_blocks

hound_blocks <- hound_blocks %>% 
  pivot_wider(names_from = sentiment, 
              values_from = n, 
              values_fill = 0)

hound_blocks

hound_blocks <- hound_blocks %>% 
  mutate(sentiment = positive - negative)

hound_blocks

hound_blocks %>% ggplot(aes(block, sentiment)) + geom_col()

hound_blocks %>% ggplot(aes(block, joy)) + geom_col()
