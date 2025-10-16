shader_type canvas_item;

uniform float speed = 1.5;       // how fast the sparkles move
uniform float density = 12.0;    // number of sparkles
uniform float brightness = 1.5;  // intensity of sparkles
uniform float size = 60.0;       // size of sparkles
uniform float alpha = 0.25;      // transparency of the effect

void fragment() {
    vec2 uv = UV * density;

    uv.x += TIME * speed * 0.3;
    uv.y += TIME * speed * 0.5;

    float sparkle = sin(uv.x) * cos(uv.y);
    sparkle = pow(abs(sparkle), size);

    float flicker = 0.5 + 0.5 * sin(TIME * speed * 2.0 + uv.x * 3.0);

    float intensity = sparkle * flicker * brightness;

    COLOR = vec4(vec3(1.0), intensity * alpha);
}
