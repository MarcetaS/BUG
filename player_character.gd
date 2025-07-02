extends CharacterBody3D
#Eigenkommentare (Notizen)
#Formation is KEY!! - Without formatting there will be issues
#Test: Tab line 33 (jump function) and see that jumping won't work anymore


#Variables are created here
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") #Garvity is using the default GoDot Grav.
var speed = 8.0  # movement speed
var jump_speed = 6.0  # determines jump height
var mouse_sensitivity = 0.002  # turning speed

#Mouse
#Mouse Cursor fix and unfix in window
func _ready() -> void: 
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	# Press ESC -> Make Pointer Visible
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	# LeftClick -> Catch the mouse in Window
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

#This will convert any mouse motion in the x direction into a rotation around the y axis.
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)
		#Adds Jumping
	if event.is_action_pressed("jump") and is_on_floor():
			velocity.y = jump_speed


#Movement
func get_input():
	var input = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var movement_dir = transform.basis * Vector3(input.x, 0, input.y)
	velocity.x = movement_dir.x * speed
	velocity.z = movement_dir.z * speed

#The code in _physics_process() is pretty straightforward: 
#add gravity to accelerate in the positive Y direction (downward), 
#call get_input() to check for input, 
#and then use move_and_slide() to move in the direction of the velocity vector.
func _physics_process(delta):
	velocity.y += -gravity * delta
	get_input()
	move_and_slide()
	
