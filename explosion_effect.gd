extends Node2D

func _ready() -> void:
	$CPUParticles2D.emitting = true
	$AnimationPlayer.play("shockwave")

func _on_timer_timeout() -> void:
	queue_free()
