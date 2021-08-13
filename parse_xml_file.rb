require "nokogiri"

def parse_xml(path)
  doc = Nokogiri::XML(File.open(path)) do |config|
    config.noblanks
  end

  root = doc.root.name
  children = doc.css(root).children
  hash = Hash.new
  hash[root] = parse_children(children)
  p hash
end

def parse_children(children_nodes)
  children_names = children_nodes.map { |i| i.name }.uniq
  
  p_hash = children_names.each_with_object({}) do |name, hash|
    children = children_nodes.select { |i| i.name == name }

    if children.size == 1
      hash[name] = children.first.content
    else
      array = children.map do |child|
        parse_children(child.children)
      end
      hash[name] = array
    end
  end
  p_hash
end

# p parse_xml(Pathname.new("notes.xml"))
# p parse_xml(Pathname.new("catalog.xml"))
parse_xml(Pathname.new("catalog2.xml"))