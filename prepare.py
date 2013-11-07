from osmread import parse_file, None

water_count = 0
for entity in parse_file("foo.osm.bz2"):
	if isinstance(entity, Node) and "water" in entity.tags:
	water_count += 1

print "%d water elements found", water_count
