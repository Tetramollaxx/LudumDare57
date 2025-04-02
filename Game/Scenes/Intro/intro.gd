extends CanvasLayer

@export var NextScene : PackedScene

func nextScene():
	get_tree().change_scene_to_packed(NextScene)
