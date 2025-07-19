shader_type canvas_item;

uniform float beam_width : hint_range(0.1, 2.0) = 0.3;
uniform vec4 core_color = vec4(1.0, 0.2, 0.2, 1.0);
uniform vec4 outer_color = vec4(1.0, 0.8, 0.8, 0.3);
uniform float pulse_speed : hint_range(0.5, 5.0) = 2.0;
uniform float pulse_intensity : hint_range(0.0, 1.0) = 0.4;
uniform float flicker_speed : hint_range(1.0, 10.0) = 3.0;
uniform float flicker_amount : hint_range(0.0, 0.5) = 0.1;
uniform float edge_softness : hint_range(0.01, 0.5) = 0.1;

varying vec2 world_position;

void vertex() {
    world_position = VERTEX;
}

float random(vec2 co) {
    return fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment() {
    vec2 uv = UV;
    
    // Generate base color even without texture
    COLOR = vec4(1.0, 1.0, 1.0, 1.0);
    
    // Distance from center line (assuming horizontal laser)
    float distance_from_center = abs(uv.y - 0.5);
    
    // Create pulsing effect
    float pulse = sin(TIME * pulse_speed) * pulse_intensity + 1.0;
    
    // Add subtle flickering
    float flicker = 1.0 + sin(TIME * flicker_speed + random(vec2(floor(TIME * 10.0)))) * flicker_amount;
    
    // Core beam intensity
    float core_intensity = 1.0 - smoothstep(0.0, beam_width * 0.3, distance_from_center);
    core_intensity *= pulse * flicker;
    
    // Outer glow
    float outer_intensity = 1.0 - smoothstep(0.0, beam_width, distance_from_center);
    outer_intensity = pow(outer_intensity, 2.0);
    outer_intensity *= pulse * 0.7;
    
    // Add some edge softness
    float edge_fade = 1.0 - smoothstep(1.0 - edge_softness, 1.0, uv.x);
    edge_fade *= smoothstep(0.0, edge_softness, uv.x);
    
    // Combine colors
    vec4 final_color = mix(outer_color, core_color, core_intensity);
    final_color.a = (core_intensity + outer_intensity * 0.5) * edge_fade;
    
    COLOR = final_color;
}