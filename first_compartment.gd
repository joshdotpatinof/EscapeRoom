extends Node2D

@onready var lock = $lock
@onready var unlock = $unlock

func _ready():
	# Check the flag
	if Global.unlock_flag:
		_on_unlock_box()
	


func _on_unlock_box():
	lock.visible = false
	unlock.visible = true

