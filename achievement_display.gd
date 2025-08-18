extends Control

var lines = []
var typing_speed := 0.055
var line_pause := 1
var cursor_blink_speed := 0.35

var _current_line := 0
var _current_char := 0
var _displayed_text := ""
var _is_typing_line := false
var _is_pausing_before_line := false

var _cursor_visible := true
var _blink_time := 0.0

@onready var label := $SubViewport/Label
@onready var timer = $Timer

func _ready():
	label.bbcode_enabled = true

func display(content):
	if visible:
		await timer.timeout
	show()
	lines = content
	_start_typing()

func _start_typing():
	timer.stop()
	_current_line = 0
	_displayed_text = ""
	_is_typing_line = false
	_is_pausing_before_line = false
	_start_next_line()

func _start_next_line():
	if _current_line >= lines.size():
		_is_typing_line = false
		_is_pausing_before_line = false
		return
	_current_char = 0
	_is_typing_line = false
	_is_pausing_before_line = true
	# Show the new ">" right away during the pause
	await get_tree().create_timer(line_pause).timeout
	_is_pausing_before_line = false
	_is_typing_line = true
	_type_line()

func _type_line():
	var line = lines[_current_line]
	var prefix = "[color=lime]>[/color] "
	while _current_char <= line.length():
		await get_tree().create_timer(typing_speed).timeout
		_current_char += 1
	# After typing, finalize line and move to next
	_displayed_text += prefix + line + "\n"
	_current_line += 1
	_is_typing_line = false
	_is_pausing_before_line = true
	_start_next_line()

func _get_current_line_text() -> String:
	if _current_line >= lines.size():
		return ""
	var prefix = "[color=lime]>[/color] "
	var line = lines[_current_line]
	if _is_typing_line:
		# Currently typing the line
		return prefix + line.substr(0, _current_char)
	elif _is_pausing_before_line:
		# Pausing before typing the next line, show only ">"
		return prefix
	else:
		return ""

func _process(delta):
	# Always blink while animation is running
	if _is_typing_line or _is_pausing_before_line:
		_blink_time += delta
		if _blink_time > cursor_blink_speed:
			_cursor_visible = !_cursor_visible
			_blink_time = 0.0

	var to_display = _displayed_text
	var current_line = _get_current_line_text()
	var cursor = ""
	if (_is_typing_line or _is_pausing_before_line) and _cursor_visible:
		cursor = "█"
	label.text = to_display + current_line + cursor

	if not (_is_typing_line or _is_pausing_before_line) and _current_line >= lines.size():
		label.text = _displayed_text
		if timer.is_stopped():
			timer.start()

func _on_timer_timeout():
	hide()
