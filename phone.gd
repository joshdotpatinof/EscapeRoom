extends Node2D

@onready var phone_lock = $phone_locked
@onready var phone_unlock = $phone_unlocked
@onready var pad = $keypad2

func _ready():
	# Check the flag
	if Global.unlock_phone:
		_on_unlock_phone()
	


func _on_unlock_phone():
	phone_lock.visible = false
	phone_unlock.visible = true
	pad.visible = false
