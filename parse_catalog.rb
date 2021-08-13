require "nokogiri"

def parse_catalog(file_path)
  array = Array.new
  new_hash = Hash.new
  hash = Hash.new
  el_ctg = Hash.new

  doc =  Nokogiri::XML(open(file_path).read)
  # Get all elements
  hash_new = doc.root.element_children.each_with_object(Hash.new) do |element, hash_el|
    hash_new = Hash.new
    # Add all elements in array
    for i in element.css("*")
      hash_new[i.name.to_sym] = i.content
    end
    array.push(hash_new)
    el_ctg[element.name] = array
  end

  hash = { doc.root.name => el_ctg }  
  # hash = { doc.root.name => array }  
  p hash
end

parse_catalog(Pathname.new("catalog.xml"))
# parse_catalog(Pathname.new("catalog2.xml"))

# {"CATALOG"=> {"cd" => [{"TITLE=>"Empire Burlesque", "ARTIST=>"Bob Dylan", "COUNTRY"=>"USA", "COMPANY"=>"Columbia", price => "10.00", YEAR => "1985"}]}}