class point {

  float x, y, startX, startY, workX, workY, tempX, tempY;
  ArrayList<point> connections;
  IntList distances, positions; // 0 is up and left, 9 is bottom and  right
  boolean justStarted = false;
  int id;
  float xForce;
  float yForce;
  float lat, lon;
  color col;

  float imgX, imgY;
  //TO DO - ADD A CURRENTX AND USE THAT INSTEAD OF STARTX


  point (int xx, int yy, int ii) {

    x =xx;
    y = yy;
    startX = x;
    startY = y;
    workX = startX;
    workY = startY;
    
    lat = map(y,0,height,n,s);
    lon = map(x,0,width,w,e);

    xForce = 0;
    xForce = 0;

    col = color(255,255,255);

    imgX = (x/width) * img.width;
    imgY = (y/height) * img.height;

    connections = new ArrayList<point>();
    positions = new IntList();
    distances = new IntList();

    id = ii;
  } 


  void showConnections() {
    stroke(255, 255, 255);
    beginShape();
    for (int i = 0; i<connections.size (); i++) {

      line(x, y, lerp(x, connections.get(i).x, .55), lerp(connections.get(i).y, y, .25));
//      text(connections.get(i).lat, connections.get(i).x, connections.get(i).y);
//      text(connections.get(i).lon, connections.get(i).x, connections.get(i).y+15);
      
    } 
    endShape();
  }



  void stickToSpot() {
    if (dist(x, y, workX, workY)>(.6*blockHeight)) {
      x = lerp(x, workX, .003);
      y = lerp(y, workY, .003);
    }
  }


  void applyForce() {
    
    
   x+=xForce; 
    
    
  }


  void update() {

    if (x<0) {
      x=0;
    } else if (x>width) {
      x=width;
    }

    if (y<0) {
      y = 0;
    } else if (y>height) {
      y = height;
    }

    for (int i = 0; i<connections.size (); i++) {
      point pp = connections.get(i);

      if (positions.get(i)<=2) {
        if (y<pp.y) {

        yForce += lerp(y, workY, .012) - y;
        }
      }

      int pos = positions.get(i);

      if (pos>=5) {
        if (y>pp.y) {

        yForce += lerp(y,workY,.012) - y;
        }
      }

      if (pos==2 || pos ==4||pos==7) {
        if (x>pp.x) {
         xForce += lerp(x,workX,.012) - x;
        }
      }

      if (pos==0 || pos==3 || pos==5) {
        if (x<pp.x) {
         xForce += lerp(x, workX, .012) - x;
        }
      }
    }
    // workY = lerp(workY,  y,  .005);
    // workX = lerp(workX, x, .005);
  }



  void pull() {

    for (int i = 0; i<connections.size (); i++) {
      point pp = connections.get(i);
      int conDist = int(dist(pp.x, pp.y, x, y));
      if (conDist>distances.get(i)) {

         if (positions.get(i)>=0) {
          //pp.xForce += (pp.x-x) 10;
          
          
         float fAdd = lerp(pp.x, x, .009) - pp.x;
        pp.xForce+=fAdd;  
        
        fAdd = lerp(pp.y, y, .009) - pp.y;
        pp.yForce+=fAdd;  

//        pp.x = lerp(pp.x, x, .04);
//        pp.y = lerp(pp.y, y, .04);
         } else {
        // pp.x = lerp(pp.x, x, .01);
        //pp.y = lerp(pp.y, y, .01);
         
            float fAdd = lerp(pp.x, x, .065) - pp.x;
                    pp.xForce+=fAdd;
                    
                      fAdd = lerp(pp.y, y, .065) - pp.y;
        pp.yForce+=fAdd;
         
         
      }
      }
    }
  }


  void messUpDist() {
    //    for (int i = 0; i<distances.size(); i++) {
    //     if (random(0,1)<.1) {
    //       int newD = int(distances.get(i) + random(0,5));
    //       
    //       int change = distances.get(i) - newD;
    //       
    //       int xC = change/2;
    //       int  yC = change/2;
    //       
    //       point ppp = connections.get(i);
    //       if (ppp.x>x) {
    //        ppp.workX -= xC;
    //       workX+=xC;
    //      ppp.workY -= yC; 
    //      workY+=yC;
    //       } else {
    //        ppp.workX += xC;
    //       workX-=xC;
    //      ppp.workY += yC; 
    //      workY-=yC;
    //         
    //       }
    //       
    //      distances.set(i, newD);
    //      
    //       for (int p = 0; p<connections.size(); p++) {
    //         point pp = connections.get(p);
    //         for (int q = 0; q<pp.connections.size(); q++) {
    //          point subp = pp.connections.get(q); 
    //           if (subp.id == id) {
    //              pp.distances.set(q, newD); 
    //           }
    //         }
    //        
    //        
    //      }
    //      
    //      
    //     } 
    //      
    //    }


    for (int i = 0; i<points.size (); i++) {
      if (points.get(i).id!=id) {
        if (random(0, 1)<.04) {
          point pp = points.get(i);
          connections.add( pp );
          int newDist = int(dist(x, y, pp.x, pp.y) * random(.7,1.3) );
          distances.append( newDist );
          positions.append(-1);

          for (int q = 0; q<pp.connections.size (); q++) {
            point subp = pp.connections.get(q); 
            if (subp.id == id) {
              subp.connections.add( this );
              subp.distances.append( newDist );
              subp.positions.append(-1);
            }
          }
        }
      }
    }
  }

  void push() {


    for (int i = 0; i<connections.size (); i++) {
      point pp = connections.get(i);
      //pp.xForce = 0;
      //pp.yForce = 0;

      if (int(dist(pp.x, pp.y, x, y))<distances.get(i)) {
                 if (positions.get(i)>=0) {
        //pp.x = lerp(x, pp.x, 1.002);
        float fAdd = lerp(x, pp.x, 1.0005) - pp.x;
        pp.xForce+=fAdd;
        //pp.y = lerp(y, pp.y, 1.002);
        fAdd = lerp(y, pp.y, 1.0005) - pp.y;
        pp.yForce+=fAdd;
                 } else {
                   
                     float fAdd = lerp(x, pp.x, 1.025) - pp.x;
                    pp.xForce+=fAdd;
                    
                      fAdd = lerp(y, pp.y, 1.025) - pp.y;
        pp.yForce+=fAdd;
//          pp.x = lerp(x, pp.x, 1.05);
//          pp.y = lerp(y, pp.y, 1.05);
                 }
      }

      // pp.x+=pp.xForce;
      //pp.y+=pp.yForce;
    }
  }
}



class block {

  point[] poi = new point[4];
  float w, h;
  color col;
  float centerX, centerY;

  block(point p1, point p2, point p3, point p4) {
    poi[0] = p1; 
    poi[1] = p2;
    poi[2] = p3;
    poi[3] = p4;

    centerX = p1.x + ((p2.x-p1.x)/2);
    centerY = p1.y + ((p2.y-p1.y)/2);

    col = color(int(random(0, 255)), int(random(0, 255)), int(random(0, 255)));
  }





  void display() {
    beginShape();
    // fill(col);
    texture(img);
    //tint(255,50);
    noStroke();
    for (int i = 0; i<poi.length; i++) {
      vertex(poi[i].x, poi[i].y, poi[i].imgX, poi[i].imgY);
      //println(points[i].imgX + " " + points[i].imgY);
    } 
    // line(points[3].x, points[3].y, points[0].x, points[0].y);

    endShape();
  }
}





