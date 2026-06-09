extends Node2D

@onready var arrow1 = $ARROWS/arrow1
@onready var arrow2 = $ARROWS/arrow2
@onready var arrow3 = $ARROWS/arrow3
@onready var arrow4 = $ARROWS/arrow4
@onready var label = $Display 
@onready var arrow_click = preload("res://addons/kenney_ui_audio/mouseclick1.wav")
@onready var success = preload("res://audio/mixkit-quick-win-video-game-notification-269.wav")

var correct_orientations = [
	90,   # Arrow1 should point right
	180,  # Arrow2 should point down
	45,   # Arrow3 should point top-right
	225   # Arrow4 should point down-left
]

var arrows = [arrow1, arrow2, arrow3, arrow4]
var arrow_states = [false, false, false, false]  # Keeps track of each arrow's correct orientation state

func _ready():
	# Initial check
	if Global.is_success:
		label.text = "Success! You received: 5 [Squares]"
		arrow1.rotation_degrees = 90
		arrow2.rotation_degrees = 180
		arrow3.rotation_degrees = 45
		arrow4.rotation_degrees = 225
		disconnect_arrows_input_events()
	else:
		label.text = "Align arrows to unlock the code."
		
		# Ensure arrows are not null
		assert(arrow1 != null, "Arrow1 is null")
		assert(arrow2 != null, "Arrow2 is null")
		assert(arrow3 != null, "Arrow3 is null")
		assert(arrow4 != null, "Arrow4 is null")
		
		# Connect input_event signals for each arrow to their respective functions
		arrow1.connect("input_event", _on_Arrow1_input_event)
		arrow2.connect("input_event", _on_Arrow2_input_event)
		arrow3.connect("input_event", _on_Arrow3_input_event)
		arrow4.connect("input_event", _on_Arrow4_input_event)

# Function to handle input event for arrow1
func _on_Arrow1_input_event(viewport, event, shape_idx):
	handle_input_event(arrow1, event, 0)

# Function to handle input event for arrow2
func _on_Arrow2_input_event(viewport, event, shape_idx):
	handle_input_event(arrow2, event, 1)

# Function to handle input event for arrow3
func _on_Arrow3_input_event(viewport, event, shape_idx):
	handle_input_event(arrow3, event, 2)

# Function to handle input event for arrow4
func _on_Arrow4_input_event(viewport, event, shape_idx):
	handle_input_event(arrow4, event, 3)

# Function to rotate the arrow and check orientation
func handle_input_event(arrow, event, index):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		rotate_arrow(arrow, index)
		check_orientation(index)

# Function to rotate the arrow to the next allowable orientation
func rotate_arrow(arrow, index):
	print("ARROW ROTATED!")
	AudioPlayer.play_fx(arrow_click)
	var current_rotation = arrow.rotation_degrees if arrow else 0
	var next_rotation = (int(current_rotation) + 45) % 360
	arrow.rotation_degrees = next_rotation

# Function to check if an arrow has the correct orientation
func check_orientation(index):
	print("ORIENTATION BEING CHECKED!")
	
	var arrow
	
	if index == 0:
		arrow = arrow1
	elif index == 1:
		arrow = arrow2
	elif index == 2:
		arrow = arrow3
	elif index == 3:
		arrow = arrow4
	else:
		print("Error: Invalid index provided!")
		return
	
	var current_rotation = int(arrow.rotation_degrees) % 360
	if current_rotation == 360:
		current_rotation = 0
		
	var correct_rotation = correct_orientations[index]
	print("Current Rotation:", current_rotation)
	print("Correct Rotation:", correct_rotation)
		
	if current_rotation == correct_rotation:
		arrow_states[index] = true
	else:
		arrow_states[index] = false
	
	update_label()

# Function to update the label based on arrow states
func update_label():
	var all_correct = true
	for state in arrow_states:
		if not state:
			all_correct = false
			break

	if all_correct:
		AudioPlayer.play_fx(success)
		label.text = "Success! You received: 5 [Squares]"
		Global.is_success = true
		disconnect_arrows_input_events()
	else:
		label.text = "Incorrect Code Sequence. X"
	
	# Debug print to check arrow states
	print("Arrow States:", arrow_states)

# Disconnect input events for all arrows
func disconnect_arrows_input_events():
	arrow1.disconnect("input_event", _on_Arrow1_input_event)
	arrow2.disconnect("input_event", _on_Arrow2_input_event)
	arrow3.disconnect("input_event", _on_Arrow3_input_event)
	arrow4.disconnect("input_event", _on_Arrow4_input_event)
