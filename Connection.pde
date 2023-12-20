class Connection{
    Node parent; 
    Node child; 
    float strength; 

    Connection(Node p, Node c){
        parent = p; 
        child = c; 
        strength = 0;  
    }

    void update(){
        float strokeW = map(strength, 0, 1, 1,4); 
        float alphaValue = map(strength, 0,1, 155, 255);
        if(strength < .25){
            stroke(255, 255, 255, alphaValue);
        }else{
            stroke(0, 255, 255, alphaValue); 
        }
        try {
            if(parent.hoover){
                strokeWeight(strokeW+2);
                line(parent.posx, parent.posy, child.posx, child.posy);  
            }   
            strokeWeight(strokeW);
            line(parent.posx, parent.posy, child.posx, child.posy); 
        } catch (Exception e) {
            System.out.println(String.format("%s", e));
        }
    }
}
