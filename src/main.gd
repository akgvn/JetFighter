extends Node2D

@onready var over = $HUD/Game_Over
@onready var score_label = $HUD/Score
@onready var high_score_label = $HUD/High_Score

# Called when the node enters the scene tree for the first time.
func _ready():
	over.visible = false
	Global.update_window_size()
	Global.dead = false
	score_label.visible = true
	Global.current_score = 0
	high_score_label.text = "High Score: " + Global.get_highscore()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if not Global.begin:
		$HUD/Start.visible = true

	if score_label and not Global.dead:
		score_label.text = "Score: " + Global.current_score
		if Global.current_score > Global.high_score:
			high_score_label.text = "High Score: " + Global.get_highscore()
		
	var player = $Player
	if player == null:
		Global.dead = true
		over.visible = true
		Global.save_highscore()
	else:
		player.position.x = clamp(player.position.x, 90.0, 320.0)
		player.position.y = clamp(player.position.y, 64.0, 640.0)
	
	if Input.is_action_pressed("ui_accept"):
		$HUD/Start.hide()
		Global.begin = true
	if Input.is_key_pressed((KEY_R)): 
		# Restart everything
		Global.save_highscore()
		get_tree().reload_current_scene()



