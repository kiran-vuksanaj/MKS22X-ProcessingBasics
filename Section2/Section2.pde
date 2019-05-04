Gasket g;
int layers,maxLayers;
class Gasket{
  float x1,y1,x2,y2,x3,y3;
  boolean divided;
  Gasket[] children;
  Gasket(float x1,float y1,float x2,float y2,float x3,float y3){
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    this.x3 = x3;
    this.y3 = y3;
    divided = false;
    children = new Gasket[3];
  }
  void divide(){
    //IF not already divided
    //remove center
    //create children
    //set divided to true
    //ELSE pass message to children
    if(divided){
      for(Gasket child : children){
        child.divide();
      }
    }else{
      float mid1x = (x1 + x2) / 2;
      float mid1y = (y1 + y2) / 2;
      float mid2x = (x2 + x3) / 2;
      float mid2y = (y2 + y3) / 2;
      float mid3x = (x1 + x3) / 2;
      float mid3y = (y1 + y3) / 2;
      fill(255,255,255);
      //println(mid1x+","+mid1y+":"+mid2x+","+mid2y+":"+mid3x+","+mid3y);
      triangle(mid1x,mid1y,mid2x,mid2y,mid3x,mid3y);
      children[0] = new Gasket(x1,y1,mid1x,mid1y,mid3x,mid3y);
      children[1] = new Gasket(x2,y2,mid1x,mid1y,mid2x,mid2y);
      children[2] = new Gasket(x3,y3,mid2x,mid2y,mid3x,mid3y);
      divided = true;
    }
  }
}  
  
void setup(){
  maxLayers = 7;
  layers = 0;
  size(610,610);
  background(255,255,255);
  fill(0,0,255);
  triangle(10,600,
           600,600,
           305,600-305*sqrt(3)
           );
  g = new Gasket(10,600,
                 600,600,
                 305,600-305*sqrt(3)
                 );
}
void draw(){
  if(layers < maxLayers){
    g.divide();
    layers++;
    delay(250);
  }
}
