extends Area2D

signal coin_collected

func _on_body_entered(body):
	if body is Player:
		print("+1 coin!")
		coin_collected.emit()
		queue_free()
