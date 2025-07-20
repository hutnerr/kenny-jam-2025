shader_type canvas_item;

uniform float stream_speed : hint_range(0.1, 5.0) = 2.0;
uniform float power_level : hint_range(0.0, 1.0) = 0.8;
uniform vec3 data_color = vec3(1.0, 0.9, 0.2);
uniform float pixelation : hint_range(8.0, 64.0) = 16.0;

float random(vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

void fragment() {
    vec2 pixelated_uv = floor(UV * pixelation) / pixelation;
    
    float stream_x = pixelated_uv.x;
    float stream_y = pixelated_uv.y + TIME * stream_speed;
    
    float data_block = random(vec2(stream_x, floor(stream_y * 10.0)));
    float is_data = step(0.3, data_block) * step(data_block, 0.7);
    
    float power_flicker = sin(TIME * 8.0) * 0.1 + 0.9;
    float final_power = power_level * power_flicker;
    
    float intensity = is_data * final_power;
    
    COLOR = vec4(data_color * intensity, intensity);
}