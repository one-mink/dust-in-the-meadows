extends Area2D

signal coin_collected

func _ready():
	# Only connect if NOT already connected
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player"):
		print("+1 coin!")
		coin_collected.emit()
		queue_free()
