import 'package:flutter/material.dart';

class ColorUtil{
  static Color getColor(String color){
// determine color according to pokemon type enums maybe
    switch(color){
      case "Normal":{
        return Color(0xffBFB97F);
      }
      break;
      case "Fighting":{
        return Color(0xffD32F2E);
      }
      break;
      case "Flying":{
        return Color(0xff9E87E1 );
      }
      break;
      case "Poison":{
        return Color(0xffAA47BC );
      }
      break;
      case "Ground":{
        return Color(0xffDFB352 );
      }
      break;
      case "Rock":{
        return Color(0xffBDA537 );
      }
      break;
      case "Bug":{
        return Color(0xff98B92E );
      }
      break;
      case "Ghost":{
        return Color(0xff7556A4 );
      }
      break;
      case "Steel":{
        return Color(0xffB4B4CC );
      }
      break;
      case "Fire":{
        return Color(0xffE86513 );
      }
      break;
      case "Water":{
        return Color(0xff2196F3 );
      }
      break;
      case "Grass":{
        return Color(0xff4CB050 );
      }
      break;
      case "Electric":{
        return Color(0xffFECD07 );
      }
      break;
      case "Psychic":{
        return Color(0xffEC407A );
      }
      break;
      case "Ice":{
        return Color(0xff80DEEA );
      }
      break;
      case "Dragon":{
        return Color(0xff673BB7 );
      }
      break;
      case "Dark":{
        return Color(0xff5D4038 );
      }
      break;
      case "Fairy":{
        return Color(0xffF483BB );
      }
      break;

    }
  }
}