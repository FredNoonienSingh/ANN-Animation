/*
Animation of an Artifical Neuronal Network
*/

final int WIDTH = 1080; 
final int HEIGHT = 768;
final float LEARNING_RATE = 0.01; 
long shlong; 

boolean isRunning = true;
boolean renderLable = true;
Mode mode = Mode.NETWORK; // Other Value == "Data"

Integer[] LayerSizes = {2,4,8,4,2};
ArrayList<ArrayList> Network = new ArrayList<>(); 
ArrayList<Input> Inputs = new ArrayList<>(); 
ArrayList<DataPoint> Data = new ArrayList<>(); 
Button startButton = new Button("Click to start annimation", WIDTH / 2, HEIGHT / 2, 150, 80); 

void toogleRunning() {
    isRunning = !isRunning; 
}

void setup() {
    size(1080, 768);
    frameRate(60);

        for(int i = 0; i<50000; i++){
            float xValue = random(0.0, WIDTH); 
            float yValue = random(0.0, HEIGHT); 
            DataPoint dp = new DataPoint(xValue, yValue); 
            Data.add(dp); 
        }

        for (int i = 0; i < LayerSizes.length; i++) {
            ArrayList<Node> Layer = new ArrayList<>();
            Network.add(Layer);
        }
        
        for (int i = 0; i < Network.size(); i++) {
            float NetworkWidth = WIDTH / (Network.size() + 1); 
            for (int j = 0; j < LayerSizes[i]; j++) {
                float nodeX = NetworkWidth * (i + 1); 
                float layerHeight = HEIGHT / (LayerSizes[i] + 1);
                Node n = new Node(nodeX, layerHeight * (j + 1),LEARNING_RATE);
                if (i== Network.size() - 1) {
                    if (j % 2 == 0) {
                        n.r = 0; 
                        n.g = 0; 
                        n.b = 255;
                    } else{
                        n.r = 255; 
                        n.g = 0; 
                        n.b = 0;
                    }  
                }
                Network.get(i).add(n);
                if (i== 0) {
                    Input in = new Input(n); 
                    Inputs.add(in); 
                }
            }
        }
        
        for (int i = 0; i < Network.size() - 1; i++) {
            ArrayList<Node> Layer = Network.get(i);
            ArrayList<Node> NextLayer = Network.get(i + 1);
            for (int j = 0; j < Layer.size(); j++) {
                Node n = Layer.get(j); 
                for (int k = 0; k < NextLayer.size(); k++) {
                    Node nextNode = NextLayer.get(k);
                    n.addConnection(n ,nextNode, random( - 1, 1));
                }
            }
        }
}

void learn(){

    /*
    i really need to come up with an idea for this soon
    */ 

}

String predict(DataPoint dp){
    Classification classification = Util.getClass(dp.x, dp.y); 
    boolean truthValue = classification == Classification.RED; 
    return String.format("Datapoint %s got classified as %s\n    >> which is %s",dp,classification,truthValue);
}


void draw() {
    background(15, 15, 15);
    switch (mode) {

    case DATA:
        for(int i = 0; i<Data.size(); i++){
            DataPoint dp = Data.get(i);
            //System.out.println(predict(dp)); 
            dp.draw(); 
        }
        break;

    case NETWORK: 
        for (int i = 0; i < Inputs.size(); i++) {
            Inputs.get(i).update(); 
        }
        
        for (int i = 0; i < Network.size(); i++) {
            for (int j = 0; j < LayerSizes[i]; j++) {
                ArrayList<Node> Layer = Network.get(i);
                Node no = Layer.get(j);
                for (int k = 0; k < no.Connections.size(); k++) {
                    Connection con = no.Connections.get(k);
                    con.update();
                }
                no.update();
            }
        }
        break;

    case SVM:
        String s = "SVM"; 
        text(s, 50, 50); 
        break;

    case SIGMOID:
        String si = "SIGMOID"; 
        text(si, 50, 50); 
        break;
    }
}
