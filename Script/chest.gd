extends StaticBody2D

@onready var chest_sprite: Sprite2D = $GoldChest
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var interac_area: Area2D = $InteractZone

var is_opened = false
var player_near = false

func _ready():
	interac_area.body_entered.connect(_on_zone_enter)
	interac_area.body_exited.connect(_on_zone_exit)
	print("✅ Chest ready — approach and press interact to open")

func _on_zone_enter(body):
	if body.is_in_group("player") and not is_opened:
		player_near = true
		print("📦 Player near chest — PRESS INTERACT TO OPEN")

func _on_zone_exit(body):
	if body.is_in_group("player"):
		player_near = false
		print("📦 Player left chest area")

func _process(_delta):
	if is_opened: return
	
	if Input.is_action_just_pressed("interact") and player_near:
		print("🔘 Interact pressed — opening chest...")
		open_chest()

func open_chest():
	is_opened = true
	print("🎁 OPENING CHEST")
	
	var player = get_tree().get_first_node_in_group("player")
	if player:
		player.has_key = true
		print("🔑 KEY GIVEN TO PLAYER!")
	else:
		print("❌ PLAYER NOT FOUND — check if player is in group 'player'")
	
	chest_sprite.visible = false
	collision.disabled = true
	print("✅ Chest hidden & collision disabled")
