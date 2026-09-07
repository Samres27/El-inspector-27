extends Node

@onready var music = $AudioStreamPlayer
var songs = []
var last_song = null

func _ready():
	#load_songs()
	
	music.finished.connect(_on_song_finished)
	songs = [
	preload("res://assets/music/2017_12_Clement Panchout_ Omno_ Contemplative.wav"),
	preload("res://assets/music/Clement Panchout _ Danse Contemporaine.wav"),
	preload("res://assets/music/Clement_Panchout _Fluttering in the Sun.wav"),
	preload("res://assets/music/Clement_Panchout_Gothic Picture_ 2002.wav")
	]
	play_music()
	
#func load_songs():
	#var dir = DirAccess.open("res://assets/music")
#
	#if dir == null:
		#print("No se encontró la carpeta song")
		#return
#
	#dir.list_dir_begin()
	#
#
	#var file_name = dir.get_next()
	#
	#while file_name != "":
		#
		#if !dir.current_is_dir():
			#if false and file_name.ends_with(".ogg") or file_name.ends_with(".mp3") or file_name.ends_with(".wav"):
				#print("encontre: "+file_name)
				#var path = "res://assets/music/" + file_name
#
				#songs.append(load(path))
		#file_name = dir.get_next()
#
	#file_name = dir.get_next()
	#dir.list_dir_end()

func play_music():
	print(songs)
	if songs.is_empty():
		return
	var stream = songs.pick_random()
	if stream == null:
		return
		
	while stream == last_song and songs.size() > 1:
		stream = songs.pick_random()
		
	print("escuchando musica: " + stream.resource_path)
	last_song = stream
	if music.stream == stream:
		return
	var tween = create_tween()
	tween.tween_property(music, "volume_db", -30, -20)
	await tween.finished
	music.stream = stream
	music.play()
	tween = create_tween()
	tween.tween_property(music, "volume_db", -20, -10)
	music.volume_db = -10
	
func _on_song_finished():
	play_music()
