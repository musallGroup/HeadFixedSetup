EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A2 23386 16535
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Device:CP1 C1
U 1 1 5EFBABCC
P 2000 1750
F 0 "C1" H 2115 1796 50  0000 L CNN
F 1 "100 uF" H 2115 1705 50  0000 L CNN
F 2 "Capacitor_THT:C_Rect_L7.2mm_W7.2mm_P5.00mm_FKS2_FKP2_MKS2_MKP2" H 2000 1750 50  0001 C CNN
F 3 "~" H 2000 1750 50  0001 C CNN
	1    2000 1750
	1    0    0    -1  
$EndComp
$Comp
L Connector:Screw_Terminal_01x04 HandleL-ToMotor1
U 1 1 5F00F6D8
P 6500 2650
F 0 "HandleL-ToMotor1" H 6580 2642 50  0000 L CNN
F 1 "Screw_Terminal_01x04" H 6580 2551 50  0000 L CNN
F 2 "teensy:TerminalBlock_TE_282825-4_1x04_P5.08mm_Horizontal" H 6500 2650 50  0001 C CNN
F 3 "~" H 6500 2650 50  0001 C CNN
	1    6500 2650
	1    0    0    -1  
$EndComp
$Comp
L Connector:Screw_Terminal_01x04 HandleR-ToMotor1
U 1 1 5F010C08
P 6550 4300
F 0 "HandleR-ToMotor1" H 6550 4550 50  0000 L CNN
F 1 "Screw_Terminal_01x04" H 6650 4450 50  0000 L CNN
F 2 "teensy:TerminalBlock_TE_282825-4_1x04_P5.08mm_Horizontal" H 6550 4300 50  0001 C CNN
F 3 "~" H 6550 4300 50  0001 C CNN
	1    6550 4300
	1    0    0    -1  
$EndComp
$Comp
L Connector:Screw_Terminal_01x04 SpoutR-ToMotor1
U 1 1 5F00E35C
P 4500 4550
F 0 "SpoutR-ToMotor1" H 4200 4200 50  0000 L CNN
F 1 "Screw_Terminal_01x04" H 4150 4100 50  0000 L CNN
F 2 "teensy:TerminalBlock_TE_282825-4_1x04_P5.08mm_Horizontal" H 4500 4550 50  0001 C CNN
F 3 "~" H 4500 4550 50  0001 C CNN
	1    4500 4550
	1    0    0    -1  
$EndComp
$Comp
L Connector:Screw_Terminal_01x04 SpoutL-ToMotor1
U 1 1 5F00C5DF
P 4500 2600
F 0 "SpoutL-ToMotor1" H 4250 2300 50  0000 L CNN
F 1 "Screw_Terminal_01x04" H 4200 2200 50  0000 L CNN
F 2 "teensy:TerminalBlock_TE_282825-4_1x04_P5.08mm_Horizontal" H 4500 2600 50  0001 C CNN
F 3 "~" H 4500 2600 50  0001 C CNN
	1    4500 2600
	1    0    0    -1  
$EndComp
$Comp
L Driver_Motor:Pololu_Breakout_DRV8825 MC-SpoutR1
U 1 1 5EFCADAC
P 3650 4500
F 0 "MC-SpoutR1" H 4000 5150 50  0000 C CNN
F 1 "Pololu_Breakout_DRV8825" V 3750 4500 50  0000 C CNN
F 2 "Module:Pololu_Breakout-16_15.2x20.3mm" H 3850 3700 50  0001 L CNN
F 3 "https://www.pololu.com/product/2982" H 3750 4200 50  0001 C CNN
	1    3650 4500
	1    0    0    -1  
$EndComp
$Comp
L Connector:Screw_Terminal_01x05 ToHandleR1
U 1 1 5F05C787
P 7400 6950
F 0 "ToHandleR1" H 7318 6525 50  0000 C CNN
F 1 "Screw_Terminal_01x05" H 7318 6616 50  0000 C CNN
F 2 "teensy:TerminalBlock_TE_282825-5_1x05_P5.08mm_Horizontal" H 7400 6950 50  0001 C CNN
F 3 "~" H 7400 6950 50  0001 C CNN
	1    7400 6950
	-1   0    0    1   
$EndComp
$Comp
L Connector:Screw_Terminal_01x05 ToHandleL1
U 1 1 5F05AFB3
P 10500 6950
F 0 "ToHandleL1" H 10418 6525 50  0000 C CNN
F 1 "Screw_Terminal_01x05" H 10418 6616 50  0000 C CNN
F 2 "teensy:TerminalBlock_TE_282825-5_1x05_P5.08mm_Horizontal" H 10500 6950 50  0001 C CNN
F 3 "~" H 10500 6950 50  0001 C CNN
	1    10500 6950
	-1   0    0    1   
$EndComp
$Comp
L Connector:Barrel_Jack 9V1
U 1 1 5F03BFA0
P 2400 13350
F 0 "9V1" H 2457 13675 50  0000 C CNN
F 1 "9V" H 2457 13584 50  0000 C CNN
F 2 "Connector_BarrelJack:BarrelJack_Horizontal" H 2450 13310 50  0001 C CNN
F 3 "~" H 2450 13310 50  0001 C CNN
	1    2400 13350
	1    0    0    -1  
$EndComp
$Comp
L Connector:Barrel_Jack 12V1
U 1 1 5F1009A2
P 2400 12550
F 0 "12V1" H 2457 12875 50  0000 C CNN
F 1 "12V" H 2457 12784 50  0000 C CNN
F 2 "Connector_BarrelJack:BarrelJack_Horizontal" H 2450 12510 50  0001 C CNN
F 3 "~" H 2450 12510 50  0001 C CNN
	1    2400 12550
	1    0    0    -1  
$EndComp
Text Notes 2800 1200 0    118  ~ 0
Stepper motor drivers\nHandles and Spout motors\n
Text Notes 1500 11100 0    118  ~ 0
Stimuli - analog output connection
$Comp
L Connector:RJ45 J2
U 1 1 5F1887E1
P 1950 9200
F 0 "J2" H 2007 9867 50  0000 C CNN
F 1 "RJ45" H 2007 9776 50  0000 C CNN
F 2 "teensy:RJ45_sparkfun" V 1950 9225 50  0001 C CNN
F 3 "~" V 1950 9225 50  0001 C CNN
	1    1950 9200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0101
U 1 1 5F1C1431
P 3600 9700
F 0 "#PWR0101" H 3600 9450 50  0001 C CNN
F 1 "GND" V 3605 9572 50  0000 R CNN
F 2 "" H 3600 9700 50  0001 C CNN
F 3 "" H 3600 9700 50  0001 C CNN
	1    3600 9700
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0102
U 1 1 5F1C1B29
P 3600 10000
F 0 "#PWR0102" H 3600 9750 50  0001 C CNN
F 1 "GND" V 3605 9872 50  0000 R CNN
F 2 "" H 3600 10000 50  0001 C CNN
F 3 "" H 3600 10000 50  0001 C CNN
	1    3600 10000
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0103
U 1 1 5F1C1DFA
P 3600 10100
F 0 "#PWR0103" H 3600 9850 50  0001 C CNN
F 1 "GND" V 3605 9972 50  0000 R CNN
F 2 "" H 3600 10100 50  0001 C CNN
F 3 "" H 3600 10100 50  0001 C CNN
	1    3600 10100
	0    1    1    0   
$EndComp
$Comp
L power:+5V #PWR0104
U 1 1 5F25EF9D
P 3250 2350
F 0 "#PWR0104" H 3250 2200 50  0001 C CNN
F 1 "+5V" V 3265 2478 50  0000 L CNN
F 2 "" H 3250 2350 50  0001 C CNN
F 3 "" H 3250 2350 50  0001 C CNN
	1    3250 2350
	0    -1   -1   0   
$EndComp
$Comp
L power:+5V #PWR0105
U 1 1 5F2624CA
P 3250 4300
F 0 "#PWR0105" H 3250 4150 50  0001 C CNN
F 1 "+5V" V 3265 4428 50  0000 L CNN
F 2 "" H 3250 4300 50  0001 C CNN
F 3 "" H 3250 4300 50  0001 C CNN
	1    3250 4300
	0    -1   -1   0   
$EndComp
$Comp
L power:+5V #PWR0106
U 1 1 5F2A2DB9
P 5350 2350
F 0 "#PWR0106" H 5350 2200 50  0001 C CNN
F 1 "+5V" V 5365 2478 50  0000 L CNN
F 2 "" H 5350 2350 50  0001 C CNN
F 3 "" H 5350 2350 50  0001 C CNN
	1    5350 2350
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0108
U 1 1 5F2EFB61
P 3650 5300
F 0 "#PWR0108" H 3650 5050 50  0001 C CNN
F 1 "GND" H 3655 5127 50  0000 C CNN
F 2 "" H 3650 5300 50  0001 C CNN
F 3 "" H 3650 5300 50  0001 C CNN
	1    3650 5300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0112
U 1 1 5F2F2CD1
P 5750 3350
F 0 "#PWR0112" H 5750 3100 50  0001 C CNN
F 1 "GND" H 5755 3177 50  0000 C CNN
F 2 "" H 5750 3350 50  0001 C CNN
F 3 "" H 5750 3350 50  0001 C CNN
	1    5750 3350
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0114
U 1 1 5F2FBC59
P 3650 3350
F 0 "#PWR0114" H 3650 3100 50  0001 C CNN
F 1 "GND" H 3655 3177 50  0000 C CNN
F 2 "" H 3650 3350 50  0001 C CNN
F 3 "" H 3650 3350 50  0001 C CNN
	1    3650 3350
	1    0    0    -1  
$EndComp
$Comp
L power:+9V #PWR0117
U 1 1 5F31A33A
P 2000 1600
F 0 "#PWR0117" H 2000 1450 50  0001 C CNN
F 1 "+9V" H 2015 1773 50  0000 C CNN
F 2 "" H 2000 1600 50  0001 C CNN
F 3 "" H 2000 1600 50  0001 C CNN
	1    2000 1600
	1    0    0    -1  
$EndComp
$Comp
L power:+9V #PWR0118
U 1 1 5F35B35D
P 5750 1950
F 0 "#PWR0118" H 5750 1800 50  0001 C CNN
F 1 "+9V" H 5765 2123 50  0000 C CNN
F 2 "" H 5750 1950 50  0001 C CNN
F 3 "" H 5750 1950 50  0001 C CNN
	1    5750 1950
	1    0    0    -1  
$EndComp
$Comp
L power:+9V #PWR0119
U 1 1 5F35CF5B
P 3650 1950
F 0 "#PWR0119" H 3650 1800 50  0001 C CNN
F 1 "+9V" H 3665 2123 50  0000 C CNN
F 2 "" H 3650 1950 50  0001 C CNN
F 3 "" H 3650 1950 50  0001 C CNN
	1    3650 1950
	1    0    0    -1  
$EndComp
$Comp
L power:+9V #PWR0120
U 1 1 5F35ECD6
P 3650 3900
F 0 "#PWR0120" H 3650 3750 50  0001 C CNN
F 1 "+9V" H 3665 4073 50  0000 C CNN
F 2 "" H 3650 3900 50  0001 C CNN
F 3 "" H 3650 3900 50  0001 C CNN
	1    3650 3900
	1    0    0    -1  
$EndComp
$Comp
L power:+9V #PWR0122
U 1 1 5F366504
P 3100 13250
F 0 "#PWR0122" H 3100 13100 50  0001 C CNN
F 1 "+9V" H 3115 13423 50  0000 C CNN
F 2 "" H 3100 13250 50  0001 C CNN
F 3 "" H 3100 13250 50  0001 C CNN
	1    3100 13250
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0128
U 1 1 5F3A37C2
P 2350 9500
F 0 "#PWR0128" H 2350 9250 50  0001 C CNN
F 1 "GND" H 2355 9327 50  0000 C CNN
F 2 "" H 2350 9500 50  0001 C CNN
F 3 "" H 2350 9500 50  0001 C CNN
	1    2350 9500
	1    0    0    -1  
$EndComp
$Comp
L spatialsparrow:MAX98306 U2
U 1 1 5F0C05CB
P 3850 9750
F 0 "U2" V 3475 9800 50  0000 C CNN
F 1 "MAX98306" V 3566 9800 50  0000 C CNN
F 2 "spatialsparrow:MAX98306" H 4100 9800 50  0001 C CNN
F 3 "" H 4100 9800 50  0001 C CNN
	1    3850 9750
	0    1    1    0   
$EndComp
Wire Wire Line
	2350 9400 3000 9400
Wire Wire Line
	3000 9400 3000 9900
Wire Wire Line
	3000 9900 3600 9900
Wire Wire Line
	2350 9300 3100 9300
Wire Wire Line
	3100 9300 3100 10200
Wire Wire Line
	3100 10200 3600 10200
Text Notes 1900 11950 0    118  ~ 0
Power connectors\n
Text Notes 14550 7150 0    157  ~ 0
INPUT PINS\n// Inputs for lick sensors\nLEVERSENSOR_L 15 // touch line for lever touch\nLEVERSENSOR_R 16 // touch line for lever touch\nSPOUTSENSOR_L 22 // touch line for left spout\nSPOUTSENSOR_R 23 // touch line for right spout\n// Pins for stepper - spouts\nPIN_SPOUTOUT_L 5\nPIN_SPOUTOUT_R 6\nPIN_SPOUTSTEP_L 13\nPIN_SPOUTDIR_L 14\nPIN_SPOUTSTEP_R 17\nPIN_SPOUTDIR_R 18\n// Pins for stepper - handles\nPIN_LEVEROUT_L 7\nPIN_LEVEROUT_R 8\nPIN_LEVERSTEP_L 9\nPIN_LEVERDIR_L 10\nPIN_LEVERSTEP_R 11\nPIN_LEVERDIR_R 12 \n\nOUTPUT PINS:\nPIN_LEFTLICK 19 // trigger that informs over left licks\nPIN_RIGHTLICK 20 // trigger that informs over right licks\nPIN_STIMTRIG 21 //  (no sync) 'MAKE_STIMTRIGGER' \nPIN_TRIALTRIG 4 // (no sync) 'MAKE_TRIALTRIGGER'\nPIN_CAMTIMER 3 // to trigger camera exposure 'camTrigDur', 'camTrigRate'.\n
$Comp
L power:+9V #PWR0121
U 1 1 5F361721
P 5750 3850
F 0 "#PWR0121" H 5750 3700 50  0001 C CNN
F 1 "+9V" H 5765 4023 50  0000 C CNN
F 2 "" H 5750 3850 50  0001 C CNN
F 3 "" H 5750 3850 50  0001 C CNN
	1    5750 3850
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0107
U 1 1 5F2A5CA9
P 5350 4250
F 0 "#PWR0107" H 5350 4100 50  0001 C CNN
F 1 "+5V" V 5365 4378 50  0000 L CNN
F 2 "" H 5350 4250 50  0001 C CNN
F 3 "" H 5350 4250 50  0001 C CNN
	1    5350 4250
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0110
U 1 1 5F2F109D
P 5750 5250
F 0 "#PWR0110" H 5750 5000 50  0001 C CNN
F 1 "GND" H 5755 5077 50  0000 C CNN
F 2 "" H 5750 5250 50  0001 C CNN
F 3 "" H 5750 5250 50  0001 C CNN
	1    5750 5250
	1    0    0    -1  
$EndComp
$Comp
L Driver_Motor:Pololu_Breakout_DRV8825 MC-LeverR1
U 1 1 5EFD3F38
P 5750 4450
F 0 "MC-LeverR1" H 6150 5050 50  0000 C CNN
F 1 "Pololu_Breakout_DRV8825" V 5850 4450 50  0000 C CNN
F 2 "Module:Pololu_Breakout-16_15.2x20.3mm" H 5950 3650 50  0001 L CNN
F 3 "https://www.pololu.com/product/2982" H 5850 4150 50  0001 C CNN
	1    5750 4450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0125
U 1 1 5F36E1BF
P 14250 3600
F 0 "#PWR0125" H 14250 3350 50  0001 C CNN
F 1 "GND" V 14255 3472 50  0000 R CNN
F 2 "" H 14250 3600 50  0001 C CNN
F 3 "" H 14250 3600 50  0001 C CNN
	1    14250 3600
	0    -1   -1   0   
$EndComp
$Comp
L power:+5V #PWR0127
U 1 1 5F36F155
P 14250 4400
F 0 "#PWR0127" H 14250 4250 50  0001 C CNN
F 1 "+5V" V 14265 4528 50  0000 L CNN
F 2 "" H 14250 4400 50  0001 C CNN
F 3 "" H 14250 4400 50  0001 C CNN
	1    14250 4400
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0126
U 1 1 5F36E8AC
P 14250 4500
F 0 "#PWR0126" H 14250 4250 50  0001 C CNN
F 1 "GND" V 14255 4372 50  0000 R CNN
F 2 "" H 14250 4500 50  0001 C CNN
F 3 "" H 14250 4500 50  0001 C CNN
	1    14250 4500
	0    -1   -1   0   
$EndComp
$Comp
L power:GND #PWR0124
U 1 1 5F36BC2C
P 12250 2100
F 0 "#PWR0124" H 12250 1850 50  0001 C CNN
F 1 "GND" H 12255 1927 50  0000 C CNN
F 2 "" H 12250 2100 50  0001 C CNN
F 3 "" H 12250 2100 50  0001 C CNN
	1    12250 2100
	1    0    0    -1  
$EndComp
$Comp
L teensy:Teensy3.2 U1
U 1 1 5EFE2FDF
P 13250 3450
F 0 "U1" H 13250 5087 60  0000 C CNN
F 1 "Teensy3.2" H 13250 4981 60  0000 C CNN
F 2 "teensy:Teensy30_31_32_LC" H 13250 2700 60  0001 C CNN
F 3 "" H 13250 2700 60  0000 C CNN
	1    13250 3450
	1    0    0    -1  
$EndComp
Wire Notes Line
	1600 750  10000 750 
$Comp
L Driver_Motor:Pololu_Breakout_DRV8825 MC-LeverL1
U 1 1 5EFD01B1
P 5750 2550
F 0 "MC-LeverL1" H 6050 3150 50  0000 C CNN
F 1 "Pololu_Breakout_DRV8825" V 5850 2550 50  0000 C CNN
F 2 "Module:Pololu_Breakout-16_15.2x20.3mm" H 5950 1750 50  0001 L CNN
F 3 "https://www.pololu.com/product/2982" H 5850 2250 50  0001 C CNN
	1    5750 2550
	1    0    0    -1  
$EndComp
$Comp
L Driver_Motor:Pololu_Breakout_DRV8825 MC-SpoutL1
U 1 1 5EFB9951
P 3650 2550
F 0 "MC-SpoutL1" H 3950 3200 50  0000 C CNN
F 1 "Pololu_Breakout_DRV8825" V 3750 2550 50  0000 C CNN
F 2 "Module:Pololu_Breakout-16_15.2x20.3mm" H 3850 1750 50  0001 L CNN
F 3 "https://www.pololu.com/product/2982" H 3750 2250 50  0001 C CNN
	1    3650 2550
	1    0    0    -1  
$EndComp
$Comp
L Connector:Screw_Terminal_01x02 J12V2
U 1 1 5F069700
P 5300 12600
F 0 "J12V2" H 5380 12592 50  0000 L CNN
F 1 "Screw_Terminal_01x02" H 5380 12501 50  0000 L CNN
F 2 "teensy:TerminalBlock_TE_282825-2_1x02_P5.08mm_Horizontal" H 5300 12600 50  0001 C CNN
F 3 "~" H 5300 12600 50  0001 C CNN
	1    5300 12600
	1    0    0    -1  
$EndComp
Text Notes 5000 11900 0    50   ~ 0
4x12 2x5 and 1x9 screw terminals
$Comp
L Connector:Screw_Terminal_01x06 SoundVisionR1
U 1 1 5F0675E7
P 5450 7250
F 0 "SoundVisionR1" H 5368 6785 50  0000 C CNN
F 1 "Screw_Terminal_01x06" H 5368 6876 50  0000 C CNN
F 2 "teensy:TerminalBlock_TE_282825-6_1x06_P5.08mm_Horizontal" H 5450 7250 50  0001 C CNN
F 3 "~" H 5450 7250 50  0001 C CNN
	1    5450 7250
	-1   0    0    1   
$EndComp
$Comp
L Connector:Screw_Terminal_01x06 SoundVisionL1
U 1 1 5F080410
P 3150 7250
F 0 "SoundVisionL1" H 3068 6785 50  0000 C CNN
F 1 "Screw_Terminal_01x06" H 3068 6876 50  0000 C CNN
F 2 "teensy:TerminalBlock_TE_282825-6_1x06_P5.08mm_Horizontal" H 3150 7250 50  0001 C CNN
F 3 "~" H 3150 7250 50  0001 C CNN
	1    3150 7250
	-1   0    0    1   
$EndComp
$Comp
L Connector:Screw_Terminal_01x05 sync_trigger_out1
U 1 1 5F081E55
P 8250 2950
F 0 "sync_trigger_out1" H 8168 2525 50  0000 C CNN
F 1 "Screw_Terminal_01x05" H 8168 2616 50  0000 C CNN
F 2 "teensy:TerminalBlock_TE_282825-5_1x05_P5.08mm_Horizontal" H 8250 2950 50  0001 C CNN
F 3 "~" H 8250 2950 50  0001 C CNN
	1    8250 2950
	-1   0    0    1   
$EndComp
Wire Wire Line
	10700 7150 11850 7150
Wire Wire Line
	11850 4150 12250 4150
Wire Wire Line
	12250 4150 12250 4200
Wire Wire Line
	11850 4150 11850 7150
Wire Wire Line
	11000 7050 10700 7050
Text Notes 1600 10400 0    50   ~ 0
2- left audio\n3- right audio\n4- left vision\n5- right vision\n6- left handle actuator\n7- right handle actuator\n8- distractor
Wire Wire Line
	11100 6950 10700 6950
Wire Wire Line
	11100 6950 11100 7700
$Comp
L power:GND #PWR0130
U 1 1 5F0900DF
P 11100 7700
F 0 "#PWR0130" H 11100 7450 50  0001 C CNN
F 1 "GND" H 11105 7527 50  0000 C CNN
F 2 "" H 11100 7700 50  0001 C CNN
F 3 "" H 11100 7700 50  0001 C CNN
	1    11100 7700
	1    0    0    -1  
$EndComp
Wire Wire Line
	7850 7050 7600 7050
Wire Wire Line
	7600 6950 8150 6950
Wire Wire Line
	8150 6950 8150 7650
$Comp
L power:GND #PWR0131
U 1 1 5F092875
P 8150 7650
F 0 "#PWR0131" H 8150 7400 50  0001 C CNN
F 1 "GND" H 8155 7477 50  0000 C CNN
F 2 "" H 8150 7650 50  0001 C CNN
F 3 "" H 8150 7650 50  0001 C CNN
	1    8150 7650
	1    0    0    -1  
$EndComp
Wire Wire Line
	10700 6850 11450 6850
Wire Wire Line
	11450 6850 11450 2900
Wire Wire Line
	11450 2900 12250 2900
Wire Wire Line
	7600 6850 9300 6850
Wire Wire Line
	9300 6850 9300 3000
Wire Wire Line
	9300 3000 12250 3000
Wire Wire Line
	7600 6750 8150 6750
Wire Wire Line
	8150 6750 8150 6950
Connection ~ 8150 6950
Wire Wire Line
	10700 6750 11100 6750
Wire Wire Line
	11100 6750 11100 6950
Connection ~ 11100 6950
Text Notes 10350 6250 0    50   ~ 0
1- Handle Touch\n2- Actuator +\n3- Actuator - (GND)\n4- Handle Out\n5- Handle Zero (GND)
Text Notes 7150 6350 0    50   ~ 0
1- Handle Touch\n2- Actuator +\n3- Actuator - (GND)\n4- Handle Out\n5- Handle Zero (GND)
Wire Wire Line
	7600 7150 9400 7150
Wire Wire Line
	9400 7150 9400 4300
Wire Wire Line
	9400 4300 12250 4300
Wire Wire Line
	5650 7450 6450 7450
Wire Wire Line
	6450 7450 6450 5100
Wire Wire Line
	6450 5100 14450 5100
Wire Wire Line
	14450 5100 14450 4700
Wire Wire Line
	14450 4700 14250 4700
Wire Wire Line
	14250 4800 14250 4950
Wire Wire Line
	14250 4950 6400 4950
Wire Wire Line
	6400 4950 6400 6350
Wire Wire Line
	6400 6350 3700 6350
Wire Wire Line
	3700 6350 3700 7450
Wire Wire Line
	3700 7450 3350 7450
Wire Wire Line
	4200 10300 5850 10300
Wire Wire Line
	5850 10300 5850 7350
Wire Wire Line
	5850 7350 5650 7350
Wire Wire Line
	4200 10400 5950 10400
Wire Wire Line
	5950 10400 5950 7250
Wire Wire Line
	5950 7250 5650 7250
Wire Wire Line
	5650 7150 6350 7150
Wire Wire Line
	6350 7150 6350 4850
Wire Wire Line
	6350 4850 9200 4850
Wire Wire Line
	9200 4850 9200 2800
Wire Wire Line
	9200 2800 12250 2800
Wire Wire Line
	3350 7150 3850 7150
Wire Wire Line
	3850 7150 3850 6250
Wire Wire Line
	3850 6250 6250 6250
Wire Wire Line
	6250 6250 6250 4750
Wire Wire Line
	6250 4750 9150 4750
Wire Wire Line
	9150 4750 9150 2700
Wire Wire Line
	9150 2700 12250 2700
Wire Wire Line
	5650 7050 6200 7050
Wire Wire Line
	6200 7050 6200 7850
Wire Wire Line
	3350 7050 4000 7050
Wire Wire Line
	4000 7050 4000 7650
Wire Wire Line
	4200 9700 4900 9700
Wire Wire Line
	4900 9700 4900 7900
Wire Wire Line
	4900 7900 3550 7900
Wire Wire Line
	3550 7900 3550 7350
Wire Wire Line
	3550 7350 3350 7350
Wire Wire Line
	4200 9600 4950 9600
Wire Wire Line
	4950 9600 4950 7850
Wire Wire Line
	4950 7850 3600 7850
Wire Wire Line
	3600 7850 3600 7250
Wire Wire Line
	3600 7250 3350 7250
$Comp
L power:GND #PWR0132
U 1 1 5F0AC313
P 6200 7850
F 0 "#PWR0132" H 6200 7600 50  0001 C CNN
F 1 "GND" H 6205 7677 50  0000 C CNN
F 2 "" H 6200 7850 50  0001 C CNN
F 3 "" H 6200 7850 50  0001 C CNN
	1    6200 7850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0133
U 1 1 5F0AD0B9
P 4000 7650
F 0 "#PWR0133" H 4000 7400 50  0001 C CNN
F 1 "GND" H 4005 7477 50  0000 C CNN
F 2 "" H 4000 7650 50  0001 C CNN
F 3 "" H 4000 7650 50  0001 C CNN
	1    4000 7650
	1    0    0    -1  
$EndComp
Text Notes 2750 6550 0    50   ~ 0
1- Spout Touch\n2- Audio +\n3- Audio - \n4- Spout Out\n5- Spout Zero (GND)\n6- Visual trigger
Text Notes 5000 8050 0    50   ~ 0
1- Spout Touch\n2- Audio +\n3- Audio - \n4- Spout Out\n5- Spout Zero (GND)\n6- Visual trigger
Wire Wire Line
	8650 4600 8650 3150
Wire Wire Line
	8650 3150 8450 3150
Wire Wire Line
	12250 4600 8650 4600
Wire Wire Line
	12250 4700 8700 4700
Wire Wire Line
	8700 4700 8700 3050
Wire Wire Line
	8700 3050 8450 3050
Wire Wire Line
	12250 4800 8750 4800
Wire Wire Line
	8750 4800 8750 2950
Wire Wire Line
	8750 2950 8450 2950
Wire Wire Line
	9050 2600 9050 2850
Wire Wire Line
	9050 2850 8450 2850
Wire Wire Line
	9050 2600 12250 2600
Wire Wire Line
	12250 2500 9000 2500
Wire Wire Line
	9000 2500 9000 2750
Wire Wire Line
	9000 2750 8450 2750
Wire Wire Line
	12250 4000 9950 4000
Wire Wire Line
	9950 4000 9950 900 
Wire Wire Line
	9950 900  5400 900 
Wire Wire Line
	5400 900  5400 1650
Wire Wire Line
	5400 1650 2550 1650
Wire Wire Line
	2550 1650 2550 2650
Wire Wire Line
	2550 2650 3250 2650
Wire Wire Line
	12250 4100 9900 4100
Wire Wire Line
	9900 4100 9900 1000
Wire Wire Line
	9900 1000 5350 1000
Wire Wire Line
	5350 1000 5350 1600
Wire Wire Line
	5350 1600 2500 1600
Wire Wire Line
	2500 1600 2500 2750
Wire Wire Line
	2500 2750 3250 2750
Wire Wire Line
	12250 4400 7350 4400
Wire Wire Line
	7350 4400 7350 5550
Wire Wire Line
	7350 5550 2950 5550
Wire Wire Line
	2950 5550 2950 4600
Wire Wire Line
	2950 4600 3250 4600
Wire Wire Line
	3250 4700 2900 4700
Wire Wire Line
	2900 4700 2900 5600
Wire Wire Line
	2900 5600 7400 5600
Wire Wire Line
	7400 5600 7400 4500
Wire Wire Line
	7400 4500 12250 4500
Wire Wire Line
	12250 3100 11550 3100
Wire Wire Line
	11550 3100 11550 2100
Wire Wire Line
	11550 2100 6950 2100
Wire Wire Line
	6950 2100 6950 1650
Wire Wire Line
	6950 1650 5450 1650
Wire Wire Line
	5450 1650 5450 1800
Wire Wire Line
	5450 1800 5050 1800
Wire Wire Line
	5050 1800 5050 2650
Wire Wire Line
	5050 2650 5350 2650
Wire Wire Line
	5350 2750 5100 2750
Wire Wire Line
	5100 2750 5100 1700
Wire Wire Line
	5100 1700 7000 1700
Wire Wire Line
	7000 1700 7000 2150
Wire Wire Line
	7000 2150 11500 2150
Wire Wire Line
	11500 3200 12250 3200
Wire Wire Line
	11500 2150 11500 3200
Wire Wire Line
	5350 4550 5150 4550
Wire Wire Line
	5150 4550 5150 5850
Wire Wire Line
	5150 5850 8900 5850
Wire Wire Line
	8900 5850 8900 5250
Wire Wire Line
	8900 5250 11200 5250
Wire Wire Line
	11200 5250 11200 3300
Wire Wire Line
	11200 3300 12250 3300
Wire Wire Line
	12250 3400 11100 3400
Wire Wire Line
	11100 3400 11100 5350
Wire Wire Line
	11100 5350 8850 5350
Wire Wire Line
	8850 5350 8850 5800
Wire Wire Line
	8850 5800 5200 5800
Wire Wire Line
	5200 5800 5200 4650
Wire Wire Line
	5200 4650 5350 4650
$Comp
L Connector:Screw_Terminal_01x02 J12V3
U 1 1 5F16A0F3
P 5300 12900
F 0 "J12V3" H 5380 12892 50  0000 L CNN
F 1 "Screw_Terminal_01x02" H 5380 12801 50  0000 L CNN
F 2 "teensy:TerminalBlock_TE_282825-2_1x02_P5.08mm_Horizontal" H 5300 12900 50  0001 C CNN
F 3 "~" H 5300 12900 50  0001 C CNN
	1    5300 12900
	1    0    0    -1  
$EndComp
$Comp
L Connector:Screw_Terminal_01x02 J12V4
U 1 1 5F1756AC
P 5300 13200
F 0 "J12V4" H 5380 13192 50  0000 L CNN
F 1 "Screw_Terminal_01x02" H 5380 13101 50  0000 L CNN
F 2 "teensy:TerminalBlock_TE_282825-2_1x02_P5.08mm_Horizontal" H 5300 13200 50  0001 C CNN
F 3 "~" H 5300 13200 50  0001 C CNN
	1    5300 13200
	1    0    0    -1  
$EndComp
$Comp
L Connector:Screw_Terminal_01x02 J5V1
U 1 1 5F180A13
P 5300 13700
F 0 "J5V1" H 5380 13692 50  0000 L CNN
F 1 "Screw_Terminal_01x02" H 5380 13601 50  0000 L CNN
F 2 "teensy:TerminalBlock_TE_282825-2_1x02_P5.08mm_Horizontal" H 5300 13700 50  0001 C CNN
F 3 "~" H 5300 13700 50  0001 C CNN
	1    5300 13700
	1    0    0    -1  
$EndComp
$Comp
L Connector:Screw_Terminal_01x02 J5V2
U 1 1 5F18BEE5
P 5300 14050
F 0 "J5V2" H 5380 14042 50  0000 L CNN
F 1 "Screw_Terminal_01x02" H 5380 13951 50  0000 L CNN
F 2 "teensy:TerminalBlock_TE_282825-2_1x02_P5.08mm_Horizontal" H 5300 14050 50  0001 C CNN
F 3 "~" H 5300 14050 50  0001 C CNN
	1    5300 14050
	1    0    0    -1  
$EndComp
$Comp
L Connector:Screw_Terminal_01x02 J12V1
U 1 1 5F19722B
P 5300 12300
F 0 "J12V1" H 5380 12292 50  0000 L CNN
F 1 "Screw_Terminal_01x02" H 5380 12201 50  0000 L CNN
F 2 "teensy:TerminalBlock_TE_282825-2_1x02_P5.08mm_Horizontal" H 5300 12300 50  0001 C CNN
F 3 "~" H 5300 12300 50  0001 C CNN
	1    5300 12300
	1    0    0    -1  
$EndComp
$Comp
L Connector:Screw_Terminal_01x02 J9V1
U 1 1 5F1A2427
P 5300 14550
F 0 "J9V1" H 5380 14542 50  0000 L CNN
F 1 "Screw_Terminal_01x02" H 5380 14451 50  0000 L CNN
F 2 "teensy:TerminalBlock_TE_282825-2_1x02_P5.08mm_Horizontal" H 5300 14550 50  0001 C CNN
F 3 "~" H 5300 14550 50  0001 C CNN
	1    5300 14550
	1    0    0    -1  
$EndComp
Wire Wire Line
	5100 12300 4950 12300
Wire Wire Line
	4950 12300 4950 12600
Wire Wire Line
	4950 12600 5100 12600
Wire Wire Line
	4950 12600 4950 12900
Wire Wire Line
	4950 12900 5100 12900
Connection ~ 4950 12600
Wire Wire Line
	4950 12900 4950 13200
Wire Wire Line
	4950 13200 5100 13200
Connection ~ 4950 12900
Wire Wire Line
	4750 12400 4750 12700
Wire Wire Line
	4750 12700 5100 12700
Wire Wire Line
	4750 12400 5100 12400
Wire Wire Line
	4750 12700 4750 13000
Wire Wire Line
	4750 13000 5100 13000
Connection ~ 4750 12700
Wire Wire Line
	4750 13000 4750 13300
Wire Wire Line
	4750 13300 5100 13300
Connection ~ 4750 13000
$Comp
L power:+12V #PWR0134
U 1 1 5F224720
P 4950 12300
F 0 "#PWR0134" H 4950 12150 50  0001 C CNN
F 1 "+12V" H 4965 12473 50  0000 C CNN
F 2 "" H 4950 12300 50  0001 C CNN
F 3 "" H 4950 12300 50  0001 C CNN
	1    4950 12300
	1    0    0    -1  
$EndComp
Connection ~ 4950 12300
$Comp
L power:+12V #PWR0135
U 1 1 5F240265
P 3100 12450
F 0 "#PWR0135" H 3100 12300 50  0001 C CNN
F 1 "+12V" H 3115 12623 50  0000 C CNN
F 2 "" H 3100 12450 50  0001 C CNN
F 3 "" H 3100 12450 50  0001 C CNN
	1    3100 12450
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0136
U 1 1 5F241049
P 2700 12650
F 0 "#PWR0136" H 2700 12400 50  0001 C CNN
F 1 "GND" H 2705 12477 50  0000 C CNN
F 2 "" H 2700 12650 50  0001 C CNN
F 3 "" H 2700 12650 50  0001 C CNN
	1    2700 12650
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0137
U 1 1 5F27D89B
P 3100 13950
F 0 "#PWR0137" H 3100 13800 50  0001 C CNN
F 1 "+5V" H 3115 14123 50  0000 C CNN
F 2 "" H 3100 13950 50  0001 C CNN
F 3 "" H 3100 13950 50  0001 C CNN
	1    3100 13950
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR0138
U 1 1 5F27E3E3
P 2700 14150
F 0 "#PWR0138" H 2700 13900 50  0001 C CNN
F 1 "GND" H 2705 13977 50  0000 C CNN
F 2 "" H 2700 14150 50  0001 C CNN
F 3 "" H 2700 14150 50  0001 C CNN
	1    2700 14150
	1    0    0    -1  
$EndComp
Wire Wire Line
	5100 13700 4900 13700
Wire Wire Line
	4900 13700 4900 14050
Wire Wire Line
	4900 14050 5100 14050
Wire Wire Line
	5100 13800 4800 13800
Wire Wire Line
	4800 13800 4800 14150
Wire Wire Line
	4800 14150 5100 14150
$Comp
L power:GND #PWR0139
U 1 1 5F2B517E
P 4750 13300
F 0 "#PWR0139" H 4750 13050 50  0001 C CNN
F 1 "GND" H 4755 13127 50  0000 C CNN
F 2 "" H 4750 13300 50  0001 C CNN
F 3 "" H 4750 13300 50  0001 C CNN
	1    4750 13300
	1    0    0    -1  
$EndComp
Connection ~ 4750 13300
$Comp
L power:GND #PWR0140
U 1 1 5F2B5DA7
P 4800 14150
F 0 "#PWR0140" H 4800 13900 50  0001 C CNN
F 1 "GND" H 4805 13977 50  0000 C CNN
F 2 "" H 4800 14150 50  0001 C CNN
F 3 "" H 4800 14150 50  0001 C CNN
	1    4800 14150
	1    0    0    -1  
$EndComp
Connection ~ 4800 14150
$Comp
L power:+5V #PWR0141
U 1 1 5F2B6991
P 4900 13700
F 0 "#PWR0141" H 4900 13550 50  0001 C CNN
F 1 "+5V" H 4915 13873 50  0000 C CNN
F 2 "" H 4900 13700 50  0001 C CNN
F 3 "" H 4900 13700 50  0001 C CNN
	1    4900 13700
	1    0    0    -1  
$EndComp
Connection ~ 4900 13700
$Comp
L power:+9V #PWR0143
U 1 1 5F2C6327
P 5100 14550
F 0 "#PWR0143" H 5100 14400 50  0001 C CNN
F 1 "+9V" H 5115 14723 50  0000 C CNN
F 2 "" H 5100 14550 50  0001 C CNN
F 3 "" H 5100 14550 50  0001 C CNN
	1    5100 14550
	1    0    0    -1  
$EndComp
Wire Wire Line
	4050 2450 4300 2450
Wire Wire Line
	4300 2450 4300 2500
Wire Wire Line
	4050 2550 4300 2550
Wire Wire Line
	4300 2550 4300 2600
Wire Wire Line
	4050 2750 4050 2700
Wire Wire Line
	4050 2700 4300 2700
Wire Wire Line
	4300 2800 4050 2800
Wire Wire Line
	4050 2800 4050 2850
Wire Wire Line
	4050 4400 4300 4400
Wire Wire Line
	4300 4400 4300 4450
Wire Wire Line
	4050 4500 4300 4500
Wire Wire Line
	4300 4500 4300 4550
Wire Wire Line
	4300 4650 4050 4650
Wire Wire Line
	4050 4650 4050 4700
Wire Wire Line
	4300 4750 4300 4800
Wire Wire Line
	4300 4800 4050 4800
Wire Wire Line
	6150 4750 6150 4700
Wire Wire Line
	6150 4700 6350 4700
Wire Wire Line
	6350 4700 6350 4500
Wire Wire Line
	6150 4650 6300 4650
Wire Wire Line
	6300 4650 6300 4400
Wire Wire Line
	6300 4400 6350 4400
Wire Wire Line
	6150 4450 6250 4450
Wire Wire Line
	6250 4450 6250 4350
Wire Wire Line
	6250 4350 6350 4350
Wire Wire Line
	6350 4350 6350 4300
Wire Wire Line
	6150 4350 6150 4300
Wire Wire Line
	6150 4300 6300 4300
Wire Wire Line
	6300 4300 6300 4200
Wire Wire Line
	6300 4200 6350 4200
Wire Wire Line
	6150 2450 6300 2450
Wire Wire Line
	6300 2450 6300 2550
Wire Wire Line
	6150 2550 6250 2550
Wire Wire Line
	6250 2550 6250 2650
Wire Wire Line
	6250 2650 6300 2650
Wire Wire Line
	6150 2750 6300 2750
Wire Wire Line
	6300 2850 6150 2850
$Comp
L power:GND #PWR01
U 1 1 5F2F8795
P 12250 3700
F 0 "#PWR01" H 12250 3450 50  0001 C CNN
F 1 "GND" V 12255 3572 50  0000 R CNN
F 2 "" H 12250 3700 50  0001 C CNN
F 3 "" H 12250 3700 50  0001 C CNN
	1    12250 3700
	0    1    1    0   
$EndComp
NoConn ~ 14250 4600
NoConn ~ 14250 4300
NoConn ~ 14250 4200
NoConn ~ 14250 4100
NoConn ~ 14250 4000
NoConn ~ 12250 3500
NoConn ~ 12250 3600
NoConn ~ 12250 3800
NoConn ~ 12250 3900
NoConn ~ 14250 3700
NoConn ~ 14250 2100
NoConn ~ 14250 2200
NoConn ~ 14250 2300
NoConn ~ 14250 2400
NoConn ~ 14250 2500
NoConn ~ 14250 2600
NoConn ~ 14250 2700
NoConn ~ 14250 2800
NoConn ~ 14250 2900
NoConn ~ 14250 3000
NoConn ~ 14250 3100
NoConn ~ 14250 3200
NoConn ~ 14250 3300
NoConn ~ 14250 3400
NoConn ~ 14250 3500
NoConn ~ 12250 2400
NoConn ~ 12250 2200
NoConn ~ 12250 2300
$Comp
L Device:CP1 C4
U 1 1 5F4A3CD5
P 1500 1750
F 0 "C4" H 1615 1796 50  0000 L CNN
F 1 "100 uF" H 1615 1705 50  0000 L CNN
F 2 "Capacitor_THT:C_Rect_L7.2mm_W7.2mm_P5.00mm_FKS2_FKP2_MKS2_MKP2" H 1500 1750 50  0001 C CNN
F 3 "~" H 1500 1750 50  0001 C CNN
	1    1500 1750
	1    0    0    -1  
$EndComp
$Comp
L power:+9V #PWR06
U 1 1 5F4A3CE1
P 1500 1600
F 0 "#PWR06" H 1500 1450 50  0001 C CNN
F 1 "+9V" H 1515 1773 50  0000 C CNN
F 2 "" H 1500 1600 50  0001 C CNN
F 3 "" H 1500 1600 50  0001 C CNN
	1    1500 1600
	1    0    0    -1  
$EndComp
$Comp
L Device:CP1 C3
U 1 1 5F4B0577
P 1050 1750
F 0 "C3" H 1165 1796 50  0000 L CNN
F 1 "100 uF" H 1165 1705 50  0000 L CNN
F 2 "Capacitor_THT:C_Rect_L7.2mm_W7.2mm_P5.00mm_FKS2_FKP2_MKS2_MKP2" H 1050 1750 50  0001 C CNN
F 3 "~" H 1050 1750 50  0001 C CNN
	1    1050 1750
	1    0    0    -1  
$EndComp
$Comp
L power:+9V #PWR04
U 1 1 5F4B0583
P 1050 1600
F 0 "#PWR04" H 1050 1450 50  0001 C CNN
F 1 "+9V" H 1065 1773 50  0000 C CNN
F 2 "" H 1050 1600 50  0001 C CNN
F 3 "" H 1050 1600 50  0001 C CNN
	1    1050 1600
	1    0    0    -1  
$EndComp
$Comp
L Device:CP1 C2
U 1 1 5F4BCEFE
P 650 1750
F 0 "C2" H 765 1796 50  0000 L CNN
F 1 "100 uF" H 765 1705 50  0000 L CNN
F 2 "Capacitor_THT:C_Rect_L7.2mm_W7.2mm_P5.00mm_FKS2_FKP2_MKS2_MKP2" H 650 1750 50  0001 C CNN
F 3 "~" H 650 1750 50  0001 C CNN
	1    650  1750
	1    0    0    -1  
$EndComp
$Comp
L power:+9V #PWR02
U 1 1 5F4BCF0A
P 650 1600
F 0 "#PWR02" H 650 1450 50  0001 C CNN
F 1 "+9V" H 665 1773 50  0000 C CNN
F 2 "" H 650 1600 50  0001 C CNN
F 3 "" H 650 1600 50  0001 C CNN
	1    650  1600
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR08
U 1 1 5F4CD230
P 3600 9600
F 0 "#PWR08" H 3600 9450 50  0001 C CNN
F 1 "+5V" V 3615 9728 50  0000 L CNN
F 2 "" H 3600 9600 50  0001 C CNN
F 3 "" H 3600 9600 50  0001 C CNN
	1    3600 9600
	0    -1   -1   0   
$EndComp
NoConn ~ 3600 10300
NoConn ~ 3600 10400
NoConn ~ 3600 9800
Wire Wire Line
	2350 9200 3500 9200
Wire Wire Line
	3500 9200 3500 6950
Wire Wire Line
	3500 6950 3350 6950
Wire Wire Line
	2350 9100 6000 9100
Wire Wire Line
	6000 9100 6000 6950
Wire Wire Line
	6000 6950 5650 6950
Wire Wire Line
	2350 9000 11000 9000
Wire Wire Line
	11000 7050 11000 9000
Wire Wire Line
	7850 8900 2350 8900
Wire Wire Line
	7850 7050 7850 8900
$Comp
L Connector:Screw_Terminal_01x02 distractor1
U 1 1 5F566D88
P 3900 8600
F 0 "distractor1" H 3980 8592 50  0000 L CNN
F 1 "Screw_Terminal_01x02" H 3980 8501 50  0000 L CNN
F 2 "teensy:TerminalBlock_TE_282825-2_1x02_P5.08mm_Horizontal" H 3900 8600 50  0001 C CNN
F 3 "~" H 3900 8600 50  0001 C CNN
	1    3900 8600
	1    0    0    -1  
$EndComp
Wire Wire Line
	3700 8700 2350 8700
Wire Wire Line
	2350 8700 2350 8800
$Comp
L power:GND #PWR09
U 1 1 5F588E79
P 3700 8600
F 0 "#PWR09" H 3700 8350 50  0001 C CNN
F 1 "GND" H 3705 8427 50  0000 C CNN
F 2 "" H 3700 8600 50  0001 C CNN
F 3 "" H 3700 8600 50  0001 C CNN
	1    3700 8600
	-1   0    0    1   
$EndComp
NoConn ~ 5350 4450
NoConn ~ 5350 4850
NoConn ~ 5350 4950
NoConn ~ 5350 5050
NoConn ~ 5350 4150
NoConn ~ 5350 4050
NoConn ~ 3250 4100
NoConn ~ 3250 4200
NoConn ~ 3250 4500
NoConn ~ 3250 4900
NoConn ~ 3250 5000
NoConn ~ 3250 5100
NoConn ~ 3250 3150
NoConn ~ 3250 3050
NoConn ~ 3250 2950
NoConn ~ 3250 2150
NoConn ~ 3250 2250
NoConn ~ 3250 2550
NoConn ~ 5350 2150
NoConn ~ 5350 2250
NoConn ~ 5350 2550
NoConn ~ 5350 2950
NoConn ~ 5350 3050
NoConn ~ 5350 3150
$Comp
L power:GND1 #PWR0109
U 1 1 5F6F4A10
P 5850 5250
F 0 "#PWR0109" H 5850 5000 50  0001 C CNN
F 1 "GND1" H 5855 5077 50  0000 C CNN
F 2 "" H 5850 5250 50  0001 C CNN
F 3 "" H 5850 5250 50  0001 C CNN
	1    5850 5250
	1    0    0    -1  
$EndComp
$Comp
L power:GND1 #PWR0111
U 1 1 5F6F6E4E
P 3750 5300
F 0 "#PWR0111" H 3750 5050 50  0001 C CNN
F 1 "GND1" H 3755 5127 50  0000 C CNN
F 2 "" H 3750 5300 50  0001 C CNN
F 3 "" H 3750 5300 50  0001 C CNN
	1    3750 5300
	1    0    0    -1  
$EndComp
$Comp
L power:GND1 #PWR0113
U 1 1 5F6F95CD
P 5850 3350
F 0 "#PWR0113" H 5850 3100 50  0001 C CNN
F 1 "GND1" H 5855 3177 50  0000 C CNN
F 2 "" H 5850 3350 50  0001 C CNN
F 3 "" H 5850 3350 50  0001 C CNN
	1    5850 3350
	1    0    0    -1  
$EndComp
$Comp
L power:GND1 #PWR0115
U 1 1 5F6F9C88
P 3750 3350
F 0 "#PWR0115" H 3750 3100 50  0001 C CNN
F 1 "GND1" H 3755 3177 50  0000 C CNN
F 2 "" H 3750 3350 50  0001 C CNN
F 3 "" H 3750 3350 50  0001 C CNN
	1    3750 3350
	1    0    0    -1  
$EndComp
$Comp
L power:GND1 #PWR0116
U 1 1 5F6FB7BD
P 650 1900
F 0 "#PWR0116" H 650 1650 50  0001 C CNN
F 1 "GND1" H 655 1727 50  0000 C CNN
F 2 "" H 650 1900 50  0001 C CNN
F 3 "" H 650 1900 50  0001 C CNN
	1    650  1900
	1    0    0    -1  
$EndComp
$Comp
L power:GND1 #PWR0123
U 1 1 5F6FBC55
P 1050 1900
F 0 "#PWR0123" H 1050 1650 50  0001 C CNN
F 1 "GND1" H 1055 1727 50  0000 C CNN
F 2 "" H 1050 1900 50  0001 C CNN
F 3 "" H 1050 1900 50  0001 C CNN
	1    1050 1900
	1    0    0    -1  
$EndComp
$Comp
L power:GND1 #PWR0129
U 1 1 5F6FC252
P 1500 1900
F 0 "#PWR0129" H 1500 1650 50  0001 C CNN
F 1 "GND1" H 1505 1727 50  0000 C CNN
F 2 "" H 1500 1900 50  0001 C CNN
F 3 "" H 1500 1900 50  0001 C CNN
	1    1500 1900
	1    0    0    -1  
$EndComp
$Comp
L power:GND1 #PWR0142
U 1 1 5F6FC701
P 2000 1900
F 0 "#PWR0142" H 2000 1650 50  0001 C CNN
F 1 "GND1" H 2005 1727 50  0000 C CNN
F 2 "" H 2000 1900 50  0001 C CNN
F 3 "" H 2000 1900 50  0001 C CNN
	1    2000 1900
	1    0    0    -1  
$EndComp
$Comp
L power:GND1 #PWR0144
U 1 1 5F6FF83C
P 2700 13450
F 0 "#PWR0144" H 2700 13200 50  0001 C CNN
F 1 "GND1" H 2705 13277 50  0000 C CNN
F 2 "" H 2700 13450 50  0001 C CNN
F 3 "" H 2700 13450 50  0001 C CNN
	1    2700 13450
	1    0    0    -1  
$EndComp
$Comp
L power:GND1 #PWR0145
U 1 1 5F700126
P 5100 14650
F 0 "#PWR0145" H 5100 14400 50  0001 C CNN
F 1 "GND1" H 5105 14477 50  0000 C CNN
F 2 "" H 5100 14650 50  0001 C CNN
F 3 "" H 5100 14650 50  0001 C CNN
	1    5100 14650
	1    0    0    -1  
$EndComp
$Comp
L Jumper:Jumper_2_Open JP1
U 1 1 5F0D8BE7
P 3550 13750
F 0 "JP1" H 3550 13985 50  0000 C CNN
F 1 "gnd jumper" H 3550 13894 50  0000 C CNN
F 2 "TestPoint:TestPoint_2Pads_Pitch5.08mm_Drill1.3mm" H 3550 13750 50  0001 C CNN
F 3 "~" H 3550 13750 50  0001 C CNN
	1    3550 13750
	0    1    1    0   
$EndComp
Wire Wire Line
	3550 13450 3550 13550
Wire Wire Line
	2700 13450 3550 13450
Connection ~ 2700 13450
Wire Wire Line
	2700 14150 3550 14150
Wire Wire Line
	3550 14150 3550 13950
Connection ~ 2700 14150
$Comp
L Switch:SW_SPST SW12
U 1 1 5F1753A3
P 2900 12450
F 0 "SW12" H 2900 12685 50  0000 C CNN
F 1 "SW12V" H 2900 12594 50  0000 C CNN
F 2 "teensy:SW_L102021ML04Q" H 2900 12450 50  0001 C CNN
F 3 "~" H 2900 12450 50  0001 C CNN
	1    2900 12450
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_SPST SW9
U 1 1 5F1934EC
P 2900 13250
F 0 "SW9" H 2900 13485 50  0000 C CNN
F 1 "SW9V" H 2900 13394 50  0000 C CNN
F 2 "teensy:SW_L102021ML04Q" H 2900 13250 50  0001 C CNN
F 3 "~" H 2900 13250 50  0001 C CNN
	1    2900 13250
	1    0    0    -1  
$EndComp
$Comp
L Connector:Barrel_Jack 5V1
U 1 1 5F03C8F5
P 2400 14050
F 0 "5V1" H 2457 14375 50  0000 C CNN
F 1 "5V" H 2457 14284 50  0000 C CNN
F 2 "Connector_BarrelJack:BarrelJack_Horizontal" H 2450 14010 50  0001 C CNN
F 3 "~" H 2450 14010 50  0001 C CNN
	1    2400 14050
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_SPST SW5
U 1 1 5F1BBE09
P 2900 13950
F 0 "SW5" H 2900 14185 50  0000 C CNN
F 1 "SW5V" H 2900 14094 50  0000 C CNN
F 2 "teensy:SW_L102021ML04Q" H 2900 13950 50  0001 C CNN
F 3 "~" H 2900 13950 50  0001 C CNN
	1    2900 13950
	1    0    0    -1  
$EndComp
$EndSCHEMATC