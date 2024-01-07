class Node{

    float posx, posy, weight, radius;
    int layer, height; 
    float[] rgb = {255, 255, 255}; 
    float value = 0;
    String id;
    boolean hoover = false;
    ArrayList<Connection> Connections = new ArrayList<>();

    public Node(float x,float y, int l, int h){
        posx = x;
        posy = y;
        layer = l;
        height = h;  
        id = String.format("id:%s%s", layer, height);
    }

    void addConnection(Node parent, Node child){
        float weight = random(0, 1); 
        Connection con = new Connection(parent, child, weight);
        Connections.add(con);
    }

    void onHover(float mx, float my){
        float disX = posx - mx;
        float disY = posy - my;
        if((sqrt(sq(disX) + sq(disY)) < radius)){
            hoover = true;
            show_id();
        }else{
            hoover = false;
        }
    }

    void backProbColor(){
        int nodeCount = 0;
        float[] cValue = new float[]{0, 0, 0}; 
        for(int i = 0; i<Connections.size(); i++){
            Connection con = Connections.get(i);
            Node prevNode = con.child;
            float strength = con.weight;
            for(int j =0; j< cValue.length; j++){
                cValue[j] = cValue[j] + (prevNode.rgb[j]*strength);
            }
            nodeCount ++;
        }
        for(int i = 0; i<rgb.length; i++){
            rgb[i] = map(cValue[i], 0, 255*nodeCount, 0, 255);
        }
    }

    void update(){
        onHover(mouseX, mouseY);
        if(Connections.size()!=0){
            //backProbColor();
        }
        if(!hoover){
            noStroke();
            radius = 20;
        }else{
            radius = 30;
            stroke(255,0,255);
        }
        fill(rgb[0],rgb[1],rgb[2]);
        circle(posx, posy, radius);
    }
    void show_id(){
        fill(255, 255, 255);
        double val = Math.round(value*1000)/1000.00d;
        text(String.format("%s\n\t %s", id,val), posx+15, posy+10);
        noFill(); 
    }
}

class BiasNode extends Node{

    public BiasNode(float x,float y, int layer, int height){
        super(x, y, layer, height);
        float bias = 1;
        float radius = 10; 
    }


    @Override void update(){
        stroke(255,255,255); 
        fill(100,100,100);
        circle(posx, posy, radius);
    }
}