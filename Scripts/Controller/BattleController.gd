extends Node
class_name BattleController

@export var board: Board
@export var inputController: InputController
@export var cameraController: CameraController
@export var stateMachine: StateMachine
@export var startState: State

func _ready() -> void:
	stateMachine.ChangeState(startState)
