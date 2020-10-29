extends KinematicBody2D

const zero_rot := 0.0
var rot := zero_rot
onready var timer = $Timer
var fired = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var movement_vector := Vector2.ZERO
	var speed = 7 * 70 # 75 is for delta thing

	if Input.is_action_pressed("ui_up"):
		movement_vector.y = -1
		rot = -25

	if Input.is_action_pressed("ui_down"):
		movement_vector.y = 1
		rot = 25

	if rot != zero_rot:
		if not (Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down")):
			rot = lerp(rot, zero_rot, 0.1)

	if Input.is_action_pressed("ui_left"):
		movement_vector.x = -1

	if Input.is_action_pressed("ui_right"):
		movement_vector.x = 1
		rot = 0
		$CPUParticles2D.emitting = true
	else:
		$CPUParticles2D.emitting = false
	
	if Input.is_action_just_released("ui_accept"):
		self._fire_projectile()
	
	self.rotation_degrees = lerp(self.rotation_degrees, rot, 0.15)
	
	movement_vector = movement_vector.normalized()

	var collision_info := move_and_collide(movement_vector * speed * delta)

	if collision_info:
		var body := instance_from_id(collision_info.get_collider_id())
		if "Enemy" in body.name: # FIXME Find a better way to do this.
			var explosion: Boom = load("res://src/Boom.tscn").instance()
			explosion.init(self.position)
			get_parent().add_child(explosion)
			
			body.queue_free()
			queue_free()
		else: pass
	else: pass

func _fire_projectile():
	if fired and timer.is_stopped():
		fired = false

	if not fired:
		var pr: Projectile = load("res://src/Projectile.tscn").instance()
		var pos := Vector2(self.position.x, self.position.y + 45)
		var vertical_speed = tan(deg2rad(self.rotation_degrees))
		pr.init(pos, Vector2(1, vertical_speed))
		get_parent().add_child(pr)
		fired = true
		timer.start()
