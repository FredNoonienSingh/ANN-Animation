class Input{
    float posy;
    int secCount;  
    Node targetNode; 
    
    Input(Node t){
        targetNode = t;
        posy = targetNode.posy;
        secCount = round(posy)/10; 
    }
    void update(){
        strokeWeight(4);
        stroke(0, 255,255);
        line(0, posy, targetNode.posx, posy);
    }
}