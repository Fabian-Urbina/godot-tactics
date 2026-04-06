extends Node3D
class_name Unit

var tile: Tile
var dir: Directions.Dirs = Directions.Dirs.SOUTH

func Place(target: Tile):
	if tile != null && tile.content == self:
		tile.content = null
	
	tile = target
	
	if target != null:
		target.content = self
		
func Match():
	self.position = tile.Center()
	self.rotation_degrees = Directions.ToEuler(dir)
