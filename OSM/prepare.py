import xml.etree.ElementTree as ET
import sqlite3 as lite
import os

try:
	os.remove("osm_l.db")
except:
	pass

# load xml
print "loading xml..."
doc = ET.parse("foo.osm")

# write data to sqlite
con = lite.connect("osm_l.db")
with con:
    
	cur = con.cursor()    
	cur.execute("CREATE TABLE Node(Id INT, Lat REAL, Lon REAL)")
	cur.execute("CREATE TABLE Way(Id INT)")
	cur.execute("CREATE TABLE WayNode(WayId INT, NodeId INT)")
	cur.execute("CREATE TABLE Relation(Id INT)")
	cur.execute("CREATE TABLE RelationWay(RelationId INT, WayId INT, Role TEXT)")

	# relations with water-type
	for relation in doc.findall(".//relation/tag[@v='water']/.."):
		print relation.get("id")
		cur.execute("INSERT INTO Relation VALUES(" + relation.get("id") + ")")

		# find all the ways in this relation
		for member in relation.findall("member"):
			way = doc.find(".//way[@id='" + member.get("ref") + "']")
			cur.execute("INSERT INTO Way VALUES(" + way.get("id") + ")")
			cur.execute("INSERT INTO RelationWay VALUES(" + relation.get("id") + ", " + way.get("id") + ", '" + member.get("role") + "')")

			# find all the nodes in the way
			for nd in way.findall("nd"):
				node = doc.find(".//node[@id='" + nd.get("ref") + "']")
				cur.execute("INSERT INTO Node VALUES(" + node.get("id") + ", " + node.get("lat") + ", " + node.get("lon") + ")")
				cur.execute("INSERT INTO WayNode VALUES(" + way.get("id") + ", " + node.get("id") + ")")

	# ways with water-type
	for way in doc.findall(".//way/tag[@v='water']/.."):
		# check if way id already in database
		cur.execute("SELECT * FROM Way WHERE Id = " + way.get("id"))
		if len(cur.fetchall()) == 0:
			cur.execute("INSERT INTO Way VALUES(" + way.get("id") + ")")

			# find all the nodes in the way
			for nd in way.findall("nd"):
				# check if node id already in database
				cur.execute("SELECT * FROM Node WHERE Id = " + nd.get("ref"))
				if len(cur.fetchall()) == 0:
					node = doc.find(".//node[@id='" + nd.get("ref") + "']")
					cur.execute("INSERT INTO Node VALUES(" + node.get("id") + ", " + node.get("lat") + ", " + node.get("lon") + ")")
					cur.execute("INSERT INTO WayNode VALUES(" + way.get("id") + ", " + node.get("id") + ")")
