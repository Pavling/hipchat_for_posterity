# Keeping Hipchat for Posterity

Driven by the need to keep for posterity the Hipchat forum for the General Assembly London WDI June 2013 course, which is full of resources from throughout the course (and general banter) this app (such as it is) takes the JSON from Hipchat, and passes it over some Underscore templating to give is a (moderately) useable layout.

The JS and HTML are wrapped in a Sinatra frame to allow us to host them on Heroku (or to do other twiddling as our heart may desire).

There's a little ruby script (`uploaded_file_downloader.rb`) which trawls through any links to uploaded files on Hipchat, and downloads them to keep them locally, just in case the Hipchat versions disappear.

