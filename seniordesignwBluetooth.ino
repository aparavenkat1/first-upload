
#include <SoftwareSerial.h>
//First Initialize TX and RX pins in Arduino
SoftwareSerial EEBlue(10,11); //RX|TX
//Intialize the tanmsitter pin
#define LEDPIN 13
//Initialize the reciever pins for 3 different chairs 
#define SENSORPIN1 4 
#define SENSORPIN2 8
#define SENSORPIN3 6
//Variables to read sensor states
int sensorState1 = 0, lastState=0;         // variable for reading the pushbutton status
int sensorState2=0;
int sensorState3=0; 
void setup() {
  // initialize the LED pin as an output:
  pinMode(LEDPIN, OUTPUT);      
  // initialize the sensor pin as an input:
  pinMode(SENSORPIN1, INPUT);
  pinMode(SENSORPIN2, INPUT); 
  pinMode(SENSORPIN3, INPUT);      
  digitalWrite(SENSORPIN1, HIGH); // turn on the pullup
  digitalWrite(SENSORPIN2, HIGH);
  digitalWrite(SENSORPIN3, HIGH);
  Serial.begin(9600); //Set Baud Rate
  EEBlue.begin(9600); //Set Baud Rate
}
 
void loop(){
  // read the state of the sensors:
  sensorState1 = digitalRead(SENSORPIN1);
  sensorState2 = digitalRead(SENSORPIN2);
  sensorState3 = digitalRead(SENSORPIN3);
  digitalWrite(LEDPIN,HIGH);
  // check if the sensor beam is broken
  // if it is, the sensorState is LOW:
  // Means seat is occupied
  int vacant[3]; //Array that stores vacant/occupied data
  char Str[3]={'1','1','1'};
  if (sensorState1==HIGH) {
    vacant[0]=1;
    Str[0]='1';
  }
  else
  {
    vacant[0]=0;
    Str[0]='0';
  }
  if (sensorState2==HIGH) {
    vacant[1]=1;
    Str[1]='1';
  }
  else
  {
    vacant[1]=0;
    Str[1]='0';
  }
  if (sensorState3==HIGH) {
    vacant[2]=1;
    Str[2]='1';
  }
  else
  {
    vacant[2]=0;
    Str[2]='0';
  }

  for(int i=0;i<3;i++)
  {
    Serial.print(vacant[i]); // Printing in Serail window
  }
  Serial.println();
  delay(1); //Delay to avoid sending unwanted characters 
  EEBlue.println(Str); //Sending data via HC-05 shield
  delay(100);
 }
  
