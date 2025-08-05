extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var active : bool = false
var selected : bool = false

func _ready() -> void:
	input_pickable = true

func _process(delta: float) -> void:
	if selected:
		modulate = Color(0.0, 1.0, 0.0)
	else:
		modulate = Color(1, 1, 1)
	
func _physics_process(delta: float) -> void:
	if active:
		# Add the gravity.
		# Handle jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var x_direction := Input.get_axis("ui_left", "ui_right")
		if x_direction:
			velocity.x = x_direction * SPEED
		else:
			velocity.x = 0	
		
		var y_direction := Input.get_axis("ui_up", "ui_down")
		if y_direction:
			velocity.y = y_direction * SPEED
		else:
			velocity.y = 0	

		move_and_slide()


func _on_mouse_entered() -> void:
	selected = true
	globals.selected_object = self

func _on_mouse_exited() -> void:
	selected = false
	globals.selected_object = null
