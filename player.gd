extends CharacterBody2D

var speed = 400
var moving
const LEFT = Vector2(-1, 0)
const RIGHT = Vector2(1, 0)
const STOP = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	moving = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("user_input"):
		if not moving:
			moving = true
			velocity = LEFT * speed
	
func _physics_process(delta):
	if moving:
		move_and_slide()

func move(direction):
	if direction.x > 0:
		$sprite.scale.x = 1
	if direction.x < 0:
		$sprite.scale.x = -1
		
	velocity = direction * speed
	moving = true
	
func stop():
	velocity = STOP
	moving = false
	
func fire():
	if moving:
		moving = false
		velocity = Vector2(0, 0)
