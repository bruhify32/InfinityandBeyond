extends Position2D

onready var cloud = preload("res://Cloud.tscn");

func _ready():
	while(true):
		randomize();
		yield( get_tree().create_timer(rand_range(1.5,5.5)), "timeout" )
		_spawn()

func _spawn():
	var cloud_i = cloud.instance();
	self.add_child(cloud_i)