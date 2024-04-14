extends AnimatedSprite2D

@onready var blink_timer = $Timer

func _ready():
	play("Idle")
	var callable = Callable(self, "_on_Blink_timer_timeout")
	blink_timer.connect("timeout", callable)
	start_random_timer()

func start_random_timer():
	var random_time = randf_range(4.0, 10.0)
	blink_timer.start(random_time)

func _on_Blink_timer_timeout():
	play("Blink")
	await get_tree().create_timer(1).timeout
	play("Idle")
	start_random_timer()
