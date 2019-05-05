Snowflake s;
int layers,maxLayers;
class Snowflake{
  SnowflakeEdge[] edges;
  Snowflake(float x1,float y1,float sideLength,int edgeCount){
    edges = new SnowflakeEdge[edgeCount];
    edges[0] = new SnowflakeEdge(x1,y1,sideLength,0);
    float angleAdd = radians(360.0/edgeCount);
    for(int i=1;i<edgeCount;i++){
      edges[i] = new SnowflakeEdge(edges[i-1].x2,edges[i-1].y2,
                                   sideLength,edges[i-1].angle+angleAdd);
    }
  }
  void layerDown(){
    for(SnowflakeEdge edge : edges){
      edge.layerDown();
    }
  }
}

class SnowflakeEdge{
  boolean lastLayer;
  float x1,y1,x2,y2,dist,angle;
  SnowflakeEdge[] children;
  SnowflakeEdge(float x1,float y1,float dist,float angle){
    this.x1 = x1;
    this.y1 = y1;
    this.dist = dist;
    this.angle = angle;
    x2 = dist*cos(angle)+x1;
    y2 = y1-dist*sin(angle);
    lastLayer = true;
    children = new SnowflakeEdge[4];
    stroke(0);
    line(x1,y1,x2,y2);
  }
  void layerDown(){
    if(lastLayer){
      float[] tri = trisection();
      stroke(255);
      //line(tri[0],tri[1],tri[2],tri[3]);
      children[0] = new SnowflakeEdge(x1,y1,dist/3,angle);
      children[1] = new SnowflakeEdge(tri[0],tri[1],dist/3,angle+radians(300));
      children[2] = new SnowflakeEdge(children[1].x2,children[1].y2,
                                      dist/3,angle+radians(60));
      children[3] = new SnowflakeEdge(tri[2],tri[3],dist/3,angle);
      lastLayer = false;
    }else{
      for(SnowflakeEdge child : children){
        child.layerDown();
      }
    }
  }
  float[] trisection(){
    float[] out = new float[4];
    out[0] = x1 + (x2-x1)/3;
    out[1] = y1 + (y2-y1)/3;
    out[2] = x2 - (x2-x1)/3;
    out[3] = y2 - (y2-y1)/3;
    return out;
  }
}

void setup(){
  size(610,610);
  background(255);
  layers = 0;
  maxLayers = 10;
  s = new Snowflake(50,400,400,3);
}

void draw(){
  if(layers<maxLayers){
    delay(1000);
    background(255);
    s.layerDown();
    layers++;
  }
}
