
static class Util{

    static float sigmoid(float x){
        return (float)(1.0 / (1.0 + Math.exp(-x))); 
    }

    static float primeSigmoid(float x){
        return x * (1-x); 
    }

}