float blockWidth, blockHeight;

ArrayList<point> points;
ArrayList<block> blocks;
ArrayList<data> theData;

PImage img;

int coloringCount = 0;

float w = -179.9719;
float s = -60.587;
float e = 179.9719;
float n = 115.323;

int numOfBlocks = 30;

void setup() {
 size(1220,720,P2D); 
  background(0,0,0);
  frameRate(10);
  img = loadImage("blank.png");
  println(img.width);
  
  blockWidth = width/numOfBlocks;
  blockHeight = height/numOfBlocks;
  points = new ArrayList<point>();
  blocks = new ArrayList<block>();
  theData = new ArrayList<data>();
  
  float x = 0;
  float y = 0;
  int iCount = 0;
  while(y<=height) {
    points.add( new point((int)x,(int)y, iCount) );
    x+=blockWidth;
    
    if (x>width) {
     x=0;
     y+=blockHeight;
    }
    
    
    iCount++;
  }
  
 int blockCount = points.size();
 int xCount  = 0;
 int yCount = 0;
 int counter = 0;
 for (int i = 0; i< points.size(); i++) {
   
    int id = xCount + (yCount * numOfBlocks);
//   println(id + " " + i + " " + xCount);
//   println(round((points.get(i).x/width) * numOfBlocks) + " " + points.get(i).x);
  
  int newX, newY,  newid;
   ArrayList<point> ps = new ArrayList<point>();
  
  
  newY = yCount - 1;
  println("asdfasdfasf: " + newY + " " + yCount);
   if (newY>=0) {
    newX = xCount -  1;
    if (newX>=0) {
    newid = i - (numOfBlocks + 2);
    points.get(i).connections.add( points.get(newid) );
    points.get(i).distances.append(int(dist(points.get(newid).x,points.get(newid).y,points.get(i).x, points.get(i).y)));
    points.get(i).positions.append(0);
    }
    
    newX = xCount;
     newid = i - (numOfBlocks + 1); 
    points.get(i).connections.add( points.get(newid) );
    points.get(i).distances.append(int(dist(points.get(newid).x,points.get(newid).y,points.get(i).x, points.get(i).y)));
    points.get(i).positions.append(1);
// 
    newX = xCount+1;
    if (newX<=numOfBlocks) {
     newid = i - (numOfBlocks); 
    points.get(i).connections.add( points.get(newid) );
     points.get(i).distances.append(int(dist(points.get(newid).x,points.get(newid).y,points.get(i).x, points.get(i).y)));
     points.get(i).positions.append(2);
    }
   
       } 
   //println(ps);
    newY = yCount + 1;
   if (newY<=numOfBlocks) {
    newX = xCount -  1;
    if (newX>=0) {
    newid = i + (numOfBlocks);
    points.get(i).connections.add( points.get(newid) );
   points.get(i).distances.append(int(dist(points.get(newid).x,points.get(newid).y,points.get(i).x, points.get(i).y)));
   points.get(i).positions.append(5);
    }
    
    newX = xCount;
    newid =  i + (numOfBlocks+1); 
    points.get(i).connections.add( points.get(newid) );
   points.get(i).distances.append(int(dist(points.get(newid).x,points.get(newid).y,points.get(i).x, points.get(i).y)));
   points.get(i).positions.append(6);
 
    newX = xCount+1;
    if (newX<=numOfBlocks) {
    newid = i + (numOfBlocks+2); 
   points.get(i).connections.add( points.get(newid) );
   points.get(i).distances.append(int(dist(points.get(newid).x,points.get(newid).y,points.get(i).x, points.get(i).y)));
   points.get(i).positions.append(7);
    }
   
       } 
//       
           newY = yCount;
           newX = xCount -  1;
           println(xCount + " " + newX);
    if (newX>=0) {
    newid = i - 1;
    points.get(i).connections.add( points.get(newid) );
  points.get(i).distances.append(int(dist(points.get(newid).x,points.get(newid).y,points.get(i).x, points.get(i).y)));
  points.get(i).positions.append(3);
    }
    
     newX = xCount +  1;
           println(xCount + " " + newX);
    if (newX<=numOfBlocks) {
    newid = i + 1;
    points.get(i).connections.add( points.get(newid) );
     points.get(i).distances.append(int(dist(points.get(newid).x,points.get(newid).y,points.get(i).x, points.get(i).y)));
     points.get(i).positions.append(4);
    }
           
   println(points.get(i).connections);
   
  
 
  
  
   
   xCount++;
   if (xCount>numOfBlocks) {
  
    xCount=0;
   yCount++; 
   } else {
    counter++; 
   }
   
 }  //end for loop for creating blocks
  
    
   for (int i = 0; i< points.size(); i++) {
  // points.get(i).messUpDist(); 
  }
    
    
    float blockX = 0;
    float blockY = 0;
    int iCounter = 0;
    
     for (int i = 0; i< points.size() - numOfBlocks - 1; i++) {
         
    
    blocks.add(new block(points.get(i), points.get(i+1), points.get(i+numOfBlocks+2), points.get(i+numOfBlocks+1) ) );
    println(blockX + " " + blockY); 
    
        blockX++;
        iCounter++;
   if (blockX>numOfBlocks-1) {
  
    
    
     i++;     
    blockX=0;
   blockY++; 
   } else {
    counter++; 
   }
       
     }
  
  
  
  
  
  
  
  
  
  
  JSONObject file = loadJSONObject("output.json");
 //for (int f = 0; f< file.size(); f++) {
  JSONObject folders = file.getJSONObject("3");
 
  JSONObject data = folders.getJSONObject("data");
  
  for (int d = 0; d<data.size();d++) {
  JSONObject sites = data.getJSONObject(str(d));
  
  //println(sites.size());
  ArrayList<Float> la = new ArrayList<Float>();
    ArrayList<Float> lo = new ArrayList<Float>();
      ArrayList<String> t = new ArrayList<String>();
  for (int i = 2; i<sites.size(); i++) {
    JSONObject site = sites.getJSONObject(str(i));
   // println(i);
    //println(site);
    if (site.hasKey("long") && site.hasKey("time") && site.hasKey("ip")) {
      //println(site.getString("long"));
    String name = site.getString("name");
    //String address = site.getString("city") + " " + site.getString("state") + " " + site.getString("country");
    String address = "AsdasD";
    float lat = site.getFloat("lat");
    float lon = site.getFloat("long");
    String time = site.getString("time");
    la.add(lat);
    lo.add(lon);
    t.add(time);
    //JSONArray ips = site.getJSONArray("ip");
    //String ip = ips.getString(0);
    String ip = "asf";
    //points.add(new vert(lat, lon, i, address, ip, name));
    
    }
    
  }
  
  theData.add(new data(la, lo, t));
  
  
  }
  
  
  
 // println("ooogaaaabooooooooogggaaaaaaa " + theData.size());
  theData.get(0).distortMap();
theData.get(1).distortMap();
theData.get(3).distortMap();
//  theData.get(4).distortMap();
//  theData.get(5).distortMap();
//  theData.get(9).distortMap();
//  theData.get(18).distortMap();
  
 // println(coloringCount + "      dsfasdfasdCOLORINGCOUNT");
  
} 




void draw() {
  background(0,0,0);
  fill(255,255,255);
  

  
  for (int i =0 ; i<points.size(); i++) {
    point pp = points.get(i);
    pp.xForce = 0;
    pp.yForce = 0;
    }
  
  
  for (int i =0 ; i<points.size(); i++) {
   point pp = points.get(i);
   pp.showConnections();
   //pp.stickToSpot();
   pp.update();
   pp.pull();
   pp.push();
   //pp.stickToSpot();
   fill(pp.col);

   rect(pp.x,pp.y,5,5);
  
    
  }
  
   for (int i =0 ; i<points.size(); i++) {
     point pp = points.get(i);
     if (abs(pp.xForce)>1.3) {
    pp.x+=pp.xForce;
    
     }
     
     if (abs(pp.yForce)>1) {
            
   pp.y += pp.yForce; 
     }
    
    //println(pp.xForce); 
   }
  
  
    for (int i =0 ; i<points.size(); i++) {
   point pp = points.get(i);
   pp.push();
    }
  
    for (int i =0 ; i<points.size(); i++) {
    point pp = points.get(i);
    pp.applyForce();
    
    }
  
  
  for (int i = 0; i<blocks.size(); i++) {
    
   //if (dist(mouseX, mouseY,blocks.get(i).centerX, blocks.get(i).centerY)<.25*width) {
  //blocks.get(i).display(); 
   // }
    
  }
  
  for (int i = 0; i<theData.size(); i++) {
    
   // if (dist(mouseX, mouseY,blocks.get(i).centerX, blocks.get(i).centerY)<.25*width) {
   theData.get(i).display(); 
    //}
    
  }
  
}


 void keyPressed() {
  for (int i = 0; i< points.size(); i++) {
   points.get(i).messUpDist(); 
  }
 }
