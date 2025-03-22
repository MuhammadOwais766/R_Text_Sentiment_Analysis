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