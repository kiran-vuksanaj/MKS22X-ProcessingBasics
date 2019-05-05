SnowflakeEdge[] edges;

class SnowflakeEdge{
  boolean lastLayer;
  float x1,y1,x2,y2,dist,angle;
  SnowflakeEdge[] children;
  SnowflakeEdge(float x1,float y1,float dist,float angle,boolean draw){
    this.x1 = x1;
    this.y1 = y1;
    this.dist = dist;
    this.angle = angle;
    x2 = dist*cos(angle)+x1;
    y2 = y1-dist*sin(angle);
    lastLayer = true;
    children = new SnowflakeEdge[4];
    if(draw){
      stroke(0);
      line(x1,y1,x2,y2);
    }
  }
  void layerDown(){
    if(lastLayer){
      float[] tri = trisection();
      stroke(255);
      //line(tri[0],tri[1],tri[2],tri[3]);
      children[0] = new SnowflakeEdge(x1,y1,dist/3,angle,false);
      children[1] = new SnowflakeEdge(tri[0],tri[1],dist/3,angle+radians(300),true);
      children[2] = new SnowflakeEdge(children[1].x2,children[1].y2,
                                      dist/3,angle+radians(60),true);
      children[3] = new SnowflakeEdge(tri[2],tri[3],dist/3,angle,false);
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
  size(600,600);
  background(255);
  edges = new SnowflakeEdge[3];
  edges[0] = new SnowflakeEdge(200,400,200,0,true);
  edges[1] = new SnowflakeEdge(400,400,200,radians(120),true);
  edges[2] = new SnowflakeEdge(edges[1].x2,edges[1].y2,
                               200,radians(240),true);
}

void draw(){
  delay(1000);
  for(SnowflakeEdge edge : edges){
    edge.layerDown();
  }
}
