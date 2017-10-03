**In Development**

# SG News Search
A search engine for Singapore's news websites. Built on Elixir & Phoenix. It is built as an side-project for me. It is mostly for me to learn how to build a solid Elixir app and ultimately deploy it. I plan to build everything myself, from the query parser, to the indexer, and also the crawler.

## How it works
Scrapes data from popular websites in Singapore's media landscape (e.g. Stomp, Straits Times, The New Paper, etc.) and indexes it, storing links to each article. It has a very simple crawling strategy. It looks for a list of articles, and then goes through each article to get the content from that article. It also extracts metadata like author, publish date etc. Behaviour is defined in a "strategy"; 1 strategy exists per website.
