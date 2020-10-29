extends Node

export(float) var cloud1_speed := 1.1
export(float) var cloud2_speed := 0.7
export(float) var cloud3_speed := 0.3

var mountain_speed := 1.6

# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$"Cloud 1".move_local_x(-cloud1_speed)
	$"Cloud 2".move_local_x(-cloud2_speed)
	$"Cloud 3".move_local_x(-cloud3_speed)
	$"Mountains/m1".move_local_x(-mountain_speed)
	$"Mountains/m2".move_local_x(-mountain_speed)
	$"Mountains/m3".move_local_x(-mountain_speed)

func _on_VisibilityNotifier2D_screen_exited(cloud_num: int):
	if cloud_num == 1: $"Cloud 1".position.x = 1600
	if cloud_num == 2: $"Cloud 2".position.x = 1600
	if cloud_num == 3: $"Cloud 3".position.x = 1600

func _mountain_out(mountain_num: int):
	var offset := (0.473 * 1920) # FIXME Just get the scale and width of the mountain dynamically
	var move: int
	if mountain_num == 1:
		move = $"Mountains/m3".position.x
		$"Mountains/m1".position.x = move + offset
	if mountain_num == 2:
		move = $"Mountains/m1".position.x
		$"Mountains/m2".position.x = move + offset
	if mountain_num == 3:
		move = $"Mountains/m2".position.x
		$"Mountains/m3".position.x = move + offset
