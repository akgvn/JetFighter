extends KinematicBody2D
class_name Enemy

onready var rc: RayCast2D = $RayCast2D
var fired = false
var dead = false
var is_random_direction = false

func init(pos: Vector2, current_score: int):
	self.position = pos
	# Make the game harder
	if current_score > 10: $Timer.wait_time = 0.75
	elif current_score > 1: self.is_random_direction = true
	elif current_score > 20: $Timer.wait_time = 0.50


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var dir = Vector2(-150, 0)
	move_and_slide(dir)
	var body = rc.get_collider()
	if fired and ($Timer.time_left < 0.1):
		fired = false
	if body and (body.name == "Player") and (not fired) and $VisibilityNotifier2D.is_on_screen():
		var pr: Projectile = load("res://src/Projectile.tscn").instance()
		var pos = self.position
		pos.y += 15
		pos.x -= 70
		var vertical_dir = 0
		var degrees = 180

		# FIXME Enemy projectile should go in a reasonable direction. Playtest!
		#if is_random_direction:
		#	vertical_dir = (randi() % 60)
		#	degrees -= vertical_dir
		#	vertical_dir = tan(deg2rad(vertical_dir))

		pr.init(pos, degrees, Vector2(-2, vertical_dir), true)
		get_parent().add_child(pr)
		self.fired = true
		$Timer.start()

# If the enemy gets past the player, decrement their score.
func _on_VisibilityNotifier2D_screen_exited():
	if not dead: Global.current_score -= 1
	self.queue_free()
