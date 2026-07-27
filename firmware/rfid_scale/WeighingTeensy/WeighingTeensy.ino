/* Here we just copy codes that works perfectely based on our touchscreen setup*/

#include "ArCOM.h"

#define MODULE_INFO 255  // returns module information
#define FirmwareVersion "0001" // Version Nr. returned upon request
#define moduleName "Weighing_RFIDTeensy" // Module name used to identify desired Serial device


ArCOM Serial2COM(Serial2); // UART serial port // change this based on your serial connection
ArCOM Serial3COM(Serial3); // UART serial port // change this based on your serial connection
ArCOM SerialCOM(Serial); // UART serial port // change this based on your serial connection


int i = 0;
int j = 0;
int readByte1 = 0;
int readByte2 = 0;
int readByteSerial = 0;
const int length_of_id = 12;  // This has to bew defined beforehand because we can not determine it at runtime!
const int length_of_string = 24; // 
char newTag1[length_of_id];
char newTag2[length_of_id];

long int serialClocker = millis();
int serialResetTime = 10;
bool serial1read = false;
bool serial2read = false;

/*
void serialEvent(){ // function to listen to the serial connection continusely
  while(Serial.available()){
    readByteSerial = SerialCOM.readByte();
    if (readByteSerial == MODULE_INFO){ // to return the module info to the python code
      returnModuleInfo();
    }
  }

}
*/

void serialEvent2() { // Weighing sys pin
  serialClocker = millis();
  // Variable to hold each byte read from the serial buffer
  while(Serial2.available()){
    readByte1 = Serial2COM.readByte();    
    newTag1[j] = readByte1;
    j++;
  }
  serial1read = true;
}


void serialEvent3() { //RFID pin
  serialClocker = millis();
  // Variable to hold each byte read from the serial buffer
  while(Serial3.available()){
    readByte2 = Serial3COM.readByte();    

    if (readByte2 != 2 && readByte2 != 13 && readByte2 != 10 && readByte2 != 3) {
      newTag2[i] = readByte2;
      i++;
    }
  }
  serial2read = true;
}



void setup() {

  // put your setup code here, to run once:
  Serial2.begin(9600); //baud rate for UART bpod serial communication
  Serial3.begin(9600); //baud rate for UART bpod serial communication
  Serial.begin(9600);

}

void loop() {
  
  // put your main code here, to run repeatedly:
  if (i > 0){
    //Serial.println("Here!");
    if ((millis() - serialClocker) > serialResetTime) {  // done with stim trigger
        
        // reset serial array for next read
        i = 0;
        // decide what to do next
        
        if (serial2read){
            //sendString(3, newTag2); // communicate ID to python
            sendID(2, newTag2);
            memset(newTag2, 0, sizeof(newTag2));  // initialize as 0s

                if (serial1read){
                  j = 0;
                sendString(5, newTag1); // communicate weight to python
                memset(newTag1, 0, sizeof(newTag1));  // initialize as 0s
              }
              }
            }
        }
    
if (Serial.available()) {
  char incoming = Serial.read();

  // Check if the incoming data is "ID?"
  if (incoming == 'I') {
    delay(10);  // Short delay to ensure we have the complete command
    if (Serial.available()) {
      char secondChar = Serial.read();
      if (secondChar == 'D') {
        if (Serial.available()) {
          char thirdChar = Serial.read();
          if (thirdChar == '?') {
            // Respond with "OpenScale"
            Serial.println(F("RFID"));
          }
        }
      }
    }
  }
}


    }
  




void sendString(int header, const char* ID){
  Serial.write(header);
  Serial.write(ID);
  Serial.println(ID);
  Serial.write(0);
}

void sendID(int header, char* ID){
  Serial.write(header);
  Serial.write(length_of_id); // Length of module name
  Serial.print(ID); // Module name
  Serial.write(0); // 1 if more info follows, 0 if not
}

void returnModuleInfo() { // function to return info and name to the serial connection
  Serial.write(65); // Acknowledge
  Serial.write(FirmwareVersion); // 4-byte firmware version
  Serial.write(sizeof(moduleName)-1); // Length of module name
  Serial.print(moduleName); // Module name
  Serial.write(0); // 1 if more info follows, 0 if not
}
