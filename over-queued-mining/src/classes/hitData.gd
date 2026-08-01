class_name HitData extends Resource

@export var sequencialHits := 0
@export var initialValue := 1
@export var bypassCooldown := false
@export var strength := 1.0
@export var isSource := false
@export var multiply := 0.0

func _init(initValue, bypass := false, source := false) -> void:
	initialValue = initValue
	bypassCooldown = bypass
	isSource = source
	
func setCurrentStrength(Strength : float): strength = Strength

func addStrength(Strength : float): setCurrentStrength(strength + Strength)
