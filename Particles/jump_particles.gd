extends Node2D

func _ready():
	$JumpParticles.emitting = true

func _on_jump_particles_finished():
	queue_free()
