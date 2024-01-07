class Network{
    ArrayList<Layer> layers = new ArrayList<>(); 

    public Network(Integer[] layersSizes){
        
        for(int i = 0; i<LayerSizes.length; i++){
            float layerX = (WIDTH/(LayerSizes.length+1))*(i+1); 
            Layer l = new Layer(LayerSizes[i], i, layerX);
            layers.add(l); 
        }
        addConnections(); 
    }

    void addConnections(){
        for(int i = 0; i<layers.size()-1; i++){
            Layer layer = layers.get(i);
            Layer next_layer = layers.get(i+1); 
            for(int j = 0; j<layer.size(); j++){
                Node node = layer.get_node(j);
                float[] colors = {random(0,255), random(0,255), random(0,255)};
                node.rgb = colors;  
                for(int k = 0; k<next_layer.size(); k++){
                    Node next_Node = next_layer.get_node(k); 
                    node.addConnection(node, next_Node); 
                }
            }
        }
    }

    void learn(DataPoint dp){
        predict(dp);
    }

    float predict(DataPoint dp){
        return 0.0; 
    }

    void update(){
        for (int i = 0; i < layers.size(); i++){
            Layer layer = layers.get(i); 
            layer.update(); 
        }
    }
}