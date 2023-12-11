extends CharacterBody2D

var speed = 20
var moving
const LEFT = Vector2(-1, 0)
const RIGHT = Vector2(1, 0)
const STOP = Vector2(0, 0)

var direction_facing

func _ready():
	moving = false
	
func _physics_process(delta):
	if moving:
		move_and_slide()

func turn(direction):
	direction_facing = direction
	$sprite.scale.x = direction.x
	
func move(direction):
	velocity = direction * speed
	moving = true
	
	$sprite.play("walk")
	turn(direction)
	
func stop():
	velocity = STOP
	moving = false
	
func fire():
	if moving:
		stop()
		turn(direction_facing * -1)
		$sprite.play("shoot")

func die():
	if moving:
		stop()
	$sprite.play("death")

func default_pose():
	$sprite.play("idle")
