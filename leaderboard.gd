extends Control

@onready var container = $ScrollContainer/VBoxContainer
@onready var entry = preload("res://leaderboard_entry.tscn")
@onready var http_request = $"../HTTPRequest"
@onready var line_edit = $LineEdit
@onready var main = $".."
@onready var button = $Button

var req_buf = []
var cur_req = null

func _process(delta: float) -> void:
	if not cur_req and len(req_buf) != 0:
		var req = req_buf.pop_front()
		cur_req = req[0]
		match cur_req:
			"fetch": fetch_leaderboard()
			"add": submit_score(req[1], req[2])

func fetch_leaderboard():
	var url = "https://clicker.madavidcoder.hackclub.app/leaderboard"
	http_request.request(url)

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	if response_code == 200:
		var json = JSON.new()
		var parse_result = json.parse(body.get_string_from_utf8())
		if parse_result == OK:
			match cur_req:
				"fetch":
					var leaderboard = json.data
					update_leaderboard_display(leaderboard)
				"add":
					button.text = "Already Joined!"
					button.disabled = true
					req_buf.append(["fetch"])
		else:
			print("Failed to parse leaderboard data.")
	else:
		print("Failed to fetch leaderboard: %d" % response_code)
	cur_req = null

func submit_score(name: String, score: int):
	var url = "https://clicker.madavidcoder.hackclub.app/add-entry"
	var payload = {"name": name, "score": score}
	var headers = ["Content-Type: application/json"]
	http_request.request(
		url,
		headers,
		HTTPClient.METHOD_POST,
		JSON.stringify(payload)
	)

func add(place: int, username: String, score: int):
	var card = entry.instantiate()
	card.get_child(0).text = "# " + str(place)
	card.get_child(1).text = username
	card.get_child(2).text = str(score) + " Lines"
	container.add_child(card)
	container.add_child(HSeparator.new())

func _on_button_pressed() -> void:
	button.text = "Loading..."
	button.disabled = true
	req_buf.append(["add", line_edit.text, main.score])

func update_leaderboard_display(data):
	for child in container.get_children():
		child.queue_free()
	for i in range(min(len(data), 101)):
		add(i+1, data[i]["name"], data[i]["score"])

func _on_close_button_pressed() -> void:
	hide()

func _on_leader_button_pressed() -> void:
	req_buf.append(["fetch"])
	for child in container.get_children():
		child.queue_free()
	var card = entry.instantiate()
	card.get_child(1).text = "Loading..."
	container.add_child(card)
	show()
