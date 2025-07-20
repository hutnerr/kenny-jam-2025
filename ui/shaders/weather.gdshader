shader_type canvas_item;

uniform float weather_type : hint_range(0.0, 5.0, 1.0) = 0.0; // 0=sunny, 1=cloudy, 2=rainy, 3=stormy, 4=night, 5=clear
uniform float time_speed : hint_range(0.1, 5.0) = 1.0;
uniform float intensity : hint_range(0.0, 1.0) = 0.3;

uniform float rain_density : hint_range(20.0, 100.0) = 80.0;
uniform float rain_speed : hint_range(1.0, 24.0) = 4.0;
uniform float cloud_opacity : hint_range(0.0, 0.5) = 0.2;
uniform float shadow_contrast : hint_range(0.0, 0.4) = 0.15;

float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453);
}

float noise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    
    float a = hash(i);
    float b = hash(i + vec2(1.0, 0.0));
    float c = hash(i + vec2(0.0, 1.0));
    float d = hash(i + vec2(1.0, 1.0));
    
    vec2 u = f * f * (3.0 - 2.0 * f);
    
    return mix(a, b, u.x) + (c - a) * u.y * (1.0 - u.x) + (d - b) * u.x * u.y;
}

float fbm(vec2 p, int octaves) {
    float value = 0.0;
    float amplitude = 0.5;
    float frequency = 1.0;
    
    for (int i = 0; i < octaves; i++) {
        value += amplitude * noise(p * frequency);
        amplitude *= 0.5;
        frequency *= 2.0;
    }
    
    return value;
}

float rain_line(vec2 pos, vec2 center) {
    vec2 diff = pos - center;
    
    float line_width = 0.05; 
    float line_height = 0.4; 
    
    if (abs(diff.x) < line_width && abs(diff.y) < line_height) {
        return 0.0;
    }
    
    return 1.0;
}

void fragment() {
    vec2 uv = UV;
    vec4 overlay = vec4(0.0, 0.0, 0.0, 0.0);
    
    if (weather_type < 0.5) {
        vec2 ray_uv = uv;
        
        float diagonal = (ray_uv.x + ray_uv.y * 0.8) * 12.0 + TIME * 1.5 * time_speed;
        float rays = sin(diagonal) * 0.5 + 0.5;
        
        rays = pow(rays, 3.0);
        rays = smoothstep(0.7, 1.0, rays);
        
        float variation = noise(uv * 2.0 + TIME * 0.1 * time_speed) * 0.3 + 0.7;
        rays *= variation;
        
        rays = step(0.1, rays) * rays;
        
        overlay = vec4(1.0, 0.85, 0.5, rays * 0.15 * intensity);
        
    } else if (weather_type < 1.5) {
        vec2 cloud_uv = uv;
        
        cloud_uv.x += TIME * 0.02 * time_speed;
        cloud_uv.y += TIME * 0.01 * time_speed;
        
        float clouds = 0.0;
        
        float large_clouds = fbm(cloud_uv * 3.0, 4);
        large_clouds = smoothstep(0.3, 0.8, large_clouds);
        
        float medium_clouds = fbm(cloud_uv * 8.0 + TIME * 0.05 * time_speed, 3);
        medium_clouds = smoothstep(0.4, 0.7, medium_clouds);
        
        float fine_detail = fbm(cloud_uv * 20.0 + TIME * 0.1 * time_speed, 2);
        fine_detail = smoothstep(0.45, 0.65, fine_detail);
        
        clouds = large_clouds * 0.6 + medium_clouds * 0.3 + fine_detail * 0.1;
        
        float small_clouds = fbm(cloud_uv * 15.0 + vec2(TIME * 0.03, TIME * 0.02) * time_speed, 2);
        small_clouds = smoothstep(0.5, 0.75, small_clouds);
        clouds = max(clouds, small_clouds * 0.4);
        
        float extra_clouds = fbm(cloud_uv * 12.0 + vec2(-TIME * 0.025, TIME * 0.015) * time_speed, 3);
        extra_clouds = smoothstep(0.45, 0.8, extra_clouds);
        clouds = max(clouds, extra_clouds * 0.5);
        
        clouds = smoothstep(0.1, 0.9, clouds);
        clouds = clamp(clouds, 0.0, 1.0);
        
        overlay = vec4(0.1, 0.2, 0.4, clouds * 0.6 * intensity);
        
    } else if (weather_type < 2.5) {        
        overlay = vec4(0.0, 0.0, 0.0, 0.6 * intensity);
        
        vec2 rain_uv = uv * rain_density;
        rain_uv.y -= TIME * rain_speed * time_speed;
        rain_uv.x += sin(rain_uv.y * 0.2) * 0.15;
        
        float rain = hash(floor(rain_uv));
        rain = step(0.92, rain);
        
        vec2 rain_cell = fract(rain_uv);
        
        float line_shape = rain_line(rain_cell, vec2(0.5));
        rain *= step(line_shape, 0.5);
        
        if (rain > 0.0) {
            overlay = vec4(0.1, 0.3, 0.9, rain * 0.8 * intensity);
        }
        
    } else if (weather_type < 3.5) {
        overlay = vec4(0.05, 0.1, 0.3, 0.35 * intensity);
        
    } else if (weather_type < 4.5) {
        overlay = vec4(0.0, 0.0, 0.0, 0.0);
        
    } else {
        overlay = vec4(0.0, 0.0, 0.0, 0.0);
    }
    
    COLOR = overlay;
}