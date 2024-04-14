extends Sprite2D

var start_x = -140
var end_x = 1400

func _ready():
	var tween = create_tween()
	tween.tween_property(self, "position:x", end_x, 10)
	tween.tween_property(self, "position:x", start_x, 10)
	tween.set_loops()
