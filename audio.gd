extends AudioStreamPlayer

var click_sounds = [
	preload("res://audio/keyboard/key-01.mp3"),
	preload("res://audio/keyboard/key-02.mp3"),
	preload("res://audio/keyboard/key-03.mp3"),
	preload("res://audio/keyboard/key-04.mp3"),
	preload("res://audio/keyboard/key-05.mp3"),
	preload("res://audio/keyboard/key-06.mp3"),
	preload("res://audio/keyboard/key-07.mp3"),
	preload("res://audio/keyboard/key-08.mp3"),
	preload("res://audio/keyboard/key-09.mp3"),
	preload("res://audio/keyboard/key-10.mp3"),
	preload("res://audio/keyboard/key-11.mp3"),
	preload("res://audio/keyboard/key-12.mp3"),
	preload("res://audio/keyboard/key-13.mp3"),
	preload("res://audio/keyboard/key-14.mp3"),
	preload("res://audio/keyboard/key-15.mp3"),
	preload("res://audio/keyboard/key-16.mp3"),
	preload("res://audio/keyboard/key-17.mp3"),
	preload("res://audio/keyboard/key-18.mp3"),
	preload("res://audio/keyboard/key-19.mp3"),
	preload("res://audio/keyboard/key-20.mp3"),
	preload("res://audio/keyboard/key-21.mp3"),
	preload("res://audio/keyboard/key-22.mp3"),
	preload("res://audio/keyboard/key-23.mp3"),
]

func play_click():
	stream = click_sounds[randi() % click_sounds.size()]
	pitch_scale = randf_range(0.95, 1.05)
	play()
