import 'package:ekonomi_new/screens/add_new_transaction_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  const NewTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => AddNewTransactionScreen()),
        ),
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Add new Transaction",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          CircleAvatar(
            radius: 22,
            backgroundColor: Color.fromRGBO(232, 245, 246, 1),
            child: Icon(Icons.add, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
