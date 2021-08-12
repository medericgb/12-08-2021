require "nokogiri"

def parse_catalog(file_path)
  array = Array.new
  hash = Hash.new

  doc =  Nokogiri::XML(open(file_path).read)
  
  hash_new = doc.root.element_children.each_with_object(Hash.new) do |element, hash_el|
    for i in element.css("*")
      hash_el[i.name.to_sym] = i.content
    end
    p "_____________________"
    array.push(hash_el)
    p array
  end
  # p array
end

parse_catalog(Pathname.new("catalog.xml"))

# {"CATALOG"=> {"cd" => [{"TITLE=>"Empire Burlesque", "ARTIST=>"Bob Dylan", "COUNTRY"=>"USA", "COMPANY"=>"Columbia", price => "10.00", YEAR => "1985"}]}}