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
var is_attacking: bool = false
@onready var attack_hitbox: Area2D = $AttackHitbox
var attack_duration: float = 0.2
var attack_timer: float = 0.0
var attack_cooldown: float = 0.3
var attack_cooldown_timer: float = 0.0
@export var attack_damage: int = 10


func _physics_process(delta):
	if cooldown_timer > 0:
		cooldown_timer -= delta
	if attack_cooldown_timer > 0:
		attack_cooldown_timer -= delta
	var direction: Vector2 = Input.get_vector("move_left","move_right","move_up","move_down")
	if direction != Vector2.ZERO:
		last_direction = direction
	if Input.is_action_just_pressed("dash") and not is_dashing and cooldown_timer <= 0 and not is_attacking:
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
	if Input.is_action_just_pressed("attack") and not is_dashing and not is_attacking and attack_cooldown_timer <= 0:
		is_attacking = true
		attack_timer = attack_duration
		attack_hitbox.rotation = last_direction.angle()
		attack_hitbox.monitoring = true
		
	if is_attacking:
		attack_timer -= delta
			
		if attack_timer <= 0:
			is_attacking = false
			attack_hitbox.monitoring = false
			attack_cooldown_timer = attack_cooldown
		
	move_and_slide()


func _on_attack_hitbox_area_entered(area: Area2D) -> void:
	var enemy = area.get_parent()
	print("Impacto detectado")
	print(area.name)
	
	if enemy.has_method("take_damage"):
		print("menos vida")
		enemy.take_damage(attack_damage)
