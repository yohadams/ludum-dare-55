extends Sprite2D

var images = {
	"beef": preload ("res://sprites/beef.png"),
	"chicken": preload ("res://sprites/chicken.png"),
	"beet": preload ("res://sprites/beet.png"),
	"cabbage": preload ("res://sprites/cabbage.png"),
	"melon": preload ("res://sprites/melon.png"),
	"potato": preload ("res://sprites/potato.png"),
	"tomato": preload ("res://sprites/tomato.png"),
	"onion": preload ("res://sprites/onion.png"),
	"carrot": preload ("res://sprites/carrot.png"),
	"fish": preload ("res://sprites/fish.png"),
	"bomb": preload ("res://sprites/bomb.png"),
	"glasses": preload ("res://sprites/glasses.png"),
	"spike ball": preload("res://sprites/spike_ball.png"),
	"mushroom": preload("res://sprites/mushoroom.png"),
	"banana": preload("res://sprites/banana.png"),
	"grapes": preload("res://sprites/grapes.png")
}

var rotation_speeds = [5, 45, 90, 175, 225, 450]
var rotation_speed = 0
var rotation_flag = 0
var is_falling = false

func _ready():
	randomize()
	var callable_good_word = Callable(self, "_on_good_word")
	GlobalSignals.connect("good_word", callable_good_word)
	rotation_speed = get_random_rotation_speed()
	rotation_flag = randi() % 10
	
func init(answer: String):
	self.texture = images.get(answer, 'onion')

func _process(delta):
	if rotation_flag > 5:
		rotation_degrees += rotation_speed * delta
	else:
		rotation_degrees -= rotation_speed * delta
	if is_falling == true:
		self.position.y += 3.5
		self.modulate.a -= 0.025
	
func _on_good_word():
	is_falling = true
	await get_tree().create_timer(0.8).timeout
	queue_free()
	is_falling = false
	
func get_random_rotation_speed():
	if rotation_speeds.size() == 0:
		return null
	var index = randi() % rotation_speeds.size()
	return rotation_speeds[index]
