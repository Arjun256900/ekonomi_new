import 'package:flutter/material.dart';

class AddBtnAppbar extends StatelessWidget {
  final String title;
  final VoidCallback ontap;
   AddBtnAppbar({super.key,required this.ontap,required this.title
  });

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(

          height: 54, width: 169,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            border: Border.all(color: Theme.of(context).primaryColor)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 10,),
              Text(title,style: TextStyle(fontWeight: FontWeight.w500),),
              CircleAvatar(radius: 17.0,child: Icon(Icons.add,color: Colors.black,size: 20,),backgroundColor: Color.fromRGBO(237,237,237,1),)
            ],
          ),
        ),
      ),
    );
  }
}