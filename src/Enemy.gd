extends CharacterBody2D
class_name Enemy

@onready var rc: RayCast2D = $RayCast2D
@onready var timer: Timer = $Timer
var fired = false
var dead = false
var is_random_direction = false
@export var enemy_movement_speed: int = 150
@export var degree: int = 0 # For the vertical degree constraints.

func init(pos: Vector2, current_score: int):
	self.position = pos
	
	# Make the game harder progressively.
	if current_score > 10: timer.wait_time = 0.75
	elif current_score > 15: self.is_random_direction = true
	elif current_score > 20: timer.wait_time = 0.50


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var dir = Vector2(-1 * enemy_movement_speed, 0)
	set_velocity(dir * delta * 60)
	move_and_slide()
	
	var body = rc.get_collider()
	if fired and (timer.time_left < 0.1):
		fired = false
	if body and (body.name == "Player") and (not fired) and $VisibleOnScreenNotifier2D.is_on_screen():
		var origin: Vector2 = rc.global_transform.origin
		var collision_point: Vector2 = rc.get_collision_point()
		var distance = origin.distance_to(collision_point)
		
		var pr: Projectile = load("res://src/Projectile.tscn").instantiate()
		var pos = self.position
		pos.y += 15
		pos.x -= 70

		var vertical_direction: float = 0
		var horizontal_direction: float = -1

		var min_distance = 100 # TODO Find a optimal value for this by playtesting!
		if is_random_direction and distance > min_distance:
			vertical_direction = Global.rng.randf_range(-0.3, 0.3)

		var pr_direction = Vector2(horizontal_direction, vertical_direction)
		pr.init(pos, pr_direction, true)
		get_parent().add_child(pr)
		self.fired = true
		timer.start()

# If the enemy gets past the player, decrement their score.
func _on_VisibilityNotifier2D_screen_exited():
	if not dead: Global.current_score -= 1
	self.queue_free()
