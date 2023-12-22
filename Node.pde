class Node{
    float posx, posy,weight, r, g, b, radius;
    String id; 
    boolean hoover = false; 
    ArrayList<Connection> Connections = new ArrayList<>(); 

    Node(float x,float y, int layer, int height){
        posx = x; 
        posy = y; 
        id = String.format("ID: %s-%s", layer, height); 
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
            float strength = con.strength; 
            rValue = rValue + (prevNode.r*Util.sigmoid(strength)); 
            gValue = gValue + (prevNode.g*Util.sigmoid(strength)); 
            bValue = bValue + (prevNode.b*Util.sigmoid(strength)); 
            nodeCount ++; 
        }
        r = map(rValue, 0, 255*nodeCount, 0, 255); 
        g = map(gValue, 0, 255*nodeCount, 0, 255);
        b = map(bValue, 0, 255*nodeCount, 0, 255);
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