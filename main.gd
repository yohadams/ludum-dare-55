extends Node2D

var items = [
	"onion",
	"melon",
	"potato",
	"tomato",
	'cabbage',
	'beef',
	'chicken',
	'beet',
	'fish',
	'carrot',
	'bomb',
	'glasses',
	'spike ball',
	'banana',
	'grapes',
	'mushroom'
]
var answer = ''

@onready var SummoningCircle = $SummoningCircle

var font_theme = preload("res://font_theme.tres")
var WordComponent = preload("res://current_word.tscn")
var AnswerSprite = preload("res://answer_sprite.tscn")
var TryAgainButton = preload("res://try_again_button.tscn")
var RestartButton = preload("res://restart_button_wrapper.tscn")

var screen_center = DisplayServer.window_get_size() / 2
var word_x_offset = 125
var word_y_offset = 250

var correct_count = 0
var misstakes_count = 0
var very_bad_count = 0

func _ready():
	randomize()
	var callable_good_word = Callable(self, "_on_good_word")
	GlobalSignals.connect("good_word", callable_good_word)
	var callable_bad_word = Callable(self, "_on_bad_word")
	GlobalSignals.connect("bad_word", callable_bad_word)
	var callable_very_bad_word = Callable(self, "_on_very_bad_word")
	GlobalSignals.connect("very_bad_word", callable_very_bad_word)
	var callable_time_end = Callable(self, "_on_time_end")
	GlobalSignals.connect("time_end", callable_time_end)
	answer = get_random_item()
	create_new_word_component(answer)
	create_answer_sprite(answer)

func _on_good_word():
	correct_count += 1
	answer = get_random_item()
	create_new_word_component(answer)
	create_answer_sprite(answer)
	
func _on_bad_word():
	misstakes_count += 1

func _on_very_bad_word():
	very_bad_count += 1

func _on_time_end():
	$ScoreZoom.enabled = true
	var tween = $ScoreZoom.create_tween()
	tween.tween_property($ScoreZoom, "zoom", Vector2(2.5, 2.5), 0.3)
	tween.parallel().tween_property($ScoreZoom, "position", Vector2(259, 498), 0.5)
	tween.play()
	await get_tree().create_timer(0.5).timeout
	add_score_labels()
	
func create_answer_sprite(answer: String):
	var answer_sprite = AnswerSprite.instantiate()
	answer_sprite.init(answer)
	answer_sprite.position = SummoningCircle.position
	print('SummoningCircle.position', SummoningCircle.position)
	answer_sprite.scale = Vector2(4.5, 4.5)
	add_child(answer_sprite)
	
func create_new_word_component(answer: String):
	var word = WordComponent.instantiate()
	word.init(answer)
	word.position = Vector2(screen_center.x + word_x_offset, screen_center.y + word_y_offset)
	add_child(word)

func add_score_labels():
	var good_score_label = Label.new();
	good_score_label.text = "Good summons %s" % correct_count
	good_score_label.theme = font_theme
	good_score_label.add_theme_color_override("font_color", Color.WEB_GREEN)
	good_score_label.position = Vector2(-250, -90)
	good_score_label.add_theme_font_size_override("font_size", 48)
	good_score_label.add_theme_color_override("font_shadow_color", Color.WEB_GRAY)
	$ScoreZoom.add_child(good_score_label)
	
	var bad_score_label = Label.new();
	bad_score_label.text = "Bad summons %s" % misstakes_count
	bad_score_label.theme = font_theme
	bad_score_label.add_theme_color_override("font_color", Color.DARK_RED)
	bad_score_label.add_theme_font_size_override("font_size", 48)
	bad_score_label.add_theme_color_override("font_shadow_color", Color.WEB_GRAY)
	bad_score_label.position = Vector2(-250, -40)
	$ScoreZoom.add_child(bad_score_label)
	
	var very_bad_score_label = Label.new();
	very_bad_score_label.text = "Very bad summons %s" % very_bad_count
	very_bad_score_label.theme = font_theme
	very_bad_score_label.add_theme_color_override("font_color", Color.DARK_GOLDENROD)
	very_bad_score_label.add_theme_font_size_override("font_size", 48)
	very_bad_score_label.add_theme_color_override("font_shadow_color", Color.WEB_GRAY)
	very_bad_score_label.position = Vector2(-250, 10)
	
	$ScoreZoom.add_child(very_bad_score_label)
	
	var restart_button = RestartButton.new()
	$ScoreZoom.add_child(restart_button)
	
func restart_scene():
	get_tree().reload_current_scene()
	
func get_random_item():
	if items.size() == 0:
		return null
	var index = randi() % items.size()
	return items[index]


func _on_button_pressed():
	restart_scene()
