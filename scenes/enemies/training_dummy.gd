extends CharacterBody2D

@export var max_health: int = 100
var health: int

func _ready():
	health = max_health
	print(health)
	
func take_damage(amount: int):
	health -= amount
	print(health)
	
	if health <= 0:
		queue_free()
