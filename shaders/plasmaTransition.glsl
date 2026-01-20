extern float time;
extern float th;

vec4 effect(vec4 color, Image texture,vec2 tCoords,vec2 sCoords){
    vec4 pixelt = Texel(texture,tCoords);
    vec2 t= tCoords;

    float px=(t.x-0.5)*32.0;
    float py=(t.y-0.5)*32.0;
    float pix1= cos(sqrt(px*px+py*py)+time);
    px=(t.x)*32.0;
    py=(t.y)*32.0;
    float pix2= cos(sqrt(px*px+py*py)+time*1.4)+0.5;
    px=(t.x)*32.0;
    py=(t.y-1.0)*32.0;
    float pix3= cos(sqrt(px*px+py*py)-time)+0.5;
    px=(t.x-1.0)*32.0;
    py=(t.y-1.0)*32.0;
    float pix4= cos(sqrt(px*px+py*py)-time)+0.5;

    float pixel=pix1+pix2+pix3+pix4-0.2;
    if (pixel<th){
        return pixelt*color;
        
    }
    else{
        return vec4(0.0,0.0,0.0,1);
    }
}