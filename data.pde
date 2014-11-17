class data {
  
  ArrayList<Float> lat,  lon;
  ArrayList<String> time;
  
  ArrayList<point> gridPoints;
  
   data(ArrayList<Float> la, ArrayList<Float> lo, ArrayList<String> t) {
//  lat = new ArrayList<Float>();
//  lon = new ArrayList<Float>();
     //time = new ArrayList<Float>();
      gridPoints = new ArrayList<point>();
     lat = la;
     lon = lo;
     time = t;
    
    println(lat);
    println(lo);
    println(time);
    println("---");
   }
  
  
  
  
  
  void distortMap() {
   
   
   for (int i = 0; i<lat.size()-1; i++) {
     float lat1 = lat.get(i);
     float lat2 = lat.get(i+1);
     float lon1 = lon.get(i);
     float lon2 = lon.get(i+1);
     String tt = time.get(i);
     float t = float(tt.substring(0,tt.length()-3));
    //println(t); 
    //println(timeToDist(t));
    int x1,x2,y1,y2;
    
    gridPoints.add( getBlock(lat1, lon1) );
    
    if (i>0) {
     point pp = gridPoints.get(i-1);
     point ppp = gridPoints.get(i);
     
     if (pp.startX!=ppp.startX && pp.startY != ppp.startY) {
      int oldDist = int(dist(pp.x,pp.y,ppp.x,ppp.y));
       String oldtt = time.get(i);
     float oldt = float(tt.substring(0,tt.length()-3));
       //println(oldt + " ms");
       int newDist = int( timeToDist(oldt)  );
      // println("newDist " + newDist);
       pp.connections.add(ppp);
        pp.distances.append(newDist);
        pp.positions.append(-1);
       ppp.connections.add(pp); 
       ppp.distances.append(newDist);
       ppp.positions.append(-1);
       
       for (int p = 0; p < points.size(); p++) {
        point poi = points.get(p);
        // println(poi.x + " " + poi.y);
       
        float range = map(poi.workX, pp.workY, ppp.workX, 0, 1);
        float yrange = map(poi.workY, pp.workY,ppp.workY,0,1);
        
        if (poi.workY==pp.workY && poi.workY==ppp.workY) {
         yrange = .5; 
        }
        
        if (poi.workX==pp.workX && poi.workX==ppp.workX) {
         range = .5; 
        }
        
        
         if (range>=0 && range<=1 && yrange>=0 && yrange<=1) {
         
           println("coloring");
             poi.col = color(5,5,5);
                println(poi.id);
           coloringCount++;
           
          float amount = newDist/oldDist;
          amount = .1;
          println(amount + "  : amount");
           reduceDistance(poi,amount);
           
       
           
           
           
         }
         
         
         
        
         
       }
       
       
     }
     
      
    }
     
     
     
   }
   
   
  }
 
 
 void display() {
  fill(255,255,255);
  stroke(255,255,255);
  println(gridPoints.size());
  for (int i = 0; i<gridPoints.size(); i++) {
    fill(gridPoints.get(i).col);
   rect(gridPoints.get(i).x, gridPoints.get(i).y,10,10);
   fill(gridPoints.get(i).col);
   fill(255,255,255);
   if (i<gridPoints.size()-2) {
    line(gridPoints.get(i).x, gridPoints.get(i).y,gridPoints.get(i+1).x, gridPoints.get(i+1).y); 
     if (i>0) {
        text( time.get(i+1),gridPoints.get(i+1).x, gridPoints.get(i+1).y+30); 
     }
   }
  //text( lat.get(i) + " " + lon.get(i),gridPoints.get(i).x, gridPoints.get(i).y+30); 
//    println(lat.get(i) + " " + lon.get(i));
//   println(gridPoints.get(i).x + " " + gridPoints.get(i).y);
//   println("sdfsdfSdsfsdfsdf");
  }
  
 } 
  
  
  
  
  
  
  
}
