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

    int size(){
        return nodes.size();
    }

    Node get_node(int i){
        // returns Node at index i in ArrayList nodes
        return nodes.get(i);
    }

    void update(){
        //System.out.println(String.format("%s",nodes.size())); 
        for(int i = 0; i<nodes.size(); i++){
            Node node = nodes.get(i);
            ArrayList<Connection> connections = node.Connections; 
            for(int k = 0; k<connections.size(); k++){
                Connection con = connections.get(k);
                System.out.println(String.format("%s", con)); 
                con.update();
            }
            node.update();
        }
    }

}
