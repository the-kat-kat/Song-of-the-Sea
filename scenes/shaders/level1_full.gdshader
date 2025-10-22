shader_type canvas_item;

uniform vec2 pulse_position;
uniform float pulse_radius;
uniform float pulse_thickness = 80.0;
uniform float brightness = 1.0;

void fragment(){
	vec2 screen_uv = FRAGCOORD.xy;
	float dist = distance(screen_uv, pulse_position);
	
	float edge = abs(dist - pulse_radius);
	float glow = smoothstep(pulse_thickness, 0.0, edge);
	
	vec3 base_color = vec3(0.0);
	vec3 reveal = vec3(1.0) * glow * brightness;
	
	COLOR = vec4(base_color + reveal, 1.0);
}
