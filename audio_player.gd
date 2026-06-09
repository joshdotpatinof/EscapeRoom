extends AudioStreamPlayer2D


const game_music = preload("res://audio/slow-2021-08-16_-_8_Bit_Adventure_-_www.FesliyanStudios.com.mp3")

func _play_music(music: AudioStream, volume = -10.0):
	if stream == music:
		return
	
	stream = music
	volume_db = volume
	play()
	

func _play_music_game():
	_play_music(game_music)

func play_fx(stream: AudioStream, volume = 0.0):
	var fx_player = AudioStreamPlayer.new()
	fx_player.stream = stream
	fx_player.name = "FX_PLAYER"
	fx_player.volume_db = volume
	add_child(fx_player)
	fx_player.play()
	
	await fx_player.finished
	fx_player.queue_free()
