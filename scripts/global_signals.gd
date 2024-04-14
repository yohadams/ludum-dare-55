extends Node

## Global variables

var story_seen = false

## Signals

signal good_word
signal bad_word
signal very_bad_word
signal time_end
signal pause

func emit_good_word():
	print('emituje good word')
	emit_signal('good_word')

func emit_bad_word():
	print('emituje bad word')
	emit_signal('bad_word')
	
func emit_very_bad_word():
	print('emituje very_bad_word')
	emit_signal('very_bad_word')	

func emit_time_end():
	print('emit time end')
	emit_signal('time_end')
	
func emit_pause():
	print('emit pause')
	emit_signal('pause')


## Global music stuff 

var isMusic: bool = true
var isSFX: bool = true
var music_player = AudioStreamPlayer.new()

func _ready():
	add_child(music_player)
	music_player.stream = load("res://sounds/background-music2.wav")
	music_player.volume_db = -10
	if isMusic:
		music_player.play()

func play_music():
	if not music_player.playing:
		music_player.play()

func stop_music():
	music_player.stop()
