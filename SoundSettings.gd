extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	$SFX.button_pressed  = !GlobalSignals.isSFX
	$Music.button_pressed  = !GlobalSignals.isMusic

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_sfx_toggled(toggled_on):
	GlobalSignals.isSFX = !toggled_on


func _on_music_toggled(toggled_on):
	GlobalSignals.isMusic = !toggled_on
