extends StaticBody2D

@export var key_item : InvItem
@onready var chest_sprite: Sprite2D = $GoldChest
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var interact_area: Area2D = $InteractZone

var player = null
var player_near = false
var is_opened = false

func _ready():
	interact_area.body_entered.connect(_on_zone_enter)
	interact_area.body_exited.connect(_on_zone_exit)

func _on_zone_enter(body):
	if body is Player:
		player = body
		player_near = true

func _on_zone_exit(body):
	if body is Player:
		player_near = false

func _process(delta):
	if player_near and not is_opened and Input.is_action_just_pressed("interact"):
		open_chest()

func open_chest():
	is_opened = true
	player.inv.insert(key_item)

	var notif = get_tree().current_scene.get_node("NotificationUI")
	notif.show_notification("Chest opened! You found a key.")

	chest_sprite.visible = false
	collision.disabled = true
