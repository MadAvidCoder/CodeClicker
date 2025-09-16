shader_type canvas_item;

    void fragment() {
        vec4 color = texture(TEXTURE, UV); // Get the original pixel color
        COLOR = vec4(1.0, 1.0, 1.0, color.a); // Set RGB to white, preserve original alpha
    }
