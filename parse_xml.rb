require "nokogiri"

def parse_xml(xml_file)
  array = Array.new
  hash = Hash.new

  doc =  Nokogiri::XML(open(xml_file).read)
  doc.search("note").map do |note|
    array.push(note.name.downcase)
  end

  new_hash = doc.root.element_children.each_with_object(Hash.new) do |element, hash|
    hash[element.name.to_sym] = element.content
  end
  
  hash[array.join] = new_hash
  return hash
end

p parse_xml(Pathname.new("notes.xml"))