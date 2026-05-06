shader_type canvas_item;

uniform sampler2D tex : repeat_enable;
uniform float n_rows = 5;
uniform float y_offset = 0.0;
void fragment() {
	vec2 uv = UV;
	uv.y /= n_rows;
	uv.y += y_offset;
	COLOR.rgba *= texture(tex, uv).rgba;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
