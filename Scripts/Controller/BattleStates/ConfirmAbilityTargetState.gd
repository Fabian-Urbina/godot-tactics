extends BattleState

@export var performAbilityState:State
@export var abilityTargetState:State

var tiles
var aa:AbilityArea
var index:int = 0

func Enter():
	super()
	var filtered = turn.ability.get_children().filter(func(node): return node is AbilityArea)
	aa = filtered[0]
	tiles = aa.GetTilesInArea(board, pos)
	board.SelectTiles(tiles)
	FindTargets()
	RefreshPrimaryStatPanel(turn.actor.tile.pos)
	
	if turn.targets.size() > 0:
		await hitSuccessIndicator.Show()
		SetTarget(0)

func Exit():
	super()
	board.DeSelectTiles(tiles)
	await statPanelController.HidePrimary()
	await statPanelController.HideSecondary()
	await hitSuccessIndicator.Hide()

func OnMove(e:Vector2i):
	if(e.x > 0 || e.y < 0):
		SetTarget(index + 1)
	else:
		SetTarget(index - 1)
	
func OnFire(e:int):
	print("OnFire:", e)
	print("pos:", pos)
	print("tiles:", tiles.size())
	print("targets after find:", turn.targets.size())
	if(e == 0):
		if (turn.targets.size() > 0):
			print("changing to performAbilityState")
			_owner.stateMachine.ChangeState(performAbilityState)
		else:
			print("NO TARGETS")
	else:
		_owner.stateMachine.ChangeState(abilityTargetState)

func FindTargets():
	turn.targets = []
	
	for tile in tiles:
		if(IsTarget(tile)):
			turn.targets.append(tile)

func IsTarget(tile:Tile):
	var children:Array[Node] = turn.ability.find_children("*", "BaseAbilityEffect", false)
	for child in children:
		var targeter:AbilityEffectTarget = child.get_node("Ability Effect Target")
		if targeter.IsTarget(tile):
			return true
	return false


func SetTarget(target:int):
	index = target
	if index < 0:
		index = turn.targets.size()
	if index >= turn.targets.size():
		index = 0
	if turn.targets.size() > 0:
		RefreshSecondaryStatPanel(turn.targets[index].pos)
		UpdateHitSuccessIndicator()

func Zoom(scroll: int):
	_owner.cameraController.Zoom(scroll)
  
func Orbit(direction: Vector2):
	_owner.cameraController.Orbit(direction)

func UpdateHitSuccessIndicator():
	var chance:int = 0
	var amount:int = 0
	var target:Tile = turn.targets[index]
	
	var children:Array[Node] = turn.ability.find_children("*", "BaseAbilityEffect", false)
	for child in children:
		var targeter:AbilityEffectTarget = child.get_node("Ability Effect Target")
		if targeter.IsTarget(target):
			var hitRate:HitRate = child.get_node("Hit Rate")
			chance = hitRate.Calculate(target)
			amount = child.Predict(target)
			break
	
	hitSuccessIndicator.SetStats(chance, amount)

func CalculateHitRate():
	var target:Tile = turn.targets[index]
	var children:Array[Node] = turn.ability.find_children("*", "HitRate", false)
	if children:
		var hr:HitRate = children[0]
		return hr.Calculate(target)
	print("Couldn't find Hit Rate")
	return 0
	
func EstimateDamage()->int:
	return 50
