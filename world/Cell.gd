# Author: Ary Pablo Batista <arypbatista@gmail.com>

const MAX_VITALITY = 6

const OVERPOPULATION = 7 * MAX_VITALITY
const UNDERPOPULATION = 2 * MAX_VITALITY
const GROW_THRESHOLD = 0.48

var alive = false
var vitality  = 0
var pos
var world

var delta


func _init(pos, world):
	self.pos = pos
	self.world = world
	
	
func update():
	self.world.updateCell(self)
	return self
	
	
func kill():
	vitality = 0
	alive = false
	return self.update()
	
	
func flip():
	
	alive = not alive
	
	if alive:
		vitality = MAX_VITALITY
	else: 
		vitality = 0
	
	return self.update()
	
	
func neighbors():
	return self.world.neighbors(self)
	
func aliveNeighbors():
	var res = []
	for n in self.neighbors():
		if n.alive:
			res.push_front(n)
	return res
	
func neighborsVitality():
	var vitality = 0
	for n in neighbors():
		vitality += n.vitality
	return vitality

func execute():
	vitality = min(max(vitality + delta, 0), MAX_VITALITY)
	if vitality == 0:
		alive = false
	else:
		alive = true

	return self.update()
	
	
func process():
	var neighborsVitality = neighborsVitality()
	
	if neighborsVitality <= UNDERPOPULATION:
		delta = -4 + neighborsVitality / MAX_VITALITY
		
	elif neighborsVitality >= OVERPOPULATION:
		delta = -(neighborsVitality / MAX_VITALITY) + 5	
	elif neighborsVitality <= OVERPOPULATION * (1 - GROW_THRESHOLD) and neighborsVitality >= UNDERPOPULATION * (1 + GROW_THRESHOLD):
		delta = 1
	else:
		delta = 0