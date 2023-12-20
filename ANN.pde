/*
Animation of an Artifical Neuronal Network
*/

int WIDTH = 1024; 
int HEIGHT = 768;
float LEARNING_RATE = 0.01; 
boolean isRunning = true;

Integer[] LayerSizes = {2,3,2};
ArrayList<ArrayList> Network = new ArrayList<>(); 
ArrayList<Input> Inputs = new ArrayList<>(); 

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
