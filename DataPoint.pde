
class DataPoint{
    float x,y;
    Classification classification; 

    DataPoint(float a, float b){
        x = a; 
        y = b; 
        classification = Util.getClass(x,y); 
    }

    void draw(){
        strokeWeight(2);
        switch (classification){
            case BLUE:
                stroke(0, 0, 255); 
                break;
            case RED:
                stroke(255, 0, 0); 
                break;
            case GREEN:
                stroke(0, 255, 0); 
                break;
        }
        point(x, y);
    }
}