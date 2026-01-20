extern float time;

vec4 effect(vec4 color, Image texture,vec2 tCoords,vec2 sCoords){
    vec2 wCoords=vec2(tCoords.x,tCoords.y+cos((tCoords.x*8)+time)/8);
    vec4 pixel = Texel(texture,wCoords);
    return pixel*color;
}