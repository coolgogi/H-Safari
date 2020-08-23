import 'package:flutter/material.dart';

class Sizes{
  one(BuildContext context){
    return MediaQuery.of(context).size.width*0.002430555555556;
  }
  width(BuildContext context){
   return MediaQuery.of(context).size.width;
  }
  height(BuildContext context){
    return MediaQuery.of(context).size.height;
    //return MediaQuery.of(context).size.height*0.001463210702342;
  }
}