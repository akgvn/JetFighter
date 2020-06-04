extends Node

var fullscreen := true
var _pressed := false
var high_score := 0
var dead = false
var current_score := 0
var begin := false

# Called when the node enters the scene tree for the first time.
func _ready():
	self.load_highscore()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	self.pause_mode = Node.PAUSE_MODE_PROCESS


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_released("pause_button") and not self.dead:
		get_tree().paused = not get_tree().paused

	# TODO Use a general action from Godot setting instead of a key.
	if self._key_f_released():
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

# TODO This should be deleted when action thing is added.
func _key_f_released() -> bool:
	if Input.is_key_pressed(KEY_F):
		self._pressed = true
	elif (self._pressed == true):
		self._pressed = false
		return true
	return false
