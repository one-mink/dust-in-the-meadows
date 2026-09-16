extends Area2D
@onready var collectible: Area2D = $"."
@export var item : InvItem
var player = null


	
func collected():
	if player != null:
		player.collected(item)
		await get_tree().create_timer(0.1).timeout
		self.collectible.queue_free()
	

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body 
