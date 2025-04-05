extends CanvasLayer



func _ready() -> void:
	$Master.value = AudioServer.get_bus_volume_linear(0)
	$SFX.value = AudioServer.get_bus_volume_linear(1)
	$Music.value = AudioServer.get_bus_volume_linear(2)

func _on_master_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(0, $Master.value)
	$SFXTester.play()
	$MusicTester.play()

func _on_sfx_value_changed(value: float) -> void:
	$SFXTester.play()
	AudioServer.set_bus_volume_linear(1, $SFX.value)


func _on_music_value_changed(value: float) -> void:
	$MusicTester.play()
	AudioServer.set_bus_volume_linear(2, $Music.value)
