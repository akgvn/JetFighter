extends Node

var fullscreen := true
var high_score := 0
var dead = false
var current_score := 0
var begin := false
@onready var paused_label = get_tree().get_current_scene().get_node("HUD/Paused")
var rng = RandomNumberGenerator.new()

func update_window_size():
	if self.fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

# Called when the node enters the scene tree for the first time.
func _ready():
	self.load_highscore()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	paused_label.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_released("pause_button") and not self.dead and self.begin:
		paused_label.visible = not paused_label.visible
		get_tree().paused = not get_tree().paused

	if Input.is_action_just_released("fullscreen_button"):
		self.fullscreen = not self.fullscreen
		self.update_window_size()

	# UI cancel is ESC in keyboard. Might change this later.
	if Input.is_action_pressed("ui_cancel"):
		self.save_highscore()
		get_tree().quit()

func get_highscore() -> int:
	if self.current_score > self.high_score:
		self.high_score = self.current_score
	return self.high_score

func save_highscore():
	var file := FileAccess.open("user://score.dat", FileAccess.WRITE)
	file.store_16(get_highscore())

func load_highscore():
	var hs := 0
	if FileAccess.file_exists("user://score.dat"):
		var file := FileAccess.open("user://score.dat", FileAccess.READ)
		hs = file.get_16()
		print("hs is ", hs)

	self.high_score = hs
