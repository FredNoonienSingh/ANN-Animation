class Node{
    float posx, posy,weight, learning_rate;
    float r, g, b; 
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
        r = 0; 
        g = 255; 
        b = 0; 
    }

    void addConnection(Node parent, Node child){
        Connection con = new Connection(parent, child);
        Connections.add(con);
    }

    void onHover(float mx, float my){
        float disX = posx - mx;
        float disY = posy - my;
        if((sqrt(sq(disX) + sq(disY)) < radius)){
            hoover = true; 
        }else{
            hoover = false; 
        }
    }

    void backProbColor(){
        int nodeCount = 0; 
        float rValue = 255; 
        float gValue = 255; 
        float bValue = 255; 
        for(int i = 0; i<Connections.size(); i++){
            Connection con = Connections.get(i); 
            Node prevNode = con.child;
            rValue = rValue + (prevNode.r*con.strength*2); 
            gValue = gValue + (prevNode.g*con.strength*2); 
            bValue = bValue + (prevNode.b*con.strength*2); 
            nodeCount ++; 
        }
        r = map(rValue, 0, 255*nodeCount, 0, 255); 
        g = map(gValue, 0, 255*nodeCount, 0, 255);
        b = map(bValue, 0, 255*nodeCount, 0, 255);
    }

    void onClick(){
        // Call funktion
    }

    void update(){
        onHover(mouseX, mouseY);
        if(Connections.size()!=0){
            backProbColor();
        } 
        float alphaValue = map(weight, minNodeWeight,maxNodeWeight, 200, 255);
        if(!hoover){
            noStroke();
            radius = 12; 
        }else{
            radius = 17; 
            stroke(255,0,255); 
        }
        fill(r, g, b, alphaValue);
        circle(posx, posy, radius);
    }
}