// Smart Invert Screen Shader for Hyprland
// Inverts lightness while preserving hue and saturation

precision medium permission float;
varying vec2 v_texcoord;
uniform sampler2D tex;

vec3 rgb2hsl(vec3 c) {
    float maxC = max(max(c.r, c.g), c.b);
    float minC = min(min(c.r, c.g), c.b);
    float delta = maxC - minC;

    float h = 0.0;
    float s = 0.0;
    float l = (maxC + minC) / 2.0;

    if (delta > 0.0) {
        s = l < 0.5 ? delta / (maxC + minC) : delta / (2.0 - maxC - minC);

        if (maxC == c.r) {
            h = (c.g - c.b) / delta + (c.g < c.b ? 6.0 : 0.0);
        } else if (maxC == c.g) {
            h = (c.b - c.r) / delta + 2.0;
        } else if (maxC == c.b) {
            h = (c.r - c.g) / delta + 4.0;
        }
        h /= 6.0;
    }

    return vec3(h, s, l);
}

float hue2rgb(float p, float q, float t) {
    if (t < 0.0) t += 1.0;
    if (t > 1.0) t -= 1.0;
    if (t < 1.0 / 6.0) return p + (q - p) * 6.0 * t;
    if (t < 1.0 / 2.0) return q;
    if (t < 2.0 / 3.0) return p + (q - p) * (2.0 / 3.0 - t) * 6.0;
    return p;
}

vec3 hsl2rgb(vec3 c) {
    vec3 rgb;

    if (c.y == 0.0) {
        rgb = vec3(c.z); // Monochromatic
    } else {
        float q = c.z < 0.5 ? c.z * (1.0 + c.y) : c.z + c.y - c.z * c.y;
        float p = 2.0 * c.z - q;
        rgb.r = hue2rgb(p, q, c.x + 1.0 / 3.0);
        rgb.g = hue2rgb(p, q, c.x);
        rgb.b = hue2rgb(p, q, c.x - 1.0 / 3.0);
    }

    return rgb;
}

void main() {
    vec4 texColor = texture2D(tex, v_texcoord);

    // Convert to HSL
    vec3 hsl = rgb2hsl(texColor.rgb);

    // Invert the Lightness channel (keep Hue and Saturation intact)
    hsl.z = 1.0 - hsl.z;

    // Convert back to RGB
    vec3 finalRgb = hsl2rgb(hsl);

    gl_FragColor = vec4(finalRgb, texColor.a);
}
