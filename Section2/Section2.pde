Gasket g;
class Gasket{
  float x1,y1,x2,y2,x3,y3;
  boolean divided;
  Gasket[] children;
  Gasket(float x1,float y1,float x2,float y2,float x3,float y3){
    //just setting fields
  }
  void divide(){
    //IF not already divided
    //remove center
    //create children
    //set divided to true
    //ELSE pass message to children
  }
}  
  
void setup(){
  size(610,610);
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
