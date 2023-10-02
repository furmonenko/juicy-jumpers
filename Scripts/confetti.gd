extends Node2D
class_name Confetti

func _on_timer_timeout() -> void:
	$GPUParticles2D.amount += 500
