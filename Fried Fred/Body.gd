extends Node2D

func play_idle_animation():
	%AnimationPlayer.play("Idle_Stand")
	
func play_walk_animation():
	%AnimationPlayer.play("Walk")
