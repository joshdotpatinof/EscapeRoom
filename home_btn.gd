extends Area2D

@export var escape = preload("res://escape.tscn")
@onready var sfx_button_click = preload("res://addons/kenney_ui_audio/click4.wav")

# This function will be connected to the input_event signal
func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("You selected:", self.name)
		AudioPlayer.play_fx(sfx_button_click)
		get_tree().change_scene_to_packed(escape) # Escape room

# This function is called when the node enters the scene tree
func _ready():
	# Connect the input_event signal to the _on_Area2D_input_event function using a Callable
	connect("input_event", Callable(self, "_on_Area2D_input_event"))
	
	# Connect the mouse_entered and mouse_exited signals
	connect("mouse_entered", Callable(self, "_on_Area2D_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_Area2D_mouse_exited"))
	
	# Ensure the normal sprite is visible and the hover sprite is hidden initially
	$"home_normal".visible = true
	$"home_hovered".visible = false

# This function is called when the mouse enters the Area2D
func _on_Area2D_mouse_entered():
	print("Mouse entered")
	$"home_normal".visible = false
	$"home_hovered".visible = true

# This function is called when the mouse exits the Area2D
func _on_Area2D_mouse_exited():
	print("Mouse exited")
	$"home_normal".visible = true
	$"home_hovered".visible = false
