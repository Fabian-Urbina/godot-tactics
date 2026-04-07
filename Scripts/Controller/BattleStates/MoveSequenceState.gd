extends BattleState

@export var commandSelectionState:State

func Enter():
	super()
	Sequence()

func Sequence():	
	var m:Movement = _owner.turn.actor.get_node("Movement")
	_owner.cameraController.setFollow(_owner.turn.actor)
	print("before await traverse")
	await m.Traverse(_owner.currentTile)
	print("after await traverse")
	
	_owner.cameraController.setFollow(_owner.board.marker)
	_owner.stateMachine.ChangeState(commandSelectionState)
