extends Node

signal good_word
signal bad_word
signal very_bad_word
signal time_end

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
