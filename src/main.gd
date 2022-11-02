extends Node2D

@onready var over: Label = $HUD/Game_Over
@onready var score_label: Label = $HUD/Score
@onready var high_score_label: Label = $HUD/High_Score
@onready var start_hud: Label = $HUD/Start

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
		start_hud.visible = true

	if score_label and not Global.dead:
		score_label.text = "Score: " + String.num_int64(Global.current_score)
		high_score_label.text = "High Score: " + String.num_int64(Global.get_highscore())
		
	var player: Player = $Player
	if player == null:
		Global.dead = true
		over.visible = true
		Global.save_highscore()
	else:
		player.position.x = clamp(player.position.x, 90.0, 320.0)
		player.position.y = clamp(player.position.y, 64.0, 640.0)
	
	if Input.is_action_pressed("ui_accept"):
		start_hud.hide()
		Global.begin = true
	if Input.is_key_pressed((KEY_R)): 
		# Restart everything
		Global.save_highscore()
		get_tree().reload_current_scene()



