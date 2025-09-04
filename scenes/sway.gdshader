shader_type canvas_item;

uniform float amplitude : hint_range(0.0, 200.0) = 0.2; // pixels
uniform float frequency : hint_range(0.0, 10.0) = 0.8;
uniform float speed : hint_range(0.0, 10.0) = 0.25;
uniform float strength : hint_range(0.0, 1.0) = 0.35; // 0 no sway 1 full sway

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

    COLOR = texture(TEXTURE, final_uv);
}
