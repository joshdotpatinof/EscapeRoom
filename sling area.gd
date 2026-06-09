extends Area2D

@export var sling_view = preload("res://sling_view.tscn")
@onready var sfx = preload("res://addons/kenney_ui_audio/rollover2.wav")

# This function will be connected to the input_event signal
func _on_Area2D_input_event(viewport, event, shape_idx):
	# Unused parameters: viewport, event, shape_idx
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("You selected:", self.name)
		AudioPlayer.play_fx(sfx)
		get_tree().change_scene_to_packed(sling_view) # Switch to sling view

# This function is called when the node enters the scene tree
func _ready():
	# Connect the input_event signal to the _on_Area2D_input_event function using a Callable
	connect("input_event", Callable(self, "_on_Area2D_input_event"))
	
	# Connect the mouse_entered and mouse_exited signals
	connect("mouse_entered", Callable(self, "_on_Area2D_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_Area2D_mouse_exited"))
	
	# Ensure the normal sprite is visible and the hover sprite is hidden initially
	$"sling".visible = true
	$"sling_hovered".visible = false

# This function is called when the mouse enters the Area2D
func _on_Area2D_mouse_entered():
	print("Mouse entered")
	$"sling".visible = false
	$"sling_hovered".visible = true

# This function is called when the mouse exits the Area2D
func _on_Area2D_mouse_exited():
	print("Mouse exited")
	$"sling".visible = true
	$"sling_hovered".visible = false
