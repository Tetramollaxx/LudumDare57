extends CanvasLayer


func _on_master_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(0, $VBoxContainer/Master.value)
	$SFXTester.play()
	$MusicTester.play()

func _on_sfx_value_changed(value: float) -> void:
	$SFXTester.play()
	AudioServer.set_bus_volume_linear(1, $VBoxContainer/SFX.value)


func _on_music_value_changed(value: float) -> void:
	$MusicTester.play()
	AudioServer.set_bus_volume_linear(2, $VBoxContainer/Music.value)
