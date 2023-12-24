extends Node2D

# Параметры генерации
var number_of_platforms = 100000
var level_width = 1000000
var level_height = 60000000

# Предварительно загружаем сцену платформы
var platform_scene = preload()

func _ready():
	generate_level()

func generate_level():
	for i in range(number_of_platforms):
		var x = randf_range(0, level_width)
		var y = randf_range(0, level_height)
		var platform = platform_scene.instance()
		platform.position = Vector2(x, y)
		add_child(platform)
