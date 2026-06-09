class_name MainMenu
extends Control

@onready var start_btn = $MarginContainer/HBoxContainer/VBoxContainer/Start_btn
@onready var exit_btn = $MarginContainer/HBoxContainer/VBoxContainer/Exit_btn
@export var prompt = preload("res://prompt.tscn")
@onready var sfx_ui_click = preload("res://addons/kenney_ui_audio/click4.wav")

func _ready():
	AudioPlayer._play_music_game()
	# Connects the start and exit buttons to the functions
	start_btn.button_down.connect(on_start_pressed)
	exit_btn.button_down.connect(on_exit_pressed)
	
func on_start_pressed() -> void:
	AudioPlayer.play_fx(sfx_ui_click)
	get_tree().change_scene_to_packed(prompt) # Changes the scene to the prompt

func on_exit_pressed() -> void:
	AudioPlayer.play_fx(sfx_ui_click)
	get_tree().quit() # Quits the game
	
