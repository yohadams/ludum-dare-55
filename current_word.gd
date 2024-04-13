extends Label

var bad_words = ["bomb", 'glasses', 'spike ball']

const GREEN = Color(82, 192, 7)
const RED = Color(225, 25, 50)

var current_index = 0
var answer = ""
var current_item = []
var isLocked = false

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
		if (event.keycode >= KEY_A && event.keycode <= KEY_Z || event.keycode == KEY_SPACE) && isLocked != true:
			current_item[current_index] = char(event.keycode)
			self.text = array_to_string(current_item)
			if current_item.size() > current_index + 1:
				current_index += 1
			else:
				check_if_win()
		elif event.keycode == KEY_ENTER && isLocked != true:
			check_if_win()
				
func check_if_win():
	isLocked = true
	var input = self.text.to_lower()
	if input == answer:
		if bad_words.has(input):
			self.add_theme_color_override("font_color", Color.DARK_RED)
			GlobalSignals.emit_very_bad_word()
			reset_word()
		else:
			self.add_theme_color_override("font_color", Color.WEB_GREEN)
			good_word()
	else:
		if bad_words.has(answer):
			self.add_theme_color_override("font_color", Color.WEB_GREEN)
			good_word()
		else:
			self.add_theme_color_override("font_color", Color.DARK_RED)
			reset_word()
					
func good_word():
	await get_tree().create_timer(0.5).timeout
	GlobalSignals.emit_good_word()
	self.queue_free()
	isLocked = false
	
func reset_word():
	await get_tree().create_timer(0.5).timeout
	GlobalSignals.emit_bad_word()
	current_index = 0
	current_item = []
	for ch in answer:
		current_item.push_front('_')
	self.text = array_to_string(current_item)
	self.add_theme_color_override("font_color", Color.WHITE)
	isLocked = false

func array_to_string(array: Array) -> String:
	var string = ""
	for i in array:
		string += String(i)
	return string
