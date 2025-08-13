extends TextureButton

var dir = 1
var t = 0

func smooth_step(x: float) -> float:
	return x * x * (3.0 - 2.0 * x)

func custom_wave(phase: float) -> float:
	var s = sin(phase)
	var normalized = (s + 1.0) * 0.5
	var eased = smooth_step(normalized)
	var ss = eased * 2.0 - 1.0
	return lerp(s, ss, 0.4)

func _process(delta: float) -> void:	
	t += delta
	var phase = fmod(t, TAU) - PI
	rotation_degrees = custom_wave(phase) * 30
