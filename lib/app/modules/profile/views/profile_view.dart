import 'package:flutter/material.dart';
import 'package:flutter_list_anime/app/routes/app_pages.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.28,
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
                Center(
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () => Navigator.of(context).pushNamed(Routes.LOGIN),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                const ListTile(
                  title: Text(
                    "Username",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  trailing: Text(
                    "***********",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const ListTile(
                  title: Text(
                    "Email",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  trailing: Text(
                    "***********",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
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
                  trailing: Obx(
                    () => Switch(
                      value: controller.isDark.value,
                      activeColor: Colors.white,
                      activeTrackColor: Colors.grey[700],
                      inactiveTrackColor: Colors.white,
                      inactiveThumbColor: Colors.grey[700],
                      onChanged: (value) async {
                        controller.darkMode(value);
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setBool("darkmode", value);
                      },
                    ),
                  ),
                ),
                const Divider(),
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.28 - 65,
              left: MediaQuery.of(context).size.width / 2 - 62.5,
              child: Obx(
                () => Container(
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
                      color: (controller.isDark.value)
                          ? const Color.fromRGBO(18, 18, 18, 1)
                          : Colors.white,
                      width: 5,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
