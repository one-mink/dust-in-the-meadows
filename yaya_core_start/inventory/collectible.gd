extends Area2D
@onready var collectible: Area2D = $"."

func collected():
	collectible.queue_free()
