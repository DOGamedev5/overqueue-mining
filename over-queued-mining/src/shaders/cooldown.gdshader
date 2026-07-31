shader_type canvas_item;

uniform float cooldownPercent = 0;
uniform float spriteSheerH = 1;
uniform float spriteSheerV = 1;

void fragment() {
	vec4 base = COLOR;
	float dist = distance(UV * vec2(spriteSheerH, spriteSheerV), vec2(0.5, 0.5));
	
	if (dist < cooldownPercent * sqrt(0.5*0.5 + 0.5*0.5)) {
		COLOR = base + vec4(0.3, 0.3, 0.2, 0);
	}
}
