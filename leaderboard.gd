extends Control

@onready var container = $ScrollContainer/VBoxContainer
@onready var entry = preload("res://leaderboard_entry.tscn")

func add(place: int, username: String, score: int):
	var card = entry.instantiate()
	card.get_child(0).text = "# " + str(place)
	card.get_child(1).text = username
	card.get_child(2).text = str(score) + " Lines"
	container.add_child(card)
	container.add_child(HSeparator.new())

func _on_close_button_pressed() -> void:
	hide()

func _on_leader_button_pressed() -> void:
	show()
