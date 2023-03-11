extends Node2D

const LEFT = Vector2(-1, 0)
const RIGHT = Vector2(1, 0)
const STOP = Vector2(0, 0)

const STARTING_ZOOM = 4
const MAX_ZOOM_OUT = 1.2

var playing
var game_time

const GAME_TIME_LIMIT = 10
const ZOOM_INCREMENT = (STARTING_ZOOM - MAX_ZOOM_OUT) / GAME_TIME_LIMIT

# Called when the node enters the scene tree for the first time.
func _ready():
	playing = false
	game_time = 0
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	game_time += delta
	$camera.zoom = Vector2(ZOOM_INCREMENT, ZOOM_INCREMENT) * game_time / GAME_TIME_LIMIT

func _input(event):
	if event.is_action_pressed("user_input"):
		if playing:
			$player.fire()
		else:
			$player.move(LEFT)
			$opponent.move(RIGHT)
			playing = true

