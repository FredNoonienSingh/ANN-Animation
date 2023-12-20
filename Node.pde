class Node{
    float posx, posy,weight, learning_rate;
    float maxNodeWeight = 1;
    float minNodeWeight = 0; 
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

    void update(){
        float alphaValue = map(weight, minNodeWeight,maxNodeWeight, 155, 255);
        noStroke();
        fill(0, 255, 0, alphaValue);
        circle(posx, posy, 12);
    }
}
