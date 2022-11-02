extends Node2D
class_name Boom

var particles: CPUParticles2D

func init(pos: Vector2):
	self.position = pos
	particles = $CPUParticles2D

	particles.one_shot = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if not (particles.emitting):
		self.queue_free()
