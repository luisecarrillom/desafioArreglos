
require 'net/http'
require 'json'

# Creamos metodo request
def request(url)
  uri = URI(url)
  response = Net::HTTP.get(uri)
  JSON.parse(response)
end

# Creamos método build_web_page
def build_web_page(data)
    photos = data['photos'].map { |photo| photo['img_src'] }
    
    html = "<html>\n<head>\n</head>\n<body>\n<ul>\n"
    
    photos.each do |photo|
      html += "<li><img src='#{photo}'></li>\n"
    end
    
    html += "</ul>\n</body>\n</html>"
  
    File.write('nasa_photos.html', html)
  end

  #Creamos método photos_count
  def photos_count(data)
    cameras = data['photos'].map { |photo| photo['camera']['name'] }
    count = Hash.new(0)
    
    cameras.each do |camera|
      count[camera] += 1
    end
    
    count
  end

  #Usamos los métodos con nuestra api_key
  url = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10&api_key=bM3OTNL3h3pc2nQyLc6ue8NmxfoHg90La6KA0U3U"

data = request(url)
build_web_page(data)
puts photos_count(data)
