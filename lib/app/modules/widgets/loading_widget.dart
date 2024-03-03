import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final String text;
  final double mediaQuery;
  const LoadingWidget({
    super.key,
    required this.text,
    required this.mediaQuery,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: mediaQuery,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            backgroundColor: Colors.blue,
            color: Colors.black,
            strokeWidth: 10,
            strokeAlign: 3,
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            text,
            style: const TextStyle(
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
