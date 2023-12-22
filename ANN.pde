/*
Animation of an Artifical Neuronal Network
*/

final int WIDTH = 1080; 
final int HEIGHT = 768;
final float LEARNING_RATE = 0.02; 

boolean isRunning = true;
boolean renderLable = true;
int iterattion = 0; 
Mode mode = Mode.NETWORK; // Other Value == "Data"
String modeStr = modeStr = "Switch View";

Integer[] LayerSizes = {2, 4, 8, 4, 2};
ArrayList<ArrayList> Network = new ArrayList<>(); 
ArrayList<DataPoint> Data = new ArrayList<>(); 
Button switchButton = new Button(modeStr, WIDTH-80, HEIGHT-50, 150, 80); 
Button learnButton = new Button("train", WIDTH-(WIDTH-80), HEIGHT-50, 150, 80); 


void mousePressed() {
    if (switchButton.hoover) {
        switchMode(); 
    }
    if (learnButton.hoover) {
        learn(); 
    }
}


void toogleRunning() {
    isRunning = !isRunning; 
}

void switchMode() {
    if (mode == mode.NETWORK) {
        mode = mode.DATA; 
    } else if (mode == mode.DATA) {
        mode = mode.NETWORK; 
    }
}


void setup() {
    size(1080, 768);
    frameRate(144);

    for (int i = 0; i < 10000; i++) {
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
            Node n = new Node(nodeX, layerHeight * (j + 1), i, j);
            if (i == Network.size() - 1) {
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
        }
    }
    for (int i = 0; i < Network.size() - 1; i++) {
        ArrayList<Node> Layer = Network.get(i);
        ArrayList<Node> NextLayer = Network.get(i + 1);
        for (int j = 0; j < Layer.size(); j++) {
            Node n = Layer.get(j); 
            for (int k = 0; k < NextLayer.size(); k++) {
                Node nextNode = NextLayer.get(k);
                n.addConnection(n ,nextNode, random( -5, 5));
            }
        }
    }
}

void learn() {
    float error; 
    float target;
    float output;

    System.out.println("Test"); 
    /*
    i really need to come up with an idea for this soon
    */ 
    
}

String predict(DataPoint dp) {
    Classification classification = Util.getClass(dp.x, dp.y); 
    boolean truthValue = classification == Classification.RED; 
    return String.format("Datapoint %s got classified as %s\n    >> which is %s",dp,classification,truthValue);
}


void draw() {
    background(15, 15, 15);

    switch(mode) {
        
        case DATA:
            String l = String.format("rendered: %s \nout of: %s \n DataPoints",iterattion,Data.size());
            for (int i = 0; i < iterattion; i++) {
                DataPoint dp = Data.get(i);
                dp.draw();
            }
            if (iterattion < Data.size()) {
                iterattion ++; 
            }
            
            text(l, 50,50);
            break;
        
        case NETWORK:
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
            learnButton.update();
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
    switchButton.update();
}
