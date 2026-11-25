# Tiny Swords: Kingdoms — excerpt from the game.
# Original source: scripts/ui_text_guard.gd
# Function bodies are unchanged. This is not a standalone game module.
# Context and limitations: examples/README.md.

const SIZE_EPSILON := 0.5


func _text_fits(
	control: Control,
	font: Font,
	text: String,
	font_size: int,
	available_size: Vector2
) -> bool:
	var measured: Vector2
	var autowrap_mode := TextServer.AUTOWRAP_OFF
	if control is Label:
		autowrap_mode = (control as Label).autowrap_mode
	elif control is Button:
		autowrap_mode = (control as Button).autowrap_mode

	if autowrap_mode == TextServer.AUTOWRAP_OFF:
		measured = _measure_unwrapped(font, text, font_size)
	else:
		measured = font.get_multiline_string_size(
			text,
			HORIZONTAL_ALIGNMENT_LEFT,
			available_size.x,
			font_size
		)
	return (
		measured.x <= available_size.x + SIZE_EPSILON
		and measured.y <= available_size.y + SIZE_EPSILON
	)


func _measure_unwrapped(font: Font, text: String, font_size: int) -> Vector2:
	var lines := text.split("\n", true)
	var maximum_width := 0.0
	for line in lines:
		maximum_width = maxf(
			maximum_width,
			font.get_string_size(
				line,
				HORIZONTAL_ALIGNMENT_LEFT,
				-1.0,
				font_size
			).x
		)
	return Vector2(maximum_width, font.get_height(font_size) * maxi(1, lines.size()))
