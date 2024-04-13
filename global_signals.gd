extends Node

signal good_word

func emit_good_word():
	print('emituje good word')
	emit_signal('good_word')
