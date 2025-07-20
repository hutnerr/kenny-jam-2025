// Transparent Weather Overlay Shader for Godot
// Very subtle effects that barely affect map visibility
shader_type canvas_item;

// Weather control parameters
uniform float weather_type : hint_range(0.0, 5.0, 1.0) = 0.0; // 0=sunny, 1=cloudy, 2=rainy, 3=stormy, 4=night, 5=clear
uniform float time_speed : hint_range(0.1, 5.0) = 1.0;
uniform float intensity : hint_range(0.0, 1.0) = 0.3;

// Weather effect parameters
uniform float rain_density : hint_range(20.0, 100.0) = 80.0;
uniform float rain_speed : hint_range(1.0, 24.0) = 4.0;
uniform float cloud_opacity : hint_range(0.0, 0.5) = 0.2;
uniform float shadow_contrast : hint_range(0.0, 0.4) = 0.15;

// Simple hash function for randomness
float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453);
}

// Simple noise function
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

// Fractal Brownian Motion for organic cloud shapes
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

// Function to create rain line shape
float rain_line(vec2 pos, vec2 center) {
    vec2 diff = pos - center;
    
    // Create thin vertical lines for rain
    float line_width = 0.05; // Very thin lines
    float line_height = 0.4; // Height of the rain lines
    
    // Check if we're within the line bounds
    if (abs(diff.x) < line_width && abs(diff.y) < line_height) {
        return 0.0; // Inside the line
    }
    
    return 1.0; // Outside the line
}

void fragment() {
    vec2 uv = UV;
    vec4 overlay = vec4(0.0, 0.0, 0.0, 0.0); // Start completely transparent
    
    if (weather_type < 0.5) {
        // Sunny - dramatic diagonal light rays
        vec2 ray_uv = uv;
        
        // Create diagonal rays coming from top-left
        float diagonal = (ray_uv.x + ray_uv.y * 0.8) * 12.0 + TIME * 1.5 * time_speed;
        float rays = sin(diagonal) * 0.5 + 0.5;
        
        // Make rays sharper and more defined
        rays = pow(rays, 3.0);
        rays = smoothstep(0.7, 1.0, rays);
        
        // Add some gentle movement and variation
        float variation = noise(uv * 2.0 + TIME * 0.1 * time_speed) * 0.3 + 0.7;
        rays *= variation;
        
        // Only show rays where they're strong
        rays = step(0.1, rays) * rays;
        
        // Bright golden rays
        overlay = vec4(1.0, 0.85, 0.5, rays * 0.15 * intensity);
        
    } else if (weather_type < 1.5) {
        // Cloudy - organic clouds using fractal noise
        vec2 cloud_uv = uv;
        
        // Slow cloud movement
        cloud_uv.x += TIME * 0.02 * time_speed;
        cloud_uv.y += TIME * 0.01 * time_speed;
        
        // Create base cloud layer with multiple scales for organic shapes
        float clouds = 0.0;
        
        // Large scale cloud formations
        float large_clouds = fbm(cloud_uv * 3.0, 4);
        large_clouds = smoothstep(0.3, 0.8, large_clouds);
        
        // Medium scale detail
        float medium_clouds = fbm(cloud_uv * 8.0 + TIME * 0.05 * time_speed, 3);
        medium_clouds = smoothstep(0.4, 0.7, medium_clouds);
        
        // Fine detail for cloud edges
        float fine_detail = fbm(cloud_uv * 20.0 + TIME * 0.1 * time_speed, 2);
        fine_detail = smoothstep(0.45, 0.65, fine_detail);
        
        // Combine all layers for organic cloud shapes
        clouds = large_clouds * 0.6 + medium_clouds * 0.3 + fine_detail * 0.1;
        
        // Add more frequent smaller clouds
        float small_clouds = fbm(cloud_uv * 15.0 + vec2(TIME * 0.03, TIME * 0.02) * time_speed, 2);
        small_clouds = smoothstep(0.5, 0.75, small_clouds);
        clouds = max(clouds, small_clouds * 0.4);
        
        // Additional cloud layer for more frequency
        float extra_clouds = fbm(cloud_uv * 12.0 + vec2(-TIME * 0.025, TIME * 0.015) * time_speed, 3);
        extra_clouds = smoothstep(0.45, 0.8, extra_clouds);
        clouds = max(clouds, extra_clouds * 0.5);
        
        // Ensure good contrast and visibility
        clouds = smoothstep(0.1, 0.9, clouds);
        clouds = clamp(clouds, 0.0, 1.0);
        
        // Visible cloud shadows with slight blue tint
        overlay = vec4(0.15, 0.25, 0.35, clouds * 0.6 * intensity);
        
    } else if (weather_type < 2.5) {
        // Rainy - pure black darkness with blue raindrops only
        
        // Apply pure black overlay for darkness
        overlay = vec4(0.0, 0.0, 0.0, 0.6 * intensity);
        
        // Add ONLY blue raindrops with realistic teardrop shapes
        vec2 rain_uv = uv * rain_density;
        rain_uv.y -= TIME * rain_speed * time_speed;
        rain_uv.x += sin(rain_uv.y * 0.2) * 0.15;
        
        float rain = hash(floor(rain_uv));
        rain = step(0.92, rain);
        
        vec2 rain_cell = fract(rain_uv);
        
        // Use rain line shape instead of teardrop
        float line_shape = rain_line(rain_cell, vec2(0.5));
        rain *= step(line_shape, 0.5); // Simple step function for crisp lines
        
        // Only add blue raindrops where rain exists
        if (rain > 0.0) {
            overlay = vec4(0.1, 0.3, 0.9, rain * 0.8 * intensity);
        }
        
    } else if (weather_type < 3.5) {
        // Stormy - just the darkness without raindrops
        overlay = vec4(0.0, 0.0, 0.0, 0.7 * intensity);
        
    } else if (weather_type < 4.5) {
        // Night - more noticeable darkness with subtle star twinkles
        overlay = vec4(0.2, 0.3, 0.6, 0.25 * intensity);
        
        // Add subtle twinkling stars
        vec2 star_uv = uv * 40.0;
        float stars = hash(floor(star_uv));
        stars = step(0.98, stars);
        
        // Twinkling effect
        float twinkle = sin(TIME * 2.0 + hash(floor(star_uv)) * 6.28) * 0.5 + 0.5;
        stars *= twinkle;
        
        overlay += vec4(1.0, 1.0, 0.9, stars * 0.15 * intensity);
        
    } else {
        // Clear/No effects - completely transparent
        overlay = vec4(0.0, 0.0, 0.0, 0.0);
    }
    
    // Output the overlay - the canvas_item blend mode will handle mixing with your map
    COLOR = overlay;
}