# Author: Ary Pablo Batista <arypbatista@gmail.com>

extends Node

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	get_node('Player').addListener(get_node('World'))


