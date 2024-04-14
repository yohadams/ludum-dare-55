extends Label

var start_scale = Vector2(1, 1)  
var end_scale = Vector2(1.05, 1.05)

func _ready():
	var tween = create_tween()
	tween.tween_property(self, "scale", end_scale, 1.5)
	tween.tween_property(self, "scale", start_scale, 1.5)
	tween.set_loops()
	
