shader_type spatial;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	    // Get the original color from the material or texture
    // Apply a darkening factor, the closer the value is to 0, the darker it will be.
    float darken_factor = 0.5;

    // Darken the color by multiplying it with the darken factor
    vec4 darkened_color = original_color * darken_factor;

    // Output the darkened color
    ALBEDO = darkened_color.rgb;
    ALPHA = darkened_color.a;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
