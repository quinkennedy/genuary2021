//run, and then paste the output into 
// https://www.w3schools.com/html/tryit.asp?filename=tryhtml_intro
static int totalColumns = 6;
byte[] frame;


void settings(){
  size(400,400);
}

void start(){
  int bytes = ceil(totalColumns/8.0);
  frame = new byte[bytes];
  
  for(int i = 0; i < totalColumns; i++){
    setColumn(i, floor(random(2)) > 0);
  }
  printFrame();
}

void printByte(byte b){
  for(int i = 0; i < 8; i++){
    print(((b >> (7 - i)) & 1) > 0 ? "1" : "0");
  }
}

boolean rule30(byte b){
  //printByte(b);
  boolean result = (b > 0 && b < 5);
  //println(":"+result);
  return result;
}

void printFrame(){
  //print binary
  for(byte f : frame){
    printByte(f);
  }
  print(" ");
  /*
  //print decimal array
  for(byte f : frame){
    print(f+",");
  }
  print(" ");
  */
  /*
  //print characters
  for(byte f : frame){
    print((char)f);
  }
  println();
  */
  print(String.format("&#x1F6%02X",(byte)((frame[0]>>2)&0x3F)));
  println("<br />");
}

boolean getColumn(int i){
  //loop-around edges
  if (i < 0){
    i = (totalColumns + i);
  }
  i = (i % totalColumns);
  ////alternatively: blank edges
  //if (i < 0 || i >= totalColumns){
  //  return false;
  //}
  int bi = i / 8;
  int bo = i % 8;
  return ((frame[bi] >> (7 - bo)) & 1) == 1;
}

void setColumn(int i, boolean v){
  if (i < 0 || i >= totalColumns){
    //ignore because outside columns
    return;
  }
  int bi = i / 8;
  int bo = i % 8;
  byte mask = (byte)(1 << (7 - bo));
  if (v){
    frame[bi] |= mask;
  } else {
    frame[bi] &= ~mask;
  }
}

void step(){
  byte window = 0;
  
  for(int i = -2; i < totalColumns; i++){
    //shift window
    window = (byte)((byte)(window << 1) & 7);
    //add new data to window
    window |= (getColumn(i+1) ? 1 : 0);
    setColumn(i, rule30(window));
  }
}

void draw(){
  if (frameCount == 20){
    noLoop();
  }
  step();
  printFrame();
}
