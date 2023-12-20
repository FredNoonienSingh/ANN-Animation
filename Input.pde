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
        strokeWeight(8);
        stroke(0, 255, 55); 
        line(0, posy, targetNode.posx, targetNode.posy);
        for(int i = 0; i>secCount; i++){
                if(i%2 == 1){
                    stroke(0, 255,0);
                }else{
                    stroke(0, 0, 255);
                }
                line(0, posy, targetNode.posx, targetNode.posy); 
        }
    }
}