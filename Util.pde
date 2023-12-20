
static class Util{

    static double sigmoid(float x){
        return 1.0 / (1.0 + Math.exp(-x)); 
    }

    static float primeSigmoid(float x){
        return x * (1-x); 
    }

}