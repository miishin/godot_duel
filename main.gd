extends Node2D

const LEFT = Vector2(-1, 0)
const RIGHT = Vector2(1, 0)
const STOP = Vector2(0, 0)
const STARTING_ZOOM = Vector2(4, 4)
const MAX_ZOOM_OUT = Vector2(1.2, 1.2)
const GAME_TIME_LIMIT = 10

var playing
var game_time
var zoom_tween

var opponent_alive

# Called when the node enters the scene tree for the first time.
func _ready():
	playing = false
	game_time = 0
	$camera.zoom = STARTING_ZOOM
	
	zoom_tween = get_tree().create_tween()
	zoom_tween.tween_property($camera, "zoom", MAX_ZOOM_OUT, GAME_TIME_LIMIT).from_current()
	zoom_tween.pause()
	
	opponent_alive = true
	
func _process(delta):
	if playing:
		game_time += delta
		
func _input(event):
	if event.is_action_pressed("user_input"):
		if playing:
			zoom_tween.kill()
			$player.fire()
		else:
			playing = true
			$player.move(LEFT)
			$opponent.move(RIGHT)
			
			zoom_tween.play()

func _end_game():
	playing = false
	$player.stop()
	$opponent.stop()

func _trigger_opponent():
	$opponent.fire()
	
func reset():
	_ready()
