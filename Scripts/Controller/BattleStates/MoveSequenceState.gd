extends BattleState

@export var SelectUnitState:State

func Enter():
	super()
	Sequence()

func Sequence():	
	var m:Movement = _owner.currentUnit.get_node("Movement")
	_owner.cameraController.setFollow(_owner.currentUnit)
	print("before await traverse")
	await m.Traverse(_owner.currentTile)
	print("after await traverse")
	
	_owner.cameraController.setFollow(_owner.board.marker)
	_owner.stateMachine.ChangeState(SelectUnitState)
