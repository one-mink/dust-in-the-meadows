extends StaticBody2D

@onready var chest_sprite: Sprite2D = $GoldChest
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var interact_area: Area2D = $InteractZone

var player = null
var player_near = false
var is_opened = false


func _ready():
	if not interact_area.body_entered.is_connected(_on_zone_enter):
		interact_area.body_entered.connect(_on_zone_enter)
	if not interact_area.body_exited.is_connected(_on_zone_exit):
		interact_area.body_exited.connect(_on_zone_exit)


func _on_zone_enter(body):
	if body.is_in_group("player") or body.has_method("has_key"):
		player = body
		player_near = true


func _on_zone_exit(body):
	if body == player:
		player_near = false


func _process(_delta):
	if player_near and not is_opened and Input.is_action_just_pressed("interact"):
		open_chest()


func open_chest():
	is_opened = true
	player.has_key = true
	
	chest_sprite.visible = false
	collision.disabled = true
	
	var notif = get_tree().current_scene.get_node_or_null("NotificationUI")
	if notif:
		notif.show_notification("Chest opened! You found a key.")
	print("📦 Chest opened — key given!")
