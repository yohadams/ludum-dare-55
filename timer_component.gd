extends Node2D

@onready var label = $Label

var time_left = 2
var timer = null

func _ready():
	timer = Timer.new()
	timer.autostart = true
	timer.one_shot = false
	timer.wait_time = 1.0
	var callable = Callable(self, "_on_Timer_timeout")
	timer.connect('timeout', callable)
	add_child(timer)

func _on_Timer_timeout():
	time_left -= 1
	update_label()
	if time_left == 0:
		timer.stop()
		GlobalSignals.emit_time_end()

func update_label():
	label.text = str(time_left)  
