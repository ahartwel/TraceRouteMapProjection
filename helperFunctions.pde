float timeToDist(float t) {
  
  return t/100 * (blockWidth);
  
}


point getBlock(float lat, float lon) {
   println(lat + " " + lon);
   float yy = map(lat, n, s, 0, blockHeight * numOfBlocks); 
    float xx = map(lon, w,e , 0, width);
    println(xx + " " + yy);
    
 
    
////     println(lat + " " + lon);
//    y = round(y/height * numOfBlocks);
//    x = round(x/width * numOfBlocks);
//  println(x + " fdsf  " + y);
//  int id = int(x + (y*numOfBlocks));
//  println(id);

    point pp = points.get(5);
    float dd = 350;

  for (int i = 0; i<points.size(); i++) {
    point ppp = points.get(i);
    
    if (dist(ppp.lon, ppp.lat, lon, lat)<dd) {
     dd = dist(ppp.lon, ppp.lat, lon, lat);
     println(dd);
    pp = ppp; 
      
    }
    
   //  println( i + " sdfsdfgsdfgsdfgsdfgsdfgsdfgsdfgsdfgdsfgdsfg");   
  }
 



  return pp;
  
}



void reduceDistance(point p,  float amount) {
  
   for (int i = 0; i<p.connections.size(); i++) {
      p.distances.get(i);
      if (p.positions.get(i)>=0) {
        p.distances.set(i, int(p.distances.get(i) * amount ));
        point pp = p.connections.get(i);
        for (int q = 0; q<pp.connections.size();q++) {
         
          if (pp.connections.get(q).id == p.id) {
             pp.distances.set(q, int(p.distances.get(i) * amount ));
          }
          
          
        }
        
        
      }
    
    
   } 
  
}
