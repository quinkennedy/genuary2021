import processing.svg.*;

PShape segment;
int randX, randY;


void settings(){
  size(700,700);
}

void start(){
  randX = (int)random(width);
  randY = (int)random(height);
  noLoop();
  segment = createShape();
  segment.beginShape();
  segment.fill(0);
  segment.noStroke();
  segment.vertex(-10, 0);
  segment.vertex(-8, 2);
  segment.vertex(8, 2);
  segment.vertex(10,0);
  segment.vertex(8, -2);
  segment.vertex(-8, -2);
  segment.endShape(CLOSE);
}

void draw(){
  beginRecord(SVG, "sweet sixteen.svg");
  background(255);
  fill(0);
  int cellW = 18;
  int cellH = 49;
  int yStart = (int)random(-cellH/2, cellH/2);
  
  for(int cellX = (int)random(-cellW/2, cellW/2);
      cellX < width+cellW;
      cellX += cellW)
  {
    println("cellX " + cellX);
    for(int cellY = yStart; 
        cellY < height+cellH; 
        cellY += cellH)
    {
      pushMatrix();
      translate(cellX, cellY);
      scale(.35, 1);
      float d = dist(randX, randY, cellX, cellY);
      d /= width;
      for(int i = 0; i < 16; i++){
        if (random(1) > d){
          seg(i);
        }
      }
      popMatrix();
    }
  }
  endRecord();
}

void seg(int i){
  pushMatrix();
  int[] tx = new int[]{
    -11, 11, 0, 0, 
    -11, 11, -11, 11, 
    -22, 22, -22, 22,
    -11, 11, -11, 11};
  int[] ty = new int[]{
    0, 0, -11, 11,
    -11, -11, 11, 11,
    -11, -11, 11, 11,
    -22, -22, 22, 22};
  float[] tr = new float[]{
    0, 0, PI/2, PI/2,
    PI/4, PI*3/4, PI*3/4, PI/4, 
    PI/2, PI/2, PI/2, PI/2,
    0, 0, 0, 0};
  translate(tx[i],ty[i]);
  rotate(tr[i]);
  shape(segment);
  popMatrix();
}

void sevseg(){
  pushMatrix();
  shape(segment);
  translate(0, 22);
  shape(segment);
  translate(0, -44);
  shape(segment);
  translate(11, 11);
  rotate(PI/2);
  shape(segment);
  translate(22, 0);
  shape(segment);
  translate(0, 22);
  shape(segment);
  translate(-22, 0);
  shape(segment);
  popMatrix();
}
