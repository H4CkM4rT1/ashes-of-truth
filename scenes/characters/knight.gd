extends CharacterBody2D

var speed: float = 150.0
var last_direction: Vector2 = Vector2.DOWN
var dash_speed: float = 600.0
var dash_duration: float = 0.15
var dash_timer: float = 0.0
var is_dashing: bool = false
var dash_direction: Vector2 = Vector2.ZERO
var dash_cooldown: float = 0.5
var cooldown_timer: float = 0.0

func _physics_process(delta):
	if cooldown_timer > 0:
		cooldown_timer -= delta
	var direction: Vector2 = Input.get_vector("move_left","move_right","move_up","move_down")
	if direction != Vector2.ZERO:
		last_direction = direction
	if Input.is_action_just_pressed("dash") and not is_dashing and cooldown_timer <= 0:
		is_dashing = true
		dash_timer = dash_duration
		dash_direction = last_direction
	if is_dashing:
		velocity = dash_direction * dash_speed
		dash_timer -= delta
		
		if dash_timer <= 0:
			is_dashing = false
			cooldown_timer = dash_cooldown
			
	else:
		velocity = direction * speed
	move_and_slide()
