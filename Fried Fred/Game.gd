extends Node2D

func _ready():
	_update_time_label($WaveTimer.wait_time)

func _process(delta):
	_update_time_label($WaveTimer.time_left)

func trigger_win():
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
	$HUD.start_wave_end()

func _on_restart_pressed():
	get_tree().paused = false
	get_node("/root/Main").restart_game()

func _on_main_menu_pressed():
	get_tree().paused = false
	get_node("/root/Main").go_to_main_menu()

func _on_quit_pressed():
	get_tree().quit()
