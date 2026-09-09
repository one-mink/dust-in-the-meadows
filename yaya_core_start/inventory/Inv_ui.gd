extends Control

@onready var inv : Inv = preload("res://inventory/playerInventory.tres")
@onready var slots : Array = $NinePatchRect/GridContainer.get_children() 


func _ready() -> void:
	self.visible = true
	update_slot()
func _process(_delta: float) -> void:
	update_slot()
func update_slot():
	for i in range(min(inv.item.size(),slots.size())):
		slots[i].update(inv.item[i])
