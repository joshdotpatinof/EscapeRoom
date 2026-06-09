extends VBoxContainer

# Reference to the Label node
@onready var code_display = $CodeDisplay
@onready var one = $Row1/btn1
@onready var two = $Row1/btn2
@onready var three = $Row1/btn3
@onready var four = $Row2/btn4
@onready var five = $Row2/btn5
@onready var six = $Row2/btn6
@onready var seven = $Row3/btn7
@onready var eight = $Row3/btn8
@onready var nine = $Row3/btn9
@onready var clear = $Row4/btnX
@onready var zero = $Row4/btn0
@onready var enter = $Row4/btnenter

@onready var sfx = preload("res://addons/kenney_ui_audio/switch4.wav")

# The maximum number of digits for the code
const MAX_CODE_LENGTH = 4

# Variable to store the entered code
var entered_code = ""

# The correct code for this keypad
@export var correct_code = "8113"

# Variable to track if the code is correct
var code_correct = false

func _ready():
	# Initialize the display
	update_display()
	one.connect("pressed", _on_one_pressed)
	two.connect("pressed", _on_two_pressed)
	three.connect("pressed", _on_three_pressed)
	four.connect("pressed", _on_four_pressed)
	five.connect("pressed", _on_five_pressed)
	six.connect("pressed", _on_six_pressed)
	seven.connect("pressed", _on_seven_pressed)
	eight.connect("pressed", _on_eight_pressed)
	nine.connect("pressed", _on_nine_pressed)
	clear.connect("pressed", _on_clear_pressed)
	zero.connect("pressed", _on_zero_pressed)
	enter.connect("pressed", _on_enter_pressed)

func _on_one_pressed():
	AudioPlayer.play_fx(sfx)
	_on_key_pressed(1)

func _on_two_pressed():
	AudioPlayer.play_fx(sfx)
	_on_key_pressed(2)

func _on_three_pressed():
	AudioPlayer.play_fx(sfx)
	_on_key_pressed(3)

func _on_four_pressed():
	AudioPlayer.play_fx(sfx)
	_on_key_pressed(4)

func _on_five_pressed():
	AudioPlayer.play_fx(sfx)
	_on_key_pressed(5)

func _on_six_pressed():
	AudioPlayer.play_fx(sfx)
	_on_key_pressed(6)

func _on_seven_pressed():
	AudioPlayer.play_fx(sfx)
	_on_key_pressed(7)

func _on_eight_pressed():
	AudioPlayer.play_fx(sfx)
	_on_key_pressed(8)

func _on_nine_pressed():
	AudioPlayer.play_fx(sfx)
	_on_key_pressed(9)

func _on_zero_pressed():
	AudioPlayer.play_fx(sfx)
	_on_key_pressed(0)

func _on_clear_pressed():
	AudioPlayer.play_fx(sfx)
	if not code_correct:
		entered_code = ""
		update_display()

func _on_enter_pressed():
	AudioPlayer.play_fx(sfx)
	if not code_correct:
		process_code()

func _on_key_pressed(number):
	if not code_correct:
		# Add the pressed number to the code if it's not full
		if entered_code.length() < MAX_CODE_LENGTH:
			entered_code += str(number)
			update_display()

func update_display():
	if code_correct:
		code_display.text = "DONE"
	else:
		# Update the Label text to show the entered code
		var display_text = entered_code
		while display_text.length() < MAX_CODE_LENGTH:
			display_text += "-"
		code_display.text = display_text

func process_code():
	# Handle the completed code here (e.g., validate it)
	if entered_code == correct_code:
		print("Correct code.")
		code_correct = true
		correct_code_verified()
	else:
		print("Incorrect code.")
	
	# Clear the entered code after processing
	entered_code = ""
	update_display()

func correct_code_verified():
	print("Keypad - Signal emitted")
	# Set the flag
	Global.unlock_flag = true

	# Set the display to "DONE" and disable further input
	update_display()
	disable_buttons()

func disable_buttons():
	one.disabled = true
	two.disabled = true
	three.disabled = true
	four.disabled = true
	five.disabled = true
	six.disabled = true
	seven.disabled = true
	eight.disabled = true
	nine.disabled = true
	clear.disabled = true
	zero.disabled = true
	enter.disabled = true
