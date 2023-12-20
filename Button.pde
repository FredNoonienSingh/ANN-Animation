class Button{
    String label; 
    int posx, posy, width, height; 
    boolean hoover; 
    /*
        how does Java handle the parsing of a callable 
    */ 
    Button(String l, int x, int y, int w, int h){
        label = l; 
        width = w; 
        height = h;
        posx = x-width/2; 
        posy = y-height/2; 
        hoover = false;  
    }

    void onHover(float mx, float my){
        if(mx > posx && mx < posx+width 
            && my > posy && my < posy+height){
            hoover = true; 
        }else{
            hoover = false; 
        }
    }

    void update(){
        System.out.println(String.format("%s", hoover));
        onHover(mouseX, mouseY);
        stroke(255, 255, 0); 
        if(!hoover){
            fill(10, 10, 10, 155);
            rect(posx, posy, width, height); 
        }else{
            fill(255, 255, 0, 155); 
            rect(posx, posy, width, height);
        }
        stroke(255, 255, 255);
        fill(255, 255, 255, 255);  
        text(label, posx+width/10, posy+height/2); 
        noFill(); 
    }
}