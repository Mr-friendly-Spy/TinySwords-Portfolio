# Tiny Swords: Kingdoms — excerpt from the game.
# Original source: scripts/audio_manager.gd
# Function bodies are unchanged. This is not a standalone game module.
# Context and limitations: examples/README.md.

func _can_play(event_name: String, source_key: String = "") -> bool:
	var now := Time.get_ticks_msec() * 0.001
	var cooldown := float(EVENT_COOLDOWN.get(event_name, 0.0))
	var cooldown_key := event_name if source_key.is_empty() else "%s@%s" % [event_name, source_key]
	if (
		cooldown > 0.0
		and now - float(_last_played_at.get(cooldown_key, -1000.0)) < cooldown
	):
		return false
	_last_played_at[cooldown_key] = now
	return true


func _world_cooldown_key(world_position: Vector2) -> String:
	return "%d:%d" % [
		floori(world_position.x / WORLD_COOLDOWN_CELL_SIZE),
		floori(world_position.y / WORLD_COOLDOWN_CELL_SIZE),
	]
