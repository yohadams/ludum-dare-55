extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_the_game_pressed():
	if GlobalSignals.story_seen:
		get_tree().change_scene_to_file("res://scenes/main.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/story.tscn")


func _on_sfx_toggled(toggled_on):
	GlobalSignals.isSFX = !toggled_on

func _on_music_toggled(toggled_on):
	GlobalSignals.isMusic = !toggled_on


func _on_info_pressed():
	get_tree().change_scene_to_file("res://scenes/info_screen.tscn")
