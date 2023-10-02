extends Node2D

# @onready var background_music = load("res://Sounds/lady-of-the-80x27s-128379.mp3")

func play_sound(sfx :AudioStreamPlayer2D):
	var new_sfx = AudioStreamPlayer2D.new()
	new_sfx = sfx
	new_sfx.play()
