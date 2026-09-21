extends Area2D

@onready var timer: Timer = $Timer


func _on_body_entered(body):
	if body is Player:
		print("You died!")
		timer.start()
	else:
		body.queue_free
	


func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
