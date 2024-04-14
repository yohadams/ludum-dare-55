extends Sprite2D

var font_theme = preload("res://font_theme.tres")
var label = null

var good_job_quotes = [
	"Great!",
	"Good joooob!",
	"Yuuuuare the beest!",
	"Niceee!",
	"Awesooomeee!"
]

var bad_job_quotes = [
	"Nooo!",
	"Wrooong!",
	"Maybee next timeee...",
	"Misss",
]

func _ready():
	randomize()
	var callable_good_word = Callable(self, "_on_good_word")
	GlobalSignals.connect("good_word", callable_good_word)
	var callable_bad_word = Callable(self, "_on_bad_word")
	GlobalSignals.connect("bad_word", callable_bad_word)

func _process(delta):
	if label != null:
		label.position.y -= 0.5
		label.modulate.a -= 0.025

func _on_good_word():
	var quote = get_random_quote(good_job_quotes)
	show_label(quote)

func _on_bad_word():
	var quote = get_random_quote(bad_job_quotes)
	show_label(quote)
	
func show_label(quote): 
	label = Label.new()
	label.theme = font_theme
	label.position = Vector2(-16, -64)
	label.add_theme_font_size_override('font_size', 16)
	label.text = quote;
	self.add_child(label)
	await get_tree().create_timer(0.5).timeout
	label.queue_free();
	
func get_random_quote(quotes):
	if quotes.size() == 0:
		return null
	var index = randi() % quotes.size()
	return quotes[index]
