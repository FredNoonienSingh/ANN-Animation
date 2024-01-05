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

Integer[] LayerSizes = {2,4,2};
Network network = new Network(LayerSizes); 
ArrayList<DataPoint> Data = new ArrayList<>();

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
    frameRate(60);

    for (int i = 0; i < dataPointCount; i++){
        float xValue = random(0.0, WIDTH);
        float yValue = random(0.0, HEIGHT);
        DataPoint dp = new DataPoint(xValue, yValue);
        Data.add(dp);
    }





}

float MSE(){
    return errorTerm/epoch; 
} 

void learn(DataPoint dp){
   predict(dp);
}

float predict(DataPoint dp){
    System.out.println("got deleted because of stupid");
    return 0.0; 
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
            network.update(); 
            // moved in to seperate loop so it renders after the whole Network
            break;
    }
    switchButton.update();
}