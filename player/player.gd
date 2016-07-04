# Author: Ary Pablo Batista <arypbatista@gmail.com>

extends Control

signal play
signal stop
signal shuffle
signal clean

var listeners = []


# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	pass
	
func addListener(listener):
	listeners.push_front(listener)
	

func trigger_play():
	emit_signal("play")
	for l in listeners:
		l.play()

func trigger_stop():
	emit_signal("stop")
	for l in listeners:
		l.stop()
	
func trigger_shuffle():
	emit_signal("shuffle")
	for l in listeners:
		l.shuffle()
	
func trigger_clean():
	emit_signal("clean")
	for l in listeners:
		l.clean()


