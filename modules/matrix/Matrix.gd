# Author: Ary Pablo Batista <arypbatista@gmail.com>

var matrix
var cellFactory
var size

func _init(size, cellFactory=null):
	self.cellFactory = cellFactory
	self.size = size
	matrix = {}
		
		
func get(v):
	if v >= Vector2(0,0) and v < self.size:
		if not matrix.has(v.x):
			matrix[v.x] = {}
		
		if not matrix[v.x].has(v.y) and cellFactory:
			matrix[v.x][v.y] = cellFactory.create(v, self)
			
		return matrix[v.x][v.y]
		
	
func set(v, cell):
	matrix[v.x][v.y] = cell
	return self
	
	
func neighbors(v):
	var neighbors = []
	for x in range(v.x -1, v.x+2):
		for y in range(v.y-1, v.y+2):
			if not Vector2(x,y) == v and get(Vector2(x,y)):
				neighbors.push_back(get(Vector2(x,y)))
	return neighbors
	
func each(f):
	
	for x in range(0, size.width):
		for y in range(0, size.height):
			f.apply(get(Vector2(x,y)))
			
	return self