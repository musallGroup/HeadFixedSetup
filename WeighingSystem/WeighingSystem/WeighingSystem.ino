#include "ArCOM.h"


ArCOM Serial1COM(Serial1); // UART serial port
ArCOM SerialCOM(Serial); // UART serial port
char incomingByte;
String incomingstring;
String secondPart;
int commaIndex;
int commaIndex_test;
int flag =0;


#define FirmwareVersion "0001" // Version Nr. returned upon request
#define moduleName "WeighingSystem" // Module name used to identify desired Serial device
/*
void processLine(char incomingByte) {
  //Serial.println("here");
  // convert incoming char to string
  incomingstring = String(incomingByte);
  //Serial.println(incomingstring);
  // Find the position of the second comma
  commaIndex_test = incomingstring.indexOf(',');
  Serial.println(commaIndex_test);

  commaIndex = incomingstring.indexOf(',', incomingstring.indexOf(',') + 1);
  
  // Extract the substring starting from the position after the second comma
  secondPart = incomingstring.substring(commaIndex + 1);
  
  // Print the second part
  //Serial.println(secondPart);
}
*/

void serialEvent1(){
  while(Serial1.available()){
    flag = 1;
    incomingByte = Serial1COM.readChar();
    
  }
}

void setup() {
  // put your setup code here, to run once:
  Serial1.begin(9600); //baud rate for UART bpod serial communication
  Serial.begin(9600); //baud rate for UART bpod serial communication


}

void loop() {
  if(flag>0){
    Serial.print(incomingByte);
    flag=0;
  }


}





