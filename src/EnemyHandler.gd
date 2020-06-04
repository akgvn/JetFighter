extends Node

var current_score := 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	current_score = Global.current_score
	if current_score > 20:
		$Timer.wait_time = 1.5
	elif current_score > 50:
		$Timer.wait_time = 1.1
	elif current_score > 100:
		$Timer.wait_time = 0.9
	
func _on_Timer_timeout():
	if not Global.begin:
		return
	var x = randi() % 500 + 1280
	var y = randi() % 600 + 64
	var e: Enemy = load("res://src/Enemy.tscn").instance()
	e.init(Vector2(x, y), current_score)
	add_child(e)
