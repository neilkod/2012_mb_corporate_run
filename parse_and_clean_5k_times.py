from BeautifulSoup import BeautifulSoup
import codecs

def unescape(s):
  s = s.replace("&lt;", "<")
  s = s.replace("&gt;", ">")
  s = s.replace("&amp;", "&")
  return s

def parse_time(t):
  time_components = t.split(':')
  if len(time_components) == 2:
    secs = (int(time_components[0]) * 60) + int(time_components[1])
  elif len(time_components) == 3:
    secs = (int(time_components[0]) * 3600) + (int(time_components[1]) * 60) + int(time_components[2])
  return str(secs)

input_file = 'data/results_2012.html'
output_file = 'data/results_2012.tsv'
output_file_handle = codecs.open(output_file, 'w', 'utf-8')

results = open(input_file,'r').read()
soup = BeautifulSoup(results)
results_tab=soup.find('table',{'id':'results'})
rows=results_tab.findAll('tr')
# iterate through the rows

# skipping row 1 because its the header row.

for row in rows[1:]:

  # iterate through the fields in each row

  cols = row.findAll('td')
  overall_place = cols[0].text
  gender_place = cols[1].text
  bib = cols[2].text
  name = cols[3].text
  time_raw = cols[4].text

  # from time_raw, determine the number of seconds (integer) and fractional minutes, to 2 places
  seconds = parse_time(time_raw)
  minutes = str(round(float(seconds)/60, 2))

  gender = cols[5].text
  company = unescape(cols[6].find('a').text)
  
  result = '\t'.join([overall_place, gender_place, bib, name, time_raw, seconds, minutes, gender, company])
  output_file_handle.write(result + '\n')
output_file_handle.close()
  
