extends Node
class_name BattleController

@export var board: Board
@export var inputController: InputController
@export var cameraController: CameraController
@export var stateMachine: StateMachine
@export var startState: State
@export var conversationController: ConversationController

@export var heroPrefab: PackedScene
var currentUnit: Unit
var currentTile: Tile:
	get: return board.GetTile(board.pos)

func _ready() -> void:
	stateMachine.ChangeState(startState)
