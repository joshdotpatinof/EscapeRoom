extends Button

@export var escape_room = preload("res://main.tscn")
@onready var click_ui = preload("res://addons/kenney_ui_audio/click4.wav")

func _ready():
	# Connect the close button
	connect("pressed", on_close_pressed)

func on_close_pressed() -> void:
	AudioPlayer.play_fx(click_ui)
	get_tree().change_scene_to_packed(escape_room) # Changes the scene to the escape room
