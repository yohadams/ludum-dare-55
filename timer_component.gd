extends Node2D

@onready var label = $Label
@onready var BacgroundMusic = $BackgroundMusic
var time_left = 10
var timer = null

func _ready():
	timer = Timer.new()
	timer.autostart = true
	timer.one_shot = false
	timer.wait_time = 1.0
	var callable = Callable(self, "_on_Timer_timeout")
	timer.connect('timeout', callable)
	add_child(timer)
	
	if GlobalSignals.isMusic:
		BacgroundMusic.play()

func _on_Timer_timeout():
	time_left -= 1
	update_label()
	if time_left <= 10:
		BacgroundMusic.pitch_scale += 0.1
	if time_left == 0:
		timer.stop()
		BacgroundMusic.pitch_scale = 1
		GlobalSignals.emit_time_end()

func update_label():
	label.text = str(time_left)  
