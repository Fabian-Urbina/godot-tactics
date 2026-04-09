extends AbilityRange

func GetTilesInRange(board:Board):
	var retValue:Array[Tile] = []
	retValue.append(unit.tile)
	return retValue
