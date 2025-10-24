shader_type canvas_item;
render_mode blend_mix, unshaded;

uniform float player_radius;
uniform float player_fade;
uniform vec2 pulse_center;
uniform vec2 screen_size;
uniform float pulse_radius = 0.0;
uniform float pulse_width = 80.0;
uniform float fade = 0.85;
uniform float darkness = 0.0;

void fragment() {
	vec2 screen_uv = UV * screen_size;
	float dist = distance(screen_uv, pulse_center);

	float alpha = fade * darkness;

	float player_inner = smoothstep(player_radius, player_radius+player_fade, dist);
	alpha *= player_inner;

	float inner = smoothstep(pulse_radius - pulse_width, pulse_radius - pulse_width * 0.2, dist);
	float outer = smoothstep(pulse_radius + pulse_width * 0.2, pulse_radius + pulse_width, dist);
	float ring = inner - outer;

	alpha *= (1.0-ring);
	COLOR.rgb = vec3(0.0);
	COLOR.a = alpha;
}
