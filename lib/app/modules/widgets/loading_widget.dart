import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.9,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            backgroundColor: Colors.blue,
            color: Colors.black,
            strokeWidth: 10,
            strokeAlign: 3,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Memuat list Anime....",
            style: TextStyle(
              // fontFamily: "Poppins",
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
