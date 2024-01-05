

class Network{
    ArrayList<Layer> layers = new ArrayList<>(); 

    public Network(Integer[] layersSizes){
        
        for(int i = 0; i<LayerSizes.length; i++){
            float layerX = (WIDTH/(LayerSizes.length+1))*(i+1); 
            Layer l = new Layer(LayerSizes[i], i, layerX);
            System.out.println(String.format("%s",l)); 
            layers.add(l); 
        }
    }

    void update(){
        for (int i = 0; i < layers.size(); i++){
            Layer layer = layers.get(i); 
            layer.update(); 
        }
    }

}