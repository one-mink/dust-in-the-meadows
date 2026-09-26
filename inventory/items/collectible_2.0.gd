extends StaticBody2D
@onready var collectible: Area2D = $interact_area
@export var item : InvItem 
var player = null


	
func collected():
	if player != null:
		get_tree().current_scene.get_node("HerbariumUI").discover_flower(item.name, item.description)
		player.collected(item)
		await get_tree().create_timer(0.1).timeout
		queue_free()
	

func _on_interact_area_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body 
