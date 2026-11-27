extends CharacterBody2D

@export var max_health: int = 100
var health: int
@onready var sprite: Sprite2D = $Sprite2D
var original_color: Color
@export var knockback_force: float = 180.0
@export var knockback_friction: float = 900.0
var knockback_velocity: Vector2 = Vector2.ZERO

func _ready():
	health = max_health
	print(health)
	original_color = sprite.modulate
	
func take_damage(amount: int, attacker_position: Vector2):
	health -= amount
	
	if health <= 0:
		queue_free()
	
	else: 
		var knockback_direction: Vector2 = (global_position - attacker_position).normalized()
		knockback_velocity = (knockback_direction * knockback_force)
		hit_flash()
		print(knockback_velocity)


func hit_flash():
	sprite.modulate = Color.WHITE
	await get_tree().create_timer(0.1).timeout
	sprite.modulate = original_color
	
func _physics_process(delta):
	velocity = knockback_velocity
	move_and_slide()
	
	knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, knockback_friction * delta)
	
