LIST P=PIC16F84A
#INCLUDE <P16F84A.INC>
__CONFIG _XT_OSC&_PWRTE_ON&_CP_OFF&_WDT_OFF
ORG 0X0000
GOTO START 
ORG 0X004
RETFIE
START BSF STATUS , RP0 ; BANK 1
MOVLW 0XFF
MOVWF TRISB ; ALL PORT B IS INPUT
CLRF TRISA  ; ALL PORT A IS ONPUT
BCF STATUS , RP0 ; BANK 0

LOOP BTFSC PORTB, 1
GOTO STATE_1X ; NUM2 = 1
GOTO STATE_0X ; NUM2 = 0

STATE_1X BTFSC PORTB, 0
GOTO OFF1    ; NUM2 = 1, NUM1 = 1 -> C = 1, S = 0
BSF PORTA, 0 ; NUM2 = 1, NUM1 = 0 -> C = 0, S = 1
BCF PORTA, 1
GOTO LOOP

STATE_0X BTFSS PORTB , 0
GOTO OFF2    ; NUM2 = 0, NUM0 = 0 -> C = 0, S = 0
BSF PORTA, 0 ; NUM2 = 0, NUM0 = 1 -> C = 0, S = 1
BCF PORTA, 1
GOTO LOOP

OFF2 BCF PORTA ,0
BCF PORTA,1
GOTO LOOP

OFF1 BCF PORTA ,0
BSF PORTA,1
GOTO LOOP
END
