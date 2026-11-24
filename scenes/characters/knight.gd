extends CharacterBody2D
var speed: float = 150.0

func _physics_process(_delta):
	var direction: Vector2 = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction * speed
	move_and_slide()
