extends Control

@onready var inv : Inv = preload("res://inventory/playerInventory.tres")
@onready var slots : Array = $NinePatchRect/GridContainer.get_children() 


func _ready():
	print("UI inv instance: ", inv.get_instance_id())
	inv.update.connect(update_slot)
	self.visible = true
	update_slot()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_inventory"):
		self.visible = !self.visible

func update_slot():
	print("update_slot appelé")
	for i in range(min(inv.slots.size(),slots.size())):
		slots[i].update(inv.slots[i])
