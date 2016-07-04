extends Node

const Matrix = preload('res://modules/matrix/Matrix.gd')
#const Bounds = preload('res://modules/bounds/Bounds.gd')
const Cell   = preload('./Cell.gd')

class Bounds:
		
	var rect
	var origin
	var size
	
	func _init(size, origin=Vector2(0,0)):
		self.rect = Rect2(origin, size)
		self.size = size
		self.origin = origin
	
	func has(point):
		return self.rect.has_point(point)


class CellFactory:

	var world

	func _init(world):
		self.world = world

	func create(v, cells):
		return Cell.new(v, world)


class CellShuffler:
	
	func apply(cell):
		if randf() > 0.6:
			cell.flip()

class CellProcess:
	
	func apply(cell):
		cell.process()
		
	
class CellExecute:
	
	func apply(cell):
		cell.execute()


class CellKill:
	
	func apply(cell):
		cell.kill()


class World extends Bounds:

	var cells
	var factory
	var tiles
	

	func _init(size, tiles).(size):
		self.tiles = tiles
		factory = CellFactory.new(self)
		cells = Matrix.new(size, factory)

	func get(pos):
		return cells.get(pos)

	func updateCell(cell):
		self.tiles.set_cellv(cell.pos, cell.vitality+1)

	func neighbors(cell):
		return cells.neighbors(cell.pos)

	func shuffle():
		cells.each(CellShuffler.new())
		
	func clean():
		cells.each(CellKill.new())
		
	func tick():
		cells.each(CellProcess.new())
		cells.each(CellExecute.new())



var world
# Author: Ary Pablo Batista <arypbatista@gmail.com>

var simulate = false

func _init():
	set_process_input(true)
	set_fixed_process(true)
	

func _input(event):
	if event.type == InputEvent.MOUSE_BUTTON and event.is_pressed():
		var cellPosition = event.pos / 16
		if world.has(cellPosition):
			world.get(cellPosition).flip()

var accumulated = 0

func _fixed_process(delta):
	if simulate:
		accumulated += delta
		if accumulated > 0.1:
			accumulated = 0
			world.tick()

func _ready():
	randomize()
	var size = Vector2(36, 25)
	world = World.new(size, get_node('Tiles'))
	world.shuffle()
	simulate = true


func play():
	simulate = true


func clean():
	world.clean()


func shuffle():
	world.shuffle()


func stop():
	simulate = false
