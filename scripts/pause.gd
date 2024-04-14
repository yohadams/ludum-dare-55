extends Node2D

func _ready():
	GlobalSignals.music_player.stop()

func _on_try_again_button_button_down():
	if GlobalSignals.isMusic:
		GlobalSignals.music_player.play()
	get_tree().reload_current_scene()

func _on_return_to_menu_button_down():
	if GlobalSignals.isMusic:
		GlobalSignals.music_player.play()
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
