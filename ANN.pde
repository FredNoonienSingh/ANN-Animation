/*
Animation of an Artifical Neuronal Network
*/

int WIDTH = 1024; 
int HEIGHT = 768;
float LEARNING_RATE = 0.01; 
boolean isRunning = true;

Integer[] LayerSizes = {2,8,6,2};
ArrayList<ArrayList> Network = new ArrayList<>(); 
ArrayList<Input> Inputs = new ArrayList<>(); 

class Button{
    int posx, posy, width, height; 
    boolean hoover; 
    /*
        how does Java handle the parsing of a callable 
    */ 
    Button(int x, int y, int w, int h){
        posx = x; 
        posy = y; 
        width = w; 
        height = h;
        hoover = false;  
    }
    void onHover(float mx, float my){
        if(mx <= posx && mx >= posx+width && my <= posy && my >= posy+height){
            hoover = true; 
        }
        hoover = false; 
    }
    void update(){
        rect(posx, posy, width, height); 
    }
}

class Input{
    float posy;
    int secCount;  
    Node targetNode; 
    //ArrayList<float> Values = new ArrayList<>(); 
    
    Input(Node t){
        targetNode = t;
        posy = targetNode.posy;
        secCount = round(posy)/10; 
    }
    void update(){
        strokeWeight(8);
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
            strokeWeight(strokeW);
        }else{
            stroke(0, 255, 255, alphaValue); 
            strokeWeight(strokeW);
        }
        try {
            line(parent.posx, parent.posy, child.posx, child.posy); 
        } catch (Exception e) {
            System.out.println(String.format("%s", e));
        }
    }
}

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

// Class Input & Output Node

void setup(){
    size(1024, 768);
    frameRate(24);
    for(int i=0; i<LayerSizes.length; i++){
        ArrayList<Node> Layer = new ArrayList<>();
        Network.add(Layer);
    }

    for(int i = 0; i<Network.size(); i++){
        float NetworkWidth = WIDTH/(Network.size() +1); 
        for(int j = 0; j<LayerSizes[i]; j++){
            float LayerHeight = HEIGHT/(LayerSizes[i]+1);
            Node n = new Node(NetworkWidth*(i+1), LayerHeight*(j+1),LEARNING_RATE);
            Network.get(i).add(n);
            if(i == 0){
                Input in = new Input(n); 
                Inputs.add(in); 
            }
        }
    }

    for(int i = 0; i<Network.size()-1; i++){
        ArrayList<Node> Layer = Network.get(i);
        ArrayList<Node> NextLayer = Network.get(i+1);
        for(int j = 0; j<Layer.size(); j++){
            Node n = Layer.get(j); 
            for(int k = 0; k<NextLayer.size(); k++){
                Node nextNode = NextLayer.get(k);
                n.addConnection(n ,nextNode);
                System.out.println(n.Connections.get(0));
            }
        }
    }
}

void draw(){
    background(5, 5, 5);

    if(isRunning){

        for(int i = 0; i<Inputs.size(); i++){
            Inputs.get(i).update(); 
        }

        for(int i = 0; i<Network.size(); i++){
            for(int j = 0; j < LayerSizes[i]; j++){
                ArrayList<Node> Layer = Network.get(i);
                Node no = Layer.get(j);
                for(int k = 0; k<no.Connections.size(); k++){
                    Connection con = no.Connections.get(k);
                    con.update();
                }
                no.update();
            }
        }
    }else{
        System.out.println("Annimation not running");
    }
}
