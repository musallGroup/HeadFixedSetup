#include "Arduino.h"
#include "ArCOM.h"

#define HANDLE_MOTOR_BOTTOM 1
#ifdef HANDLES_MOTOR_BOTTOM
#define LOW_DIR_H HIGH
#define HIGH_DIR_H LOW
#else
#define LOW_DIR_H LOW
#define HIGH_DIR_H HIGH
#endif

#define SPOUT_MOTOR_BOTTOM 1
#ifdef SPOUT_MOTOR_BOTTOM
#define LOW_DIR_S HIGH
#define HIGH_DIR_S LOW
#else
#define LOW_DIR_S LOW
#define HIGH_DIR_S HIGH
#endif

// –--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–-- 
// This version includes:
// control two stepper motors to move the sputes
// control two stepper motors to move levers
// reads water spout and lever touches using capacitive sensing.
// serial communication with bpod v2 state machine
// –--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–--–-- 

// Serial-write variables
unsigned long FirmwareVersion = 2;
char moduleName[] = "TouchShaker"; // Name of module for manual override UI and state machine

ArCOM Serial1COM(Serial1); // UART serial port

unsigned long clocker = millis();
unsigned long stimClocker = millis();
unsigned long trialClocker = millis();
int FSMheader = 0;
const int sRateLicks = 5; // This is the minimum duration of lick events that are send to bpod.
const int sRateLever = 10; // This is the number of ms for outputs to be during levertouch. Signal remains live until 'sRateLever' ms after the last contact.

/* ################################################# ############## PIN CONFIGURATION ################### #################################################### */
// TTL Outputs
#define PIN_STIMTRIG 21 // stimulus trigger that can be switched by serial command 'MAKE_STIMTRIGGER'
#define PIN_TRIALTRIG 4 // trial-start trigger that can be switched by serial command 'MAKE_TRIALTRIGGER'
#define PIN_CAMTIMER 3 // Trigger to synchronize camera acquisition. Sends TTL for 'camTrigDur' with an inter-pulse of 'camTrigRate'.

// Inputs for lick sensors
#define LEVERSENSOR_L 19 // touch line for lever touch
#define LEVERSENSOR_R 20 // touch line for lever touch
#define SPOUTSENSOR_L 15 // touch line for left spout
#define SPOUTSENSOR_R 16 // touch line for right spout

// Pins for stepper - spouts
#define PIN_SPOUTOUT_L 5
#define PIN_SPOUTOUT_R 6
#define PIN_SPOUTSTEP_L 13
#define PIN_SPOUTDIR_L 14
#define PIN_SPOUTSTEP_R 17
#define PIN_SPOUTDIR_R 18

// Pins for stepper - handles
#define PIN_LEVEROUT_L 7
#define PIN_LEVEROUT_R 8
#define PIN_LEVERSTEP_L 9
#define PIN_LEVERDIR_L 10
#define PIN_LEVERSTEP_R 11
#define PIN_LEVERDIR_R 12

/* ################################################# ########### UART/BPOD COMMUNICATION ################ #################################################### */
// Byte codes for serial communication
// inputs
#define MODULE_INFO 255
#define HWRESET 128
#define START_TRIAL 70
#define ADJUST_SPOUTES 71
#define ADJUST_LEVER 72
#define ADJUST_SPOUTSPEED 73
#define ADJUST_LEVERSPEED 74
#define ADJUST_TOUCHLEVEL 75
#define CHECK_LEVERS 76
#define MAKE_STIMTRIGGER 77
#define MAKE_TRIALTRIGGER 78
#define INCREASE_SPOUTTHRESH_L 80
#define DECREASE_SPOUTTHRESH_L 81
#define INCREASE_SPOUTTHRESH_R 82
#define DECREASE_SPOUTTHRESH_R 83
#define INCREASE_LEVERTHRESH_L 84
#define DECREASE_LEVERTHRESH_L 85
#define INCREASE_LEVERTHRESH_R 86
#define DECREASE_LEVERTHRESH_R 87
#define SET_TOUCHLEVELS 89
#define GET_TOUCHLEVELS 95
#define IS_MOVING 88

// outputs
#define LEFT_SPOUT_TOUCH 1
#define RIGHT_SPOUT_TOUCH 2
#define LEFT_SPOUT_RELEASE 3
#define RIGHT_SPOUT_RELEASE 4
#define LEFT_HANDLE_TOUCH 5
#define RIGHT_HANDLE_TOUCH 6
#define BOTH_HANDLES_TOUCH 7
#define LEFT_HANDLE_RELEASE 8
#define RIGHT_HANDLE_RELEASE 9
#define OK 14
#define FAIL 15

// other serial commands during the trial
#define SPOUTS_IN 101
#define SPOUTS_OUT 106
#define LEFT_SPOUT_OUT 102
#define RIGHT_SPOUT_OUT 103
#define LEVER_IN 104
#define LEVER_OUT 105

/* ################################################# ##################### VARIABLES #################### #################################################### */
// Servo vars
float lServoIn = 10;
float lServoOut = 0;
float lServoAdjust = 0;
float lServoCurrent = 0;
float rServoIn = 10;
float rServoOut = 0;
float rServoAdjust = 0;
float rServoCurrent = 0;
float leverIn = 10;
float leverOut = 0;
float leverAdjust = 0;
float leverCurrent = 0;
float spoutSpeed = 50000;
float leverSpeed = 50000;

unsigned long lSpoutClocker = micros();
unsigned long rSpoutClocker = micros();
unsigned long lClocker = micros();
unsigned long touchClocker_L = millis();
unsigned long touchClocker_R = millis();

int lSpoutInc = 1000;
int rSpoutInc = 1000;
int leverInc = 1000;
int touchChangeInc = 2;

// flags for current servo states. Required to control servo speed
bool stimTrigger = false;
bool trialTrigger = false;
bool spoutMoves = false;
bool lSpoutMovesIn = false;
bool lSpoutMovesOut = true;
bool lSpoutMovesAdjust = false;
bool rSpoutMovesIn = false;
bool rSpoutMovesOut = true;
bool rSpoutMovesAdjust = false;
bool leverMoves = false;
bool lMovesIn = false;
bool lMovesOut = true;
bool lMovesAdjust = false;

unsigned long spoutClocker_L = millis();
unsigned long spoutClocker_R = millis();

// Touch variables
int touchAdjustDur = 2000;
int touchThresh = 3;
int touchThreshOffset = 50;
bool touchAdjust = false;
int touchData[4];
float meanTouchVals[4];
float stdTouchVals[4];
float touchVal = 0;
long int sampleCnt[] = {0, 0};
unsigned long adjustClocker = millis();
int runningAvg[2] = {0, 0};
float avgWeight = 5000;

// Other variables
bool midRead = false;
bool spoutTouch_L = false;
bool spoutTouch_R = false;
bool leverTouch_L = false;
bool leverTouch_R = false;
bool leverTouch_BOTH = false;
bool findSpoutOut[2] = {true, true};
bool findLeverOut[2] = {true, true};
int stepPulse = 10;
int stimDur = 100;
int trialDur = 50;
float temp[10];
int camTrigRate = 90;
unsigned long usbClocker = millis();
int usbRate = 30;

// volatile long cameraFramesCounter = 0;

void setup() {
  Serial1.begin(1312500);
  Serial.begin(9600);

  // Servo pins
  pinMode(PIN_SPOUTSTEP_L, OUTPUT);
  pinMode(PIN_SPOUTSTEP_R, OUTPUT);
  pinMode(PIN_SPOUTDIR_L, OUTPUT);
  pinMode(PIN_SPOUTDIR_R, OUTPUT);
  pinMode(PIN_LEVERSTEP_L, OUTPUT);
  pinMode(PIN_LEVERSTEP_R, OUTPUT);
  pinMode(PIN_LEVERDIR_L, OUTPUT);
  pinMode(PIN_LEVERDIR_R, OUTPUT);

  // Digital outputs
  pinMode(PIN_STIMTRIG, OUTPUT);
  pinMode(PIN_TRIALTRIG, OUTPUT);

  // Stepper range inputs
  pinMode(PIN_SPOUTOUT_L, INPUT_PULLUP);
  pinMode(PIN_SPOUTOUT_R, INPUT_PULLUP);
  pinMode(PIN_LEVEROUT_L, INPUT_PULLUP);
  pinMode(PIN_LEVEROUT_R, INPUT_PULLUP);

  // Touch sensors
  pinMode(SPOUTSENSOR_L, INPUT);
  pinMode(SPOUTSENSOR_R, INPUT);
}
void loop() {
  // Handle serial commands from Bpod
  if (Serial1.available()) {
    handleSerialInput();
  }

  // Touch sensors update
  updateTouchSensors();

  // Move spouts if commanded
  updateSpouts();

  // Move levers if commanded
  updateLevers();

  // Handle trial and stim triggers
  if (stimTrigger) {
    digitalWrite(PIN_STIMTRIG, HIGH);
    delay(stimDur);
    digitalWrite(PIN_STIMTRIG, LOW);
    stimTrigger = false;
  }

  if (trialTrigger) {
    digitalWrite(PIN_TRIALTRIG, HIGH);
    delay(trialDur);
    digitalWrite(PIN_TRIALTRIG, LOW);
    trialTrigger = false;
  }

  // Camera trigger
  static unsigned long lastCamTrigger = 0;
  if (millis() - lastCamTrigger > camTrigRate) {
    digitalWrite(PIN_CAMTIMER, HIGH);
    delay(2); // pulse duration in ms
    digitalWrite(PIN_CAMTIMER, LOW);
    lastCamTrigger = millis();
  }
}

// ======================== SERIAL COMMAND HANDLER ========================
void handleSerialInput() {
  byte cmd = Serial1.read();

  switch (cmd) {
    case MODULE_INFO:
      Serial1.write(FirmwareVersion);
      Serial1.write(moduleName);
      break;
    case HWRESET:
      //NVIC_SystemReset();
      Serial1.write(OK);
      SCB_AIRCR = 0x05FA0004;  // works on Teensy 4.x
      break;
    case START_TRIAL:
      trialTrigger = true;
      break;
    case MAKE_STIMTRIGGER:
      stimTrigger = true;
      break;
    case SPOUTS_IN:
      lSpoutMovesIn = true;
      rSpoutMovesIn = true;
      break;
    case SPOUTS_OUT:
      lSpoutMovesOut = true;
      rSpoutMovesOut = true;
      break;
    case LEFT_SPOUT_OUT:
      lSpoutMovesOut = true;
      break;
    case RIGHT_SPOUT_OUT:
      rSpoutMovesOut = true;
      break;
    case LEVER_IN:
      lMovesIn = true;
      lMovesOut = false;
      break;
    case LEVER_OUT:
      lMovesOut = true;
      lMovesIn = false;
      break;
    default:
      Serial1.write(FAIL);
      break;
  }
}

// ======================== TOUCH SENSOR UPDATE ===========================
void updateTouchSensors() {
  int lTouch = analogRead(SPOUTSENSOR_L);
  int rTouch = analogRead(SPOUTSENSOR_R);
  int lLever = analogRead(LEVERSENSOR_L);
  int rLever = analogRead(LEVERSENSOR_R);

  // Simple thresholding
  spoutTouch_L = lTouch > touchThresh;
  spoutTouch_R = rTouch > touchThresh;
  leverTouch_L = lLever > touchThresh;
  leverTouch_R = rLever > touchThresh;
  leverTouch_BOTH = leverTouch_L && leverTouch_R;

  // Send events to Bpod if needed
  if (spoutTouch_L) Serial1.write(LEFT_SPOUT_TOUCH);
  if (spoutTouch_R) Serial1.write(RIGHT_SPOUT_TOUCH);
  if (leverTouch_L) Serial1.write(LEFT_HANDLE_TOUCH);
  if (leverTouch_R) Serial1.write(RIGHT_HANDLE_TOUCH);
  if (leverTouch_BOTH) Serial1.write(BOTH_HANDLES_TOUCH);
}

// ======================== SPOUT CONTROL ================================
void updateSpouts() {
  if (lSpoutMovesIn) moveSpout(PIN_SPOUTSTEP_L, PIN_SPOUTDIR_L, LOW_DIR_H, lSpoutInc);
  if (lSpoutMovesOut) moveSpout(PIN_SPOUTSTEP_L, PIN_SPOUTDIR_L, HIGH_DIR_H, lSpoutInc);
  if (rSpoutMovesIn) moveSpout(PIN_SPOUTSTEP_R, PIN_SPOUTDIR_R, LOW_DIR_H, rSpoutInc);
  if (rSpoutMovesOut) moveSpout(PIN_SPOUTSTEP_R, PIN_SPOUTDIR_R, HIGH_DIR_H, rSpoutInc);
}

void moveSpout(int stepPin, int dirPin, int direction, int steps) {
  digitalWrite(dirPin, direction);
  for (int i = 0; i < steps; i++) {
    digitalWrite(stepPin, HIGH);
    delayMicroseconds(spoutSpeed);
    digitalWrite(stepPin, LOW);
    delayMicroseconds(spoutSpeed);
  }
}

// ======================== LEVER CONTROL ================================
void updateLevers() {
  if (lMovesIn) moveLever(PIN_LEVERSTEP_L, PIN_LEVERDIR_L, LOW_DIR_H, leverInc);
  if (lMovesOut) moveLever(PIN_LEVERSTEP_L, PIN_LEVERDIR_L, HIGH_DIR_H, leverInc);
  if (lMovesAdjust) moveLever(PIN_LEVERSTEP_L, PIN_LEVERDIR_L, LOW_DIR_H, leverInc);
}

void moveLever(int stepPin, int dirPin, int direction, int steps) {
  digitalWrite(dirPin, direction);
  for (int i = 0; i < steps; i++) {
    digitalWrite(stepPin, HIGH);
    delayMicroseconds(leverSpeed);
    digitalWrite(stepPin, LOW);
    delayMicroseconds(leverSpeed);
  }
}
