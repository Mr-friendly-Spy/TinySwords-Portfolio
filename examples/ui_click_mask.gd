# Tiny Swords: Kingdoms — excerpt from the game.
# Original source: scripts/ui_hit_area.gd
# Function bodies are unchanged. This is not a standalone game module.
# Context and limitations: examples/README.md.

const CLICK_ALPHA_THRESHOLD := 0.18


static var _click_mask_cache: Dictionary = {}


static func apply_texture_click_mask(
	button: TextureButton,
	alpha_threshold := CLICK_ALPHA_THRESHOLD
) -> void:
	if not is_instance_valid(button) or button.texture_normal == null:
		return
	var texture := button.texture_normal
	var cache_key := "%s:%0.3f" % [texture.resource_path, alpha_threshold]
	var mask := _click_mask_cache.get(cache_key) as BitMap
	if mask == null:
		var image := texture.get_image()
		if image == null or image.is_empty():
			return
		mask = BitMap.new()
		mask.create_from_image_alpha(image, alpha_threshold)
		_click_mask_cache[cache_key] = mask
	button.texture_click_mask = mask
