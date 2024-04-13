extends Label

const GREEN = Color(82, 192, 7)
const RED = Color(225, 25, 50)

var current_index = 0
var answer = ""
var current_item = []

func init(a):
	answer = a
	for ch in a:
		current_item.push_front('_')
	print('instantiate', a, current_item)

func _ready():
	set_process_input(true)
	self.text = array_to_string(current_item)

# BASIC GAME FUNCTIONALITY
func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode >= KEY_A&&event.keycode <= KEY_Z:
			print(event, current_index, current_item.size())
			current_item[current_index] = char(event.keycode)
			self.text = array_to_string(current_item)
			if current_item.size() > current_index + 1:
				current_index += 1
			else:
				if self.text.to_lower() == answer:
					self.add_theme_color_override("font_color", Color.WEB_GREEN)
					good_word()
				else:
					self.add_theme_color_override("font_color", Color.DARK_RED)
					reset_word()
func good_word():
	await get_tree().create_timer(0.5).timeout
	GlobalSignals.emit_good_word()
	self.queue_free()
	
func reset_word():
	await get_tree().create_timer(0.5).timeout
	current_index = 0
	current_item = []
	for ch in answer:
		current_item.push_front('_')
	self.text = array_to_string(current_item)
	self.add_theme_color_override("font_color", Color.WHITE)

func array_to_string(array: Array) -> String:
	var string = ""
	for i in array:
		string += String(i)
	return string
