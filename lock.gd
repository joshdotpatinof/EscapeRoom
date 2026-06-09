extends Area2D

@export var lock_game = preload("res://lock_game.tscn")
@onready var sfx = preload("res://audio/metal-clang-sound-81634.mp3")

# This function will be connected to the input_event signal
func _on_Area2D_input_event(viewport, event, shape_idx):
	# Unused parameters: viewport, event, shape_idx
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("You selected:", self.name)
		AudioPlayer.play_fx(sfx)
		get_tree().change_scene_to_packed(lock_game)
		
# This function is called when the node enters the scene tree
func _ready():
	# Connect the input_event signal to the _on_Area2D_input_event function using a Callable
	connect("input_event", Callable(self, "_on_Area2D_input_event"))
	
	# Connect the mouse_entered and mouse_exited signals
	connect("mouse_entered", Callable(self, "_on_Area2D_mouse_entered"))
	connect("mouse_exited", Callable(self, "_on_Area2D_mouse_exited"))
	
	# Ensure the normal sprite is visible and the hover sprite is hidden initially
	$"lock_normal".visible = true
	$"lock_hovered".visible = false

# This function is called when the mouse enters the Area2D
func _on_Area2D_mouse_entered():
	print("Mouse entered")
	$"lock_normal".visible = false
	$"lock_hovered".visible = true

# This function is called when the mouse exits the Area2D
func _on_Area2D_mouse_exited():
	print("Mouse exited")
	$"lock_normal".visible = true
	$"lock_hovered".visible = false
