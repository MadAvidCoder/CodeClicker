extends TextureButton

var dir = 1
var t = 0

@onready var label = $"../Label"

func smooth_step(x: float) -> float:
	return x * x * (3.0 - 2.0 * x)

func custom_wave(phase: float) -> float:
	var s = sin(phase)
	var normalized = (s + 1.0) * 0.5
	var eased = smooth_step(normalized)
	var ss = eased * 2.0 - 1.0
	return lerp(s, ss, 0.4)

func _process(delta: float) -> void:
	t += delta * 1.3
	var phase = fmod(t, TAU) - PI
	rotation_degrees = custom_wave(phase) * 30

func _on_pressed() -> void:
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.13, 1.13), 0.07).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.05).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	
	var tween_2 = create_tween()
	tween_2.tween_property(label, "scale", Vector2(1.1, 1.1), 0.09).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween_2.tween_property(label, "scale", Vector2(1, 1), 0.05).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
