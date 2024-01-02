/*
Animation of an Artifical Neuronal Network
*/

static int WIDTH = 1080;
static int HEIGHT = 720;
final float LEARNING_RATE = 0.2;

int epoch = 0;
int iteration = 0;
int dataPointCount = 10000;
boolean isLearning = false;
boolean renderLable = false; 

float errorTerm = 0; 

Mode mode = Mode.NETWORK;
String modeStr = "Switch View";
String trainLable = "train"; 
String resetLable = "reset"; 
String lableLable = "Lable"; 

Integer[] LayerSizes = {2,4,8,4,2};
ArrayList<DataPoint> Data = new ArrayList<>();
ArrayList<ArrayList> Network = new ArrayList<>();
Button switchButton = new Button(modeStr, WIDTH-80, HEIGHT-50, 150, 80);
Button learnButton = new Button(trainLable, WIDTH-(WIDTH-80), HEIGHT-50, 150, 80);
Button resetButton = new Button(resetLable, WIDTH-80, HEIGHT-(HEIGHT-50), 150, 80);
Button lableButton = new Button(lableLable, WIDTH-80, HEIGHT-(HEIGHT-150), 150, 80);


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
    if(lableButton.hoover){
        renderLable = !renderLable; 
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
    size(1080, 720);
    frameRate(20);

    for (int i = 0; i < dataPointCount; i++){
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
                    n.rgb = new float[] {0, 0, 255}; 
                } else{
                    n.rgb = new float[] {255, 0, 0}; 
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
                n.addConnection(n ,nextNode, random( 0, 1));
            }
        }
    }
}

float MSE(){
    return errorTerm/epoch; 
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
                //float bias = random(-5, 5);
                Connection con = cons.get(l);
                Node parent = con.parent;
                float temp = LEARNING_RATE *parent.value *con.bias * derror;
                con.strength = Util.sigmoid(temp);
                con.bias = LEARNING_RATE * parent.value * derror; 
                System.out.println(String.format(
                    "Node-%s:\n\ttemp: %s\n\tWeight: %s\n\tBias: %s\n\n\tDERROR: %s\n\n\n",
                    parent.id,temp,con.strength, con.bias, derror)
                );
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
        // Iteration over Layers
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
                childNode.value = Util.sigmoid(node.value *con.bias* con.strength);
            }
        }
    }
    ArrayList<Node> outputLayer =  Network.get(Network.size()-1);
    float output = outputLayer.get(0).value + outputLayer.get(1).value;
    errorTerm += sq(output); 
    return output;
}

void draw(){
    background(35, 35, 35);
    switch(mode){
        case DATA:
            background(0, 0, 0);
            String l = String.format(
                "rendered: %s \nout of: %s \n DataPoints",
                iteration,Data.size()
            );
            for (int i = 0; i < iteration; i++){
                DataPoint dp = Data.get(i);
                dp.draw();
            }
            if (iteration < Data.size()){
                iteration += 10;
            }else{
                resetButton.update();
            }
            text(l, 50,50);
            break;

        case NETWORK:
            String trainingLable = String.format(
                "Trained for: %s epochs\n\tMSE: %s"
                ,epoch, MSE()
            );
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

            // moved in to seperate loop so it renders after the whole Network
            if(renderLable){
                for (int i = 0; i < Network.size(); i++){
                    for (int j = 0; j < LayerSizes[i]; j++){
                            ArrayList<Node> Layer = Network.get(i);
                            Node no = Layer.get(j);
                            no.show_id(); 
                    }
                }
            }
            lableButton.update(); 
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