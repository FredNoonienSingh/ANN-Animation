/*
Animation of an Artifical Neuronal Network
*/

final int WIDTH = 1080;
final int HEIGHT = 768;
final float LEARNING_RATE = 0.2;

int epoch = 0;
int iteration = 0;
int DataPointCount = 10000;
boolean isLearning = false;

Mode mode = Mode.NETWORK;
String modeStr = "Switch View";

Integer[] LayerSizes = {2,4,8,16,8,4,2};
ArrayList<DataPoint> Data = new ArrayList<>();
ArrayList<ArrayList> Network = new ArrayList<>();
Button switchButton = new Button(modeStr, WIDTH-80, HEIGHT-50, 150, 80);
Button learnButton = new Button("train", WIDTH-(WIDTH-80), HEIGHT-50, 150, 80);
Button resetButton = new Button("Reset", WIDTH-80, HEIGHT-(HEIGHT-50), 150, 80);


void mousePressed(){
    if(switchButton.hoover){
        switchMode();
    }
    if (learnButton.hoover){
       toogleLearning();
    }
    if (resetButton.hoover){
       epoch = 0;
       iteration = 0;
       isLearning = false;
    }
}

void toogleLearning(){
    isLearning = !isLearning;
}

void switchMode(){
    if (mode == mode.NETWORK){
        mode = mode.DATA;
    } else if (mode == mode.DATA){
        mode = mode.NETWORK;
    }
}

void setup(){
    size(1080, 768);
    frameRate(60);

    for (int i = 0; i < DataPointCount; i++){
        float xValue = random(0.0, WIDTH);
        float yValue = random(0.0, HEIGHT);
        DataPoint dp = new DataPoint(xValue, yValue);
        Data.add(dp);
    }

    for (int i = 0; i < LayerSizes.length; i++){
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
                if (j % 2 == 0){
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
    for (int i = 0; i < Network.size() - 1; i++){
        ArrayList<Node> Layer = Network.get(i);
        ArrayList<Node> NextLayer = Network.get(i + 1);
        for (int j = 0; j < Layer.size(); j++){
            Node n = Layer.get(j);
            for (int k = 0; k < NextLayer.size(); k++){
                Node nextNode = NextLayer.get(k);
                n.addConnection(n ,nextNode, random( -1, 1));
            }
        }
    }
}

void learn(DataPoint dp){
    float output = predict(dp);
    float target = dp.classification == Classification.RED ? 0.0 : 1.0;
    float error = output-target;
    float derror = error * Util.sigmoid(output);

    for(int i = Network.size()-1; i>=0;  i--){
        // Iteration over the Layers from output to input
        ArrayList<Node> Layer = Network.get(i);
        for(int j = 0; j<Layer.size(); j++){
            Node node = Layer.get(j);
            ArrayList<Connection> cons = node.Connections;
            for(int l = 0; l<cons.size(); l++){
                Connection con = cons.get(l);
                Node parent = con.parent;
                con.strength += LEARNING_RATE * parent.value * derror;
                con.strength = Util.sigmoid(con.strength);
                System.out.println(String.format("CS %s", con.strength));
            }
        }
    }
}

float predict(DataPoint dp){
    // Decrease distance for input to target Value
    float input1 = dp.x/100;
    float input2 = dp.y/100;
    float[] inputs = {input1, input2};

    for(int i = 0; i<Network.size(); i++){
        //Iteration over Layers 
        ArrayList<Node> Layer = Network.get(i);
        for(int j = 0; j<Layer.size(); j++ ){
            // Iteration over Nodes 
            Node node = Layer.get(j);
            if(i == 0){
                for(int k = 0; k<inputs.length; k++){
                    node.value = inputs[k];
                }
            }
            ArrayList<Connection> cons = node.Connections;
            for(int l = 0; l<cons.size(); l++){
                Connection con = cons.get(l);
                Node childNode = con.child;
                childNode.value = Util.sigmoid(node.value * con.strength);
            }
        }
    }
    ArrayList<Node> outputLayer =  Network.get(Network.size()-1);
    float output = outputLayer.get(0).value + outputLayer.get(1).value;
    return Util.sigmoid(output);
}

void draw(){
    background(51, 51, 51);
    switch(mode){

        case DATA:
            background(0, 0, 0);
            String l = String.format("rendered: %s \nout of: %s \n DataPoints",iteration,Data.size());
            for (int i = 0; i < iteration; i++){
                DataPoint dp = Data.get(i);
                dp.draw();
            }
            if (iteration < Data.size()){
                iteration ++;
            }else{
                resetButton.update();
            }

            text(l, 50,50);
            break;

        case NETWORK:
            String trainingLable = String.format("Trained for: %s epochs", epoch);
            text(trainingLable, 50, 50);
            for (int i = 0; i < Network.size(); i++){
                for (int j = 0; j < LayerSizes[i]; j++){
                    ArrayList<Node> Layer = Network.get(i);
                    Node no = Layer.get(j);
                    for (int k = 0; k < no.Connections.size(); k++){
                        Connection con = no.Connections.get(k);
                        con.update();
                    }
                    no.update();
                }
            }
            learnButton.update();
            if(isLearning){
                if(epoch < Data.size()){
                    DataPoint dp = Data.get(epoch);
                    learn(dp);
                    epoch ++;
                } else{
                    resetButton.update();
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
    switchButton.update();
}
