extends StaticBody2D

@onready var door_collision: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
var is_on_zone = false
var door_state =  "clossed"
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") and is_on_zone:
		if door_state == "clossed":
			door_state = "open"
			door_collision.disabled = true
			animated_sprite.play("open")
		elif door_state == "open":
			door_state = "clossed"
			door_collision.disabled = false
			animated_sprite.play("closed")
		
func _on_interac_area_body_entered(body: Node2D) -> void:
	if body is Player:
		is_on_zone = true

func _on_interac_area_body_exited(body: Node2D) -> void:
	if body is Player:
		is_on_zone = false
