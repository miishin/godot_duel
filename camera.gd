extends Camera2D

var tween

# Called when the node enters the scene tree for the first time.
func _ready():
	tween = get_tree().create_tween()
	
func start_zoom(final_zoom, duration):
	tween.tween_property(self, "zoom", final_zoom, duration)
	
func stop_zoom():
	tween.kill()
