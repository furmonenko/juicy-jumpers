extends Node2D

func play_sound(sfx :AudioStreamPlayer2D):
	var new_sfx = AudioStreamPlayer2D.new()
	new_sfx = sfx
	new_sfx.play()
