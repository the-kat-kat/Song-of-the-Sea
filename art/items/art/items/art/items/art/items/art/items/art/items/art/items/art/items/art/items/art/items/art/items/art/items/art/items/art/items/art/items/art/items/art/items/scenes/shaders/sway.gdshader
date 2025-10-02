shader_type canvas_item;

uniform float amplitude : hint_range(0.0, 200.0) = 50;
uniform float frequency : hint_range(0.0, 10.0) = 0.8;
uniform float speed : hint_range(0.0, 10.0) = 1;
uniform float strength : hint_range(0.0, 1.0) = 0.5;

uniform float ray_speed = 0.6;
uniform float ray_density = 30.0;
uniform float ray_width = 0.01;
uniform float ray_slant = 0.12;
uniform float ray_falloff = 2.0;
uniform float ray_intensity = 0.7;
uniform vec3 ray_tint = vec3(1.0, 1.0, 1.0);

uniform float ray_motion = 0.18;
uniform float min_length = 0.15;
uniform float max_length = 0.65;
uniform float length_softness = 0.06;
uniform float length_seed_offset = 12.34;

uniform bool debug_show_mask = false;

uniform float tone : hint_range(-1.0, 1.0) = -0.9;
uniform vec3 tint_color = vec3(1.0, 0.6, 0.6);
uniform float tint_strength : hint_range(0.0, 1.0) = 0.5;
uniform float preserve_threshold : hint_range(0.0, 1.0) = 0.90;

float hash1(float n) {
    return fract(sin(n) * 43758.5453123);
}

float vertical_ray_mask_varied(vec2 uv) {
	float y_top = 1.0 - uv.y;

	float uvx_slanted = uv.x + uv.y * ray_slant;

	float col_f = floor(uvx_slanted * ray_density);
	float seed = hash1(col_f + length_seed_offset);

	float col_center_base = (col_f + 0.5) / ray_density;
	float motion = sin(TIME * (ray_speed * (0.6 + seed))) * (ray_motion * (0.5 + 0.5 * seed));
	float col_center = col_center_base + motion / ray_density;

	float dist = abs(uvx_slanted - col_center) * ray_density; // 0 at center

	float core = 1.0 - smoothstep(0.0, ray_width * 1.2, dist);
	core = pow(core, 2.0);
	core = clamp(core, 0.0, 1.0);

	float col_length = mix(min_length, max_length, seed);
	float cutoff = col_length;
	float edge0 = max(cutoff - length_softness, 0.0);
	float edge1 = cutoff;
	float vertical_fade = smoothstep(edge0, edge1, y_top);
	vertical_fade *= pow(y_top, ray_falloff);


	float base_intensity = 0.6 + 0.8 * seed;
	float anim_offset = seed * 6.2831853;
	float flick = 0.85 + 0.25 * sin(TIME * (0.8 + seed * 1.6) + anim_offset);

	return core * vertical_fade * base_intensity * flick;
}

void fragment() {
	vec2 uv = UV;


	float tex_w = float(textureSize(TEXTURE, 0).x);
	float tex_h = float(textureSize(TEXTURE, 0).y);
	float amp_u = amplitude / tex_w;
	float amp_v = amplitude / tex_h;

	float offsetX = sin(uv.y * frequency + TIME * speed) * amp_u;
	float offsetY = cos(uv.x * frequency * 0.5 + TIME * speed) * amp_v;

	vec2 warped = uv + vec2(offsetX, offsetY);
	vec2 final_uv = mix(uv, warped, strength);
	final_uv = clamp(final_uv, vec2(0.0), vec2(1.0));

	vec4 base = texture(TEXTURE, final_uv);

	float mask = vertical_ray_mask_varied(uv);

	if (debug_show_mask) {
		COLOR = vec4(vec3(mask), 1.0);
	} else {
		vec3 ray_col = ray_tint * mask * ray_intensity;
		vec3 final_rgb = base.rgb + ray_col * (1.0 - base.rgb);
		final_rgb = clamp(final_rgb, 0.0, 1.0);

		float luma = dot(final_rgb, vec3(0.2126, 0.7152, 0.0722));
		float highlight_mask = smoothstep(preserve_threshold, preserve_threshold + 0.05, luma);
		float affect = 1.0 - highlight_mask;

		float t = clamp(tone, -1.0, 1.0);
		if (t > 0.0) {
			final_rgb = mix(final_rgb, vec3(1.0), t * affect);
		} else if (t < 0.0) {
			final_rgb = mix(final_rgb, vec3(0.0), -t * affect);
		}
		final_rgb = mix(final_rgb, final_rgb * tint_color, tint_strength * affect);

		COLOR = vec4(final_rgb, base.a);
	}
}
