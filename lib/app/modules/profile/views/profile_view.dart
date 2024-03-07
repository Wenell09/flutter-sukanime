import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 180,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://cdn.pixabay.com/photo/2016/05/05/02/37/sunset-1373171_1280.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              const Center(
                child: Text(
                  "User9999",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  "Username",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey[700],
                  ),
                ),
                trailing: const Text(
                  "user9999",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey[700],
                  ),
                ),
                trailing: const Text(
                  "user999@gmail.com",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              const Divider(),
              const ListTile(
                leading: Icon(
                  Icons.person,
                  size: 30,
                ),
                title: Text(
                  "Profile details",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: Icon(
                  Icons.navigate_next_outlined,
                  size: 30,
                ),
              ),
              const Divider(),
              const ListTile(
                leading: Icon(
                  Icons.bookmark,
                  size: 30,
                ),
                title: Text(
                  "Whitelist Anime",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: Icon(
                  Icons.navigate_next_outlined,
                  size: 30,
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.dark_mode,
                  size: 30,
                ),
                title: const Text(
                  "dark Mode",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: Switch(
                  value: true,
                  activeColor: Colors.white,
                  activeTrackColor: Colors.grey[700],
                  inactiveTrackColor: Colors.white,
                  inactiveThumbColor: Colors.grey[700],
                  onChanged: (value) {},
                ),
              ),
              const Divider(),
            ],
          ),
          Positioned(
            top: 115,
            left: MediaQuery.of(context).size.width / 2 - 62.5,
            child: Container(
              width: 125,
              height: 125,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: NetworkImage(
                      "https://cdn.pixabay.com/photo/2016/05/05/02/37/sunset-1373171_1280.jpg"),
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.circle,
                color: Colors.grey,
                border: Border.all(
                  color: Colors.white,
                  width: 5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}