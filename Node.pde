class Node{
    float posx, posy,weight, learning_rate;
    float r, g, b; 
    float maxNodeWeight = 1;
    float minNodeWeight = 0;
    int radius = 20;
    boolean hoover = false; 
    ArrayList<Connection> Connections = new ArrayList<>(); 

    Node(float x,float y, float lr){
        posx = x; 
        posy = y; 
        weight = minNodeWeight;
        learning_rate = lr; 
        r = 255; 
        g = 255; 
        b = 255; 
    }

    void addConnection(Node parent, Node child, float s){
        Connection con = new Connection(parent, child, s);
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
        float rValue = 0; 
        float gValue = 0; 
        float bValue = 0; 
        for(int i = 0; i<Connections.size(); i++){
            Connection con = Connections.get(i); 
            Node prevNode = con.child;
            float strength = map(con.strength, -1, 1, 0, 1); 
            rValue = rValue + (prevNode.r*strength); 
            gValue = gValue + (prevNode.g*strength); 
            bValue = bValue + (prevNode.b*strength); 
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
        if(!hoover){
            noStroke();
            radius = 20; 
        }else{
            radius = 30; 
            stroke(255,0,255); 
        }
        fill(r, g, b);
        circle(posx, posy, radius);
    }
}