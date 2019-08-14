// First import all required libraries
import android.content.Intent;
import android.os.Bundle;

import ketai.net.bluetooth.*;
import ketai.ui.*;
import ketai.net.*;

import controlP5.*;

import oscP5.*;

String d;
ControlP5 cp5; //ControlP5 object creation
PFont myFont;
KetaiBluetooth bt; //KetaiBluetooth object creation
KetaiList klist; //KetaiList object creation
String who;
boolean flag;
int f=0;
String states[]={"Vacant1","Vacant2","Vacant3"};
String info = "111";
String prev="";
byte recddata[]=new byte[3];
String stringInfo="";
ArrayList<String> discovered=new ArrayList();
boolean isConfiguring=true;

void onCreate(Bundle savedInstanceState){
  super.onCreate(savedInstanceState);
  bt=new KetaiBluetooth(this);
}
void onActivityResult(int requestCode, int resultCode, Intent data){
  bt.onActivityResult(requestCode, resultCode, data);
}
void setup(){
  ArrayList<String> names;
  size(2000,2000);
  background(100);
  cp5= new ControlP5(this);
  who="HC-05"; //Name of Bluetooth Module to connect to 
  bt.start(); 
  names = bt.getPairedDeviceNames();
  myFont=createFont("Gerogia",36);
  flag=bt.connectToDeviceByName(names.get(0).toString()); //Connect to the Bluetooth module
  delay(1000);
}
void onBluetoothDataEvent(String who, byte[]data) //Subroutine executes everytime data becomes available to be received
{
    if (data != null){
        String str = new String(data);
        stringInfo = str.substring(0, 5);
        prev=stringInfo;
        int l=stringInfo.length();
    }else{
    stringInfo=prev;
  }
}
void draw() //Subroutine to create buttons
{
  //onKetaiListSelection();
  background(200);
  int position=0;
  int length=stringInfo.length();
  if(length==5){
    f++;
  if(length==5 && stringInfo.charAt(0)=='1')
    {
      states[0]="Vacant1";
      cp5.addButton(states[0]).setPosition(0,0).setSize(250,250).setFont(myFont);
    }
    else if(length==5 && stringInfo.charAt(0)=='0')
    {
      states[0]="Occupied1";
      cp5.addButton(states[0]).setPosition(0,0).setSize(250,250).setFont(myFont);
    }
    else
    {
      cp5.addButton(states[0]).setPosition(0,0).setSize(250,250).setFont(myFont);
    }
    if(length==5 && stringInfo.charAt(1)=='1')
    {
      states[1]="Vacant2";
      cp5.addButton(states[1]).setPosition(300,0).setSize(250,250).setFont(myFont);
    }
    else if(length==5 && stringInfo.charAt(1)=='0')
    {
      states[1]="Occupied2";
      cp5.addButton(states[1]).setPosition(300,0).setSize(250,250).setFont(myFont);
    }
    else
    {
      cp5.addButton(states[1]).setPosition(300,0).setSize(250,250).setFont(myFont);
    }
     if(length==5 && stringInfo.charAt(2)=='1')
    {
      states[2]="Vacant3";
      cp5.addButton(states[2]).setPosition(650,0).setSize(250,250).setFont(myFont);
    }
    else if(length==5 && stringInfo.charAt(2)=='0')
    {
      states[2]="Occupied3";
      cp5.addButton(states[2]).setPosition(650,0).setSize(250,250).setFont(myFont);
    }
    else
    {
      cp5.addButton(states[2]).setPosition(650,0).setSize(250,250).setFont(myFont);
    }
  }
  if(f>0)
    delay(100);
    else
    delay(100);
}
