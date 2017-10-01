**In Development**

# SG Feed
A feed aggregator for Singapore's most popular websites. Built on Elixir & Phoenix. It is built as an side-project for me. It is mostly for me to learn how to build a solid Elixir app and ultimately deploy it.

## How it works
Scrapes data from popular websites in Singapore's media landscape (e.g. Stomp, Straits Times, The New Paper, etc.) and combines it into a single feed. It has a very simple crawling strategy. It looks for a list of articles, and then goes through each article to get the content from that article. It also extracts metadata like author, publish date etc. Behaviour is defined in a "strategy"; 1 strategy exists per website.
