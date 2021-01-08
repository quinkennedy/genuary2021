import java.util.List;

List<PVector> points = new ArrayList<PVector>();
List<List<Integer>> connections = new ArrayList<List<Integer>>();
PVector target;
int stepsPerFrame = 10;

void setup(){
  size(500,500);
  target = new PVector(random(width), random(height));
  addPoint(0,0);
  addPoint(0,width);
  addPoint(height, 0);
  addPoint(width, height);
}

void draw(){
  for(int i = 0; i < stepsPerFrame; i++){
    addPoint(selectPolarPoint());
  }
  background(255);
  stroke(0);
  drawEdges();
}

PVector selectPolarPoint(){
  //get random number
  float a = random(TWO_PI);
  float r = random(1);
  //apply curve
  r *= r;
  //de-normalize
  r *= width;
  //to cartesian
  float x = r*cos(a);
  float y = r*sin(a);
  //relative to "target"
  x += target.x;
  y += target.y;
  
  return new PVector(x, y);
}

PVector selectCartPointInc(){
  //get random number
  float x = random(1);
  float y = random(1);
  //apply curve
  x *= x;
  y *= y;
  //de-normalize
  x*=width;
  y*=height;
  //relative to "target"
  x += target.x;
  y += target.y;
  //wrap to canvas
  x %= width;
  y %= height;
  
  return new PVector(x, y);
}

void drawEdges(){
  for(int i = 0; i < connections.size(); i++){
    for(int connection : connections.get(i)){
      if (connection > i){
        line(
          points.get(i).x, points.get(i).y, 
          points.get(connection).x, points.get(connection).y);
      }
    }
  }
}

int getClosest(PVector v){
  int ci = -1;
  float cd = Float.POSITIVE_INFINITY;
  for(int i = 0; i < points.size(); i++){
    float d = dist(points.get(i).x, points.get(i).y, v.x, v.y);
    if (d < cd){
      cd = d;
      ci = i;
    }
  }
  return ci;
}

int getFurthest(PVector v){
  int ci = -1;
  float cd = 0;
  for(int i = 0; i < points.size(); i++){
    float d = dist(points.get(i).x, points.get(i).y, v.x, v.y);
    if (d > cd){
      cd = d;
      ci = i;
    }
  }
  return ci;
}

void addPoint(float x, float y){
  addPoint(new PVector(x, y));
}

void addPoint(PVector v){
  List myConnections = new ArrayList<Integer>();
  
  int ci = getClosest(v);
  if (ci >= 0){
    connections.get(ci).add(points.size());
    myConnections.add(ci);
  }
  
  points.add(v);
  connections.add(myConnections);
}
