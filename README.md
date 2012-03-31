Analyzing the results from the Mercedes Benz Corporate 5k (Ft. Lauderdale)
--------------

The data was scraped from the [results] page. Since the results page seems to be dynamically generated (or something), I couldn't just scrape the online version - I couldn't come up with a URL that showed all of the records. Rather, I copied the source of the table to a file and then parsed it with python/BeautifulSoup.

The times provided were in H:M:S, I converted the data to seconds and to fractional minutes (to 2 places). I also cleaned up a little unicode in the participant/company names.

[results]: http://results.mercedesbenzcorporaterun.com/results/search.php?sub_event_id=226610&series_year=2012
