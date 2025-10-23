shader_type canvas_item;

uniform vec2 pulse_position;

uniform vec2 pulse_center;
uniform vec2 screen_size;
uniform float pulse_radius = 0.0;
uniform float pulse_width = 80.0;
uniform float fade = 0.9;

void fragment() {
	vec2 screen_uv = UV * screen_size;
	float dist = distance(screen_uv, pulse_center);
	float ring = 1.0 - smoothstep(pulse_radius - pulse_width, pulse_radius, dist);
	float alpha = fade * (1.0 - ring);
	COLOR = vec4(0.0, 0.0, 0.0, alpha);
}