shader_type canvas_item;

uniform vec2 rect_size = vec2(30.0, 85.0);
uniform float scanline_spacing = 0.15;
uniform float scanline_speed = 15;
uniform float scanline_strength = 0.55;
uniform float curvature_x = 0.06;
uniform float curvature_y = 0.14;
uniform float vignette_strength = 0.8;
uniform float glow_strength = 0.08;
uniform vec3 background_green = vec3(0.0, 0.14, 0.05);
uniform vec3 text_green = vec3(0.39, 1.0, 0.51);

void fragment() {
	vec2 centered_uv = (UV - 0.5) * 2.0;
	float rx = centered_uv.x * centered_uv.x;
	float ry = centered_uv.y * centered_uv.y;
	centered_uv.x *= 1.0 + curvature_x * ry;
	centered_uv.y *= 1.0 + curvature_y * rx;
	vec2 uv = centered_uv * 0.5 + 0.5;

    if (uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0 || uv.y > 1.0) {
        COLOR = vec4(0.0, 0.0, 0.0, 1.0);
    } else {
        vec3 base_col = background_green;
        float scanline_phase = TIME * scanline_speed;
        float scan_y = uv.y / scanline_spacing + scanline_phase;
        float scan_val = 0.5 + 0.5 * cos(6.2831 * scan_y);
        base_col *= 1.0 - scanline_strength * scan_val;
        vec4 txt = texture(TEXTURE, uv);

        float glow = 0.0;
        if (txt.a > 0.3) {
            float step1 = 0.004;
            float step2 = 0.008;
            glow += (
                texture(TEXTURE, uv + vec2( step1,  0)).a +
                texture(TEXTURE, uv + vec2(-step1,  0)).a +
                texture(TEXTURE, uv + vec2( 0,  step1)).a +
                texture(TEXTURE, uv + vec2( 0, -step1)).a +
                texture(TEXTURE, uv + vec2( step1,  step1)).a +
                texture(TEXTURE, uv + vec2(-step1,  step1)).a +
                texture(TEXTURE, uv + vec2( step1, -step1)).a +
                texture(TEXTURE, uv + vec2(-step1, -step1)).a
            ) * 0.081;

            glow += (
                texture(TEXTURE, uv + vec2( step2,  0)).a +
                texture(TEXTURE, uv + vec2(-step2,  0)).a +
                texture(TEXTURE, uv + vec2( 0,  step2)).a +
                texture(TEXTURE, uv + vec2( 0, -step2)).a +
                texture(TEXTURE, uv + vec2( step2,  step2)).a +
                texture(TEXTURE, uv + vec2(-step2,  step2)).a +
                texture(TEXTURE, uv + vec2( step2, -step2)).a +
                texture(TEXTURE, uv + vec2(-step2, -step2)).a
            ) * 0.024;
        }

        if (txt.a > 0.04) {
            vec3 text_col = text_green;
            text_col *= 1.0 - 0.7 * scanline_strength * scan_val;
            text_col += text_green * glow_strength * glow;
            base_col = mix(base_col, text_col, clamp(txt.a + glow, 0.0, 1.0));
        }

        float vignette = smoothstep(0.6, 0.98, length((UV - vec2(0.5)) / vec2(0.92, 1.04)));
        base_col *= 1.0 - vignette * vignette_strength;

        COLOR = vec4(base_col, 1.0);
    }
}