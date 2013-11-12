from xml.dom import minidom

print "loading xml..."
doc = minidom.parse("test.osm")

print "find nodes..."
nodes = doc.getElementsByTagName("node")

print "print node count..."
print len(nodes)