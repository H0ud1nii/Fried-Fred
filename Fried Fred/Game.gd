extends Node2D

func _ready():
	_update_time_label($WaveTimer.wait_time)

func _process(delta):
	_update_time_label($WaveTimer.time_left)

func _on_end_game_timer_timeout():
	%YouWon.visible = true
	get_tree().paused = true


func _on_player_player_died():
	%GameOver.visible = true
	get_tree().paused = true

func _update_time_label(time_left):
	var minutes = int(time_left) / 60
	var seconds = int(time_left) % 60
	var formatted_time = str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2)
	$HUD.update_wave_timer(formatted_time)

func _on_wave_timer_timeout():
	$HUD.open_shop()
