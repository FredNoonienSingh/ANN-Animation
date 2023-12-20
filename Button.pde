class Button{
    int posx, posy, width, height; 
    boolean hoover; 
    /*
        how does Java handle the parsing of a callable 
    */ 
    Button(int x, int y, int w, int h){
        posx = x; 
        posy = y; 
        width = w; 
        height = h;
        hoover = false;  
    }
    void onHover(float mx, float my){
        if(mx <= posx && mx >= posx+width && my <= posy && my >= posy+height){
            hoover = true; 
        }
        hoover = false; 
    }
    void update(){
        rect(posx, posy, width, height); 
    }
}