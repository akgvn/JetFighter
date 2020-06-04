extends Node2D
class_name Boom

func init(pos: Vector2):
	self.position = pos
	$CPUParticles2D.one_shot = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if not ($CPUParticles2D.emitting):
		self.queue_free()
