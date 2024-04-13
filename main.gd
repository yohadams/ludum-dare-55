extends Node2D

var items = [
	"onion",
	"melon",
	"potato",
	"tomato",
	'cabbage',
	'beef',
	'chicken',
	'pork',
	'beet',
]

var WordComponent = preload("res://current_word.tscn")
var screen_center = DisplayServer.window_get_size() / 2
var word_x_offset = 125
var word_y_offset = 125

func _ready():
	randomize()
	var callable = Callable(self, "_on_good_word")
	GlobalSignals.connect("good_word", callable)
	var answer = get_random_item()
	create_new_word_component(answer)

func _on_good_word():
	var answer = get_random_item()
	create_new_word_component(answer)

func create_new_word_component(answer: String):
	var word = WordComponent.instantiate()
	word.init(answer)
	word.position = Vector2(screen_center.x + word_x_offset, screen_center.y + word_y_offset)
	add_child(word)

func get_random_item():
	if items.size() == 0:
		return null
	var index = randi() % items.size()
	return items[index]
