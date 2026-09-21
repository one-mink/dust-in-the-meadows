extends StaticBody2D

var is_on_zone = false
var player = null


func _process(_delta: float) -> void:
	if is_on_zone and Input.is_action_pressed("Jump"):
		player.velocity.y = -200
		
func _on_interact_area_body_entered(body: Node2D) -> void:
	if body is Player:
		is_on_zone = true
		player = body
		

func _on_interact_area_body_exited(body: Node2D) -> void:
	if body is Player:
		is_on_zone = false
		player = null 
