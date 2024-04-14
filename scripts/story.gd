extends Node2D

var story_index = 1

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		story_index += 1
		if story_index == 2:
			$Dialog1.visible = false
			$Dialog2.visible = true
		elif story_index == 3:
			$Dialog2.visible = false
			$Dialog3.visible = true
		elif story_index == 4:
			$Dialog3.visible = false
			$Dialog4.visible = true
			$Sad.visible = true
		elif story_index == 5:
			$Sad.visible = false
			$Dialog4.visible = false
			$Dialog5.visible = true
		elif story_index == 6:
			$Dialog5.visible = false
			$Dialog6.visible = true
		elif story_index == 7:
			GlobalSignals.story_seen = true
			get_tree().change_scene_to_file("res://scenes/main.tscn")
