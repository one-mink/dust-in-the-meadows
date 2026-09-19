
extends Panel

@onready var item_display: Sprite2D = $CenterContainer/Panel/Item_display
@onready var amount_text: Label = $CenterContainer/Panel/Label

func update(slot: InvSlot):
	if !slot.item:
		print("slot vide")
		item_display.visible = false
		amount_text.visible = false
	else:
		print("slot rempli avec texture =", slot.item.texture, " amount =", slot.amount)
		item_display.visible = true
		item_display.texture = slot.item.texture
		if slot.amount > 1:
			amount_text.visible = true 
			amount_text.text = str(slot.amount)
