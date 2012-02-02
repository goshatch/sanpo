require 'flickraw'

FlickRaw.api_key="042e81414db7766384d40b54d42745c8"
FlickRaw.shared_secret="0c9e4df98a2b0d52"

list = flickr.photosets.getPhotos(:photoset_id => '72157627862078138')

id     = list[0].id
secret = list[0].secret
info = flickr.photos.getInfo :photo_id => id, :secret => secret

puts info.title           # => "PICT986"
puts info.dates.taken     # => "2006-07-06 15:16:18"

