extends CharacterBody2D


const SPEED = 300.0

enum states {
	moving,
	possessing,
}

var player_state : states = states.moving

func _physics_process(delta: float) -> void:
	match player_state:
		states.moving:
			modulate = Color(1.0, 1.0, 1.0, 1)
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
			if Input.is_action_just_pressed("Possess"):
				if globals.selected_object:
					globals.selected_object.active = true
					globals.active_object = globals.selected_object
					player_state = states.possessing
					
		states.possessing:
			modulate = Color(1.0, 1.0, 1.0, 0.298)
			if Input.is_action_just_pressed("Possess"):
				if globals.selected_object == null:
					globals.active_object.active = false
					player_state = states.moving

	move_and_slide()
