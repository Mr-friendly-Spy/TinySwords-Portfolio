# Tiny Swords: Kingdoms — excerpt from the game.
# Original source: scripts/battlefield.gd
# Function bodies are unchanged. This is not a standalone game module.
# Context and limitations: examples/README.md.

func _union_find_root(parents: Array[int], component_id: int) -> int:
	var root := component_id
	while parents[root] != root:
		root = parents[root]
	var current := component_id
	while parents[current] != current:
		var next := parents[current]
		parents[current] = root
		current = next
	return root


func _union_find_merge(
	parents: Array[int],
	first_component: int,
	second_component: int
) -> void:
	var first_root := _union_find_root(parents, first_component)
	var second_root := _union_find_root(parents, second_component)
	if first_root != second_root:
		parents[second_root] = first_root
