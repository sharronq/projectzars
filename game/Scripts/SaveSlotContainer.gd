extends Container

# Called when the node enters the scene tree for the first time.
func _ready():
	var children = self.get_children()
	for node in children:
		if node.name != "Background":
			node.hide()
	
