extends AbilityArea

func GetTilesInArea(board:Board, pos:Vector2i):
	return _GetRange().GetTilesInRange(board)
