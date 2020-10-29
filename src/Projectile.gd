extends KinematicBody2D
class_name Projectile

var _direction: Vector2
export (int) var speed := 750
var is_enemy = false

func init(pos: Vector2, direction: Vector2, is_enemy := false):
	self.position = pos

	if is_enemy: self.scale.x = -1
	self.rotation_degrees = rad2deg(atan(direction.y / direction.x))
	self._direction = direction
	if is_enemy: 
		self.is_enemy = true
		self.set_collision_layer(8)
		self.set_collision_mask_bit(0, true)
		self.set_collision_mask_bit(2, false)
	else: self.set_collision_layer(2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var collision_info = move_and_collide(_direction * speed * delta)
	if collision_info:
		var body := instance_from_id(collision_info.get_collider_id())
		if not is_enemy and body.name == "Player":
			return
		if "Enemy" in body.name and is_enemy:
			assert(false)
			return
		self._new_explosion(self.position)
		self._new_explosion(body.position)
		if "Enemy" in body.name:
			body.dead = true
			Global.current_score += 1
		body.queue_free()
		queue_free()
	else: pass

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	self.queue_free()

func _new_explosion(pos: Vector2):
	var explosion: Boom = load("res://src/Boom.tscn").instance()
	explosion.init(pos)
	get_parent().add_child(explosion)
