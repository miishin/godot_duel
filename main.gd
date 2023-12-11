extends Node2D

const LEFT = Vector2(-1, 0)
const RIGHT = Vector2(1, 0)
const STOP = Vector2(0, 0)
const STARTING_ZOOM = Vector2(4, 4)
const MAX_ZOOM_OUT = Vector2(1.2, 1.2)
const GAME_TIME_LIMIT = 10
const PLAYER_POSITION = Vector2(-50, 40)
const OPPONENT_POSITION = Vector2(50, 40)

var playing
var zoom_tween
var rng
var player_alive
var opponent_alive

var score


func _ready():
	score = 0
	$score.text = "Score: 0"
	rng = RandomNumberGenerator.new()
	$timer.connect("timeout", _reset)
	_reset()
		
func _reset():
	playing = false
	$camera.zoom = STARTING_ZOOM
	
	zoom_tween = get_tree().create_tween()
	zoom_tween.tween_property($camera, "zoom", MAX_ZOOM_OUT, GAME_TIME_LIMIT).from_current()
	zoom_tween.pause()
	
	player_alive = true
	opponent_alive = true
	$player.position = PLAYER_POSITION
	$opponent.position = OPPONENT_POSITION
	$player.default_pose()
	$opponent.default_pose()
	$player.turn(RIGHT)
	# I do not know why this makes opponent face LEFT
	$opponent.turn(RIGHT)
	
func _process(delta):
	if playing:
		if rng.randf() < (-log($timer.time_left)/2) + 0.5 and opponent_alive:
			_trigger_opponent()

func _input(event):
	if event.is_action_pressed("user_input"):
		if playing and player_alive:
			$player.fire()
			opponent_alive = false
			_end_game($opponent)
			print($timer.get_time_left())
			score += int(10 - $timer.time_left)
			$score.text = "Score: " + str(score)
		else:
			playing = true
			$player.move(LEFT)
			# Again, I don't know why I need to flip it for it to look right
			$opponent.move(RIGHT)
			$opponent.turn(LEFT)
			zoom_tween.play()
			$timer.start(10.0)

func _end_game(loser):
	zoom_tween.kill()
	playing = false
	$player.stop()
	$opponent.stop()
	loser.die()
	$timer.stop()
	await get_tree().create_timer(1.0).timeout
	_reset()

func _trigger_opponent():
	$opponent.fire()
	player_alive = false
	_end_game($player)
	score = 0
	$score.text = "Score: " + str(score)

