import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final String email;
  const ProfileCard({super.key, required this.email, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color:Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text("Premium User", style: TextStyle(fontSize: 11)),
          ),
          Row(
            children: [
              // Profile picture
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    child: Image.asset(
                      "assets/profile/person.png",
                    ), // can be later given original image
                  ),
                ],
              ),
              const SizedBox(width: 20),
              // Name and email
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  Text(
                    email,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
