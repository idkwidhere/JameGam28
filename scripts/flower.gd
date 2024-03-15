extends Area2D
class_name Flower

var plant_water = 0
@onready var flower_sprite = $FlowerSprite


# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.connect("player_interact", water_plant)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func water_plant():
	print("should work")
	plant_water += 1
	flower_sprite.scale.y += plant_water
