# Keeping Hipchat for Posterity

Driven by the need to keep for posterity the Hipchat forum for the General Assembly London WDI June 2013 course, which is full of resources from throughout the course (and general banter) this app (such as it is) takes the JSON from Hipchat, and passes it over some Underscore templating to give is a (moderately) useable layout.

The JS and HTML are wrapped in a Sinatra frame to allow us to host them on Heroku (or to do other twiddling as our heart may desire).

If you don't want to run it in Sinatra, just host the files from the public folder wherever you like.

## Downloading Hipchat Uploads

There's a little ruby script (`uploaded_file_downloader.rb`) which trawls through any links to uploaded files on Hipchat, and downloads them to keep them locally, just in case the Hipchat versions disappear.

Run it from the command line thus:

```bash
ruby uploaded_file_downloader.rb js/chat_data.json
```

The command-line argument is the path to the data - the script will put a `/public/` in front to locate the data file, and all the Hipchat attachments will be downloaded to `/public/uploads/`.

After the script downloads all the attachments, it replaces all links to `http://uploads.hipchat.com/file_path` in the data file with links to `/uploads/file_path` so the local files are served instead. If you want to save bandwidth, restore the json data file back to the original (the script keeps a timestamped backup), so the Hipchat files are still served, but you have a set locally.

(I zipped them up after downloading, then deleted the uploads folder - no sense in wasting space)

Once everything is downloaded, you could distribute the whole app (/public/uploads and all), and let people run it on their own machines with SimpleHTTPServer, or through Sinatra if they have it installed.

## Note on initial setup

I've included a 'sample' data file, but the data I received from Hipchat was one file for each day of posts. You'll need to manually concatenate these and remove the array brackets between each day to end up with one single array of JSON (or automate it somehow, and issue me a PR for your script :-)

I had a hiccup where some of the manipulation I did broke the line breaks, so the file did not parse as correct JSON, so I removed all the indentation and line breaks to put my file on one line. You may need to mess around with your data file too to get it to play nice.

Feel free to drop me a line if you have any troubles you can't resolve.






