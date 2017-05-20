import processing.serial.*;

PrintWriter output;
int port = 5; //change the 0, 1, 2 to match port

Serial myPort;
String val;
PImage img;
Table table; 

void setup() {
  output = createWriter("data.txt"); //create new file 
  table = new Table();  
  size(500,500);
  String portName = Serial.list()[port]; 
  myPort = new Serial(this, "/dev/tty.usbmodem14541", 9600);
  myPort.bufferUntil('\n');
  table.addColumn("Voltage"); 
  table.addColumn("Day");
  table.addColumn("Month");
  table.addColumn("Year");
  table.addColumn("Hour");
  table.addColumn("Minute"); 
  img = loadImage("sun.png");
}

void draw() {
 TableRow newRow = table.addRow();
 background(0,225,225);
 image(img, 0, 0,width,height);
 output.print(val);
 newRow.setString("Voltage", val);  
 if(val != null){
   output.print(" ");
   output.print(day());
   newRow.setInt("Day",day());
   output.print("/");
   output.print(month());
   newRow.setInt("Month",month()); 
   output.print("/");
   output.print(year());
   newRow.setInt("Year",year()); 
   output.print(" - ");
   output.print(hour());
   newRow.setInt("Hour",hour());  
   output.print(":");
   output.println(minute());
   newRow.setInt("Minute",minute());  
   output.println("");
 }
 if ( myPort.available() > 0) {  
    val = myPort.readStringUntil('\n');        
  } 
  println(val); //print it out in the console
  saveTable(table, "data/datalog.csv","csv"); 
  output.flush(); // Writes the remaining data to the file
  delay(100);
}