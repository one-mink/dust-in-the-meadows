extends StaticBody2D

@onready var l_door: Sprite2D = $LDoor
@onready var door_collision: CollisionShape2D = $Doorstate
@onready var interact_area: Area2D = $InteractArea

var player = null
var player_near = false
var is_unlocked = false

func _ready():
	interact_area.body_entered.connect(_on_enter)
	interact_area.body_exited.connect(_on_exit)

func _on_enter(body):
	if body is Player:
		player = body
		player_near = true

func _on_exit(body):
	if body is Player:
		player_near = false

func _process(delta):
	if player_near and not is_unlocked and Input.is_action_just_pressed("interact"):
		_try_unlock()

func _try_unlock():
	for slot in player.inv.slots:
		if slot.item != null and slot.item.name == "key" and slot.amount > 0:
			slot.amount -= 1
			if slot.amount <= 0:
				slot.item = null
				slot.amount = 0
			player.inv.update.emit()

			is_unlocked = true
			l_door.visible = false
			door_collision.disabled = true

			var notif = get_tree().current_scene.get_node("NotificationUI")
			notif.show_notification("Door unlocked!")
			return

	var notif = get_tree().current_scene.get_node("NotificationUI")
	notif.show_notification("This door is locked. You need a key.")
