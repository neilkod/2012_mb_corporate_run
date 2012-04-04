Analyzing the results from the Mercedes Benz Corporate 5k (Ft. Lauderdale)
--------------

The data was scraped from the [results] page. Since the results page seems to be dynamically generated (or something), I couldn't just scrape the online version - I couldn't come up with a URL that showed all of the records. Rather, I copied the source of the table to a file and then parsed it with python/BeautifulSoup.

The times provided were in H:M:S, I converted the data to seconds and to fractional minutes (to 2 places). I also cleaned up a little unicode in the participant/company names.
    def time_to_seconds(t):
      "" convert the times (HH:MM:SS) into seconds ""
      time_components = t.split(':')
      if len(time_components) == 2:
        seconds = (int(time_components[0]) * 60) + int(time_components[1])
      elif len(time_components) == 3:
        seconds = (int(time_components[0]) * 3600) + (int(time_components[1]) * 60) + int(time_components[2])
      return str(seconds)

![densityplot](http://www.neilkodner.com/images/littlesnapper/5k_density_plot.png)
![ecdf](http://www.neilkodner.com/images/littlesnapper/5k_ecdf.png)
![teamplot](http://getfile0.posterous.com/getfile/files.posterous.com/neilkod/puIfypodktlnBHAlwApHfDtuJfdmIFHtmIauInbBjEusqpudclHhGlemhsFb/image.jpg.scaled1000.jpg)
![boxplot](http://www.neilkodner.com/images/littlesnapper/2012_5k_boxplot.png)
[results]: http://results.mercedesbenzcorporaterun.com/results/search.php?sub_event_id=226610&series_year=2012
