class Connection{

    Node parent;
    Node child;
    float weight;
    float bias; 

    public Connection(Node p, Node c, float s){
        parent = p;
        child = c;
        weight = s;
    }

    void update(){
        float strokeW = map(weight, 0, 1, .5,1);
        float alphaValue = map(weight, 0,1, 155, 255);
        if(weight < 0.5){
            stroke(155, 155, 155);

        }else{
            stroke(0, 255, 255);
        }
        try {
            if( parent.hoover){
                strokeWeight(strokeW+1);
                stroke(155,0, 255);
                line(parent.posx, parent.posy, child.posx, child.posy);
            }
            if(child.hoover){
                strokeWeight(strokeW+1);
                stroke(255,0, 155);
                line(parent.posx, parent.posy, child.posx, child.posy);
            }   
            strokeWeight(strokeW);
            line(parent.posx, parent.posy, child.posx, child.posy);
        } catch (Exception e) {
            System.out.println(String.format("%s", e));
        }
    }
}
