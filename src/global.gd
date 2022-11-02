extends Node

var fullscreen := true
var _pressed := false
var high_score := 0
var dead = false
var current_score := 0
var begin := false
@onready var paused_label = get_tree().get_current_scene().get_node("HUD/Paused")
var rng = RandomNumberGenerator.new()

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
		OS.set_window_fullscreen(self.fullscreen)

	# UI cancel is ESC in keyboard, or B in Xinput. Might change this later.
	if Input.is_action_pressed("ui_cancel"):
		self.save_highscore()
		get_tree().quit()

func get_highscore() -> int:
	if self.current_score > self.high_score:
		self.high_score = self.current_score
	return self.high_score

func save_highscore():
	var file = File.new()
	file.open("user://score.dat", File.WRITE)
	file.store_16(self.high_score)
	file.close()

func load_highscore():
	var file = File.new()
	var hs := 0
	if file.file_exists("user://score.dat"):
		file.open("user://score.dat", File.READ)
		hs = file.get_16()
		file.close()
	self.high_score = hs
