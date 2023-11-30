// import 'package:amazon_clone/utils/utils.dart';
import 'package:amazon_mobile/presentation/resources/utils.dart';
import 'package:flutter/material.dart';

class CustomMainButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final bool isLoading;
  final VoidCallback onPressed;
  final double? width;
  CustomMainButton({
    Key? key,
    required this.child,
    required this.color,
    required this.isLoading,
    required this.onPressed,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Container(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            fixedSize: width != null ? Size(width!, 40) : null,),
        onPressed: onPressed,
        child: !isLoading
            ? Center(child: child)
            : CircularProgressIndicator(
                    color: Colors.white,
                  ),
      ),
    );
  }
}