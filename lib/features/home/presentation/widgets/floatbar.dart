import 'package:flutter/material.dart';
import 'dart:ui';

class Floatbar extends StatelessWidget {

  const Floatbar({ super.key });

   @override
   Widget build(BuildContext context) {
       return Scaffold(
         
         bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
          child: Container(
            height: 75,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              border: Border(
                top: BorderSide(
                  color: Colors.white.withOpacity(0.3),
                  width: 0.8,
                ),
              ),
            ),
            child:const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:  [
          
              ],
            ),
          ),
        ),
      ),
    
       );
  }
}