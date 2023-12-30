
static class Util{

    static float sigmoid(float x){
        return (float)(1.0 / (1.0 + Math.exp(-x)));
    }

    static float primeSigmoid(float x){
        return x * (1-x);
    }

    static float eucliedianDistance(float x_1, float y_1,
                                    float x_2, float y_2){
        return sqrt(sq(x_1-x_2) + sq(y_1 - y_2));
    }

    static Classification getClass (float x, float y){
        float radius = HEIGHT/2;
        float center_x = WIDTH/2;
        float center_y = HEIGHT/2;
        if(eucliedianDistance(x,y,center_x,center_y)<radius){
            return Classification.BLUE;
        }
        return Classification.RED;
    }
}