require 'rubygems'
require 'httpclient'
require 'json'

class Carrot2
  #
  # Ruby example of calling the DCS.
  #
  # Requires the following gems:
  #  gem install json_pure
  #  gem install httpclient
  #
  # Invoke with (if gems are not configured globally):
  #  ruby -rubygems ./example.rb
  #
  # recursive document count.
  def count_documents(cluster)
    count = cluster['documents'].length
    if cluster.has_key? 'clusters'
      count = cluster['clusters'].inject(count) {|sum, c| sum + count_documents(c) }
    end
    return count
  end

  # dump a cluster and its subclusters to the console.
  def dump(response, level = 0)
    response['clusters'].each do |cluster|
      print "%s%s [%i document(s)]\n" %
            ["  " * (level + 1),
             cluster['phrases'].join(", "),
             count_documents(cluster)]
      dump(cluster, level + 1) if cluster.has_key? 'clusters'
    end
  end

  # run a HTTP POST request to the DCS
  def dcs_request(uri, data)
    boundary = Array::new(16) { "%2.2d" % rand(99) }.join()
    extheader = {
      "content-type" => "multipart/form-data; boundary=___#{ boundary }___"
    }

    client = HTTPClient.new
    response = client.post_content(uri, data, extheader)
  end
  
  #
# Perform an external 'document source' request.
#
end
