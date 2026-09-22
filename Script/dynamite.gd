extends RigidBody2D


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var rock_list = []

func _on_fuze_timer_timeout() -> void:
	explode()
	
func explode():
	animated_sprite_2d.play("explode")
	await get_tree().create_timer(1).timeout
	for rock in rock_list:
		rock.queue_free()
	queue_free()
	
	

func _on_explode_area_body_entered(body: Node2D) -> void:
	if body is breakable_rock:
		rock_list.append(body)
	

func _on_explode_area_body_exited(body: Node2D) -> void:
	if body is breakable_rock:
		rock_list.erase(body)
