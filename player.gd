extends CharacterBody2D

var speed = 20
var moving
const LEFT = Vector2(-1, 0)
const RIGHT = Vector2(1, 0)
const STOP = Vector2(0, 0)

var direction_facing

func _ready():
	#$sprite.loop = true
	moving = false
	direction_facing = LEFT
	
func _physics_process(delta):
	if moving:
		move_and_slide()

func turn(direction):
	direction_facing = direction
	$sprite.scale.x = direction.x
	
func move(direction):
	turn(direction)
		
	velocity = direction * speed
	moving = true
	
	$sprite.play("walk")
	
func stop():
	velocity = STOP
	moving = false
	
func fire():
	if moving:
		moving = false
		velocity = Vector2(0, 0)
		turn(direction_facing * -1)
		$sprite.play("shoot")

func die():
	if moving:
		stop()
	$sprite.play("death")
