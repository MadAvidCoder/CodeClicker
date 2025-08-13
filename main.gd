extends Node2D

var score = 0

func _on_texture_button_pressed() -> void:
	score += 1
	print(score)
