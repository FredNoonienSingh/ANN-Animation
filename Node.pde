class Node{

    float posx, posy,weight, learning_rate;
    float maxNodeWeight = 1;
    float minNodeWeight = 0;
    int radius = 12;
    boolean hoover = false; 
    ArrayList<Connection> Connections = new ArrayList<>(); 

    Node(float x,float y, float lr){
        posx = x; 
        posy = y; 
        weight = minNodeWeight;
        learning_rate = lr; 
    }

    void addConnection(Node parent, Node child){
        Connection con = new Connection(parent, child);
        Connections.add(con);
    }

    void onHover(float mx, float my){
        //System.out.println(String.format("%s, %s", mx, my)); 
        float disX = posx - mx;
        float disY = posy - my;
        if(
            (sqrt(sq(disX) + sq(disY)) < radius )
        ){
            hoover = true; 
        }else{
            hoover = false; 
        }
    }

    void update(){
        onHover(mouseX, mouseY); 
        float alphaValue = map(weight, minNodeWeight,maxNodeWeight, 200, 255);
        if(!hoover){
            noStroke();
            radius = 12; 
        }else{
            radius = 17; 
            stroke(255,255,255); 
        }

        fill(0, 255, 0, alphaValue);
        circle(posx, posy, radius);
    }
}
