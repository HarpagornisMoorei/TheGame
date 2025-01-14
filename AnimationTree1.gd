extends AnimationTree

# 'onready' ensures the node is loaded before accessing it, verify the path is correct
@onready var anim_tree = get_node("/root/Node2D/main/AnimationTree")

const anim_speed_scale = 1.5

func _physics_process(delta):
	# Check if the anim_tree is not null to avoid calling methods on a null instance
	if anim_tree:
		anim_tree.advance(delta * anim_speed_scale)
	
