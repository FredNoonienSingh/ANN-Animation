
class Layer{
    int layerSize, layerNumber; 
    float layerX; 
    ArrayList<Node> nodes = new ArrayList<>(); 

    public Layer(int ls, int ln, float lx){
        layerSize = ls; 
        layerNumber = ln; 
        for(int i = 0; i<layerSize; i++){
            float nodeHeight = HEIGHT/(layerSize+1)*(i+1);
            Node node = new Node(lx, nodeHeight, layerNumber, i); 
            nodes.add(node); 
        }
    }

    void update(){
        System.out.println(String.format("%s",nodes.size())); 
        for(int i = 0; i<nodes.size(); i++){
            Node node = nodes.get(i);
            System.out.println(String.format("%s",node)); 

            node.update();
        }
    }

}
