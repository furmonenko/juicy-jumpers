extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is Enemy:
		print("enemy entered")
		var enemy = body
		body.change_direction()
