import 'package:flutter/material.dart';



Future<void> showAlertDialog(context,{required String content}){
  return showDialog(context: context, builder:(context){
    return AlertDialog(
      title:Text("Alert"),
      content:Text(content),
      actions:[
        Center(
          child: TextButton(
            child:Text("OK"),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        )
      ]
    );
  });
}


