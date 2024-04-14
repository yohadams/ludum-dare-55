extends AnimatedSprite2D

func _ready():
	self.play('Fire')
	var callable_pause = Callable(self, "_on_pause")
	GlobalSignals.connect("pause", callable_pause)

func _on_pause():
	self.stop()
