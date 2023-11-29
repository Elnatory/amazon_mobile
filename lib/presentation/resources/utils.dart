import 'dart:math';

import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

class Utils {
  Size getScreenSize() {
    return MediaQueryData.fromView(WidgetsBinding.instance.window).size;
  }

  void showSnackBar(
      {required BuildContext context,
      required String content,
      Duration duration = const Duration(seconds: 1)}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.orange,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                content,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        duration: duration, // Specify the duration here
      ),
    );
  }

  // Future<Uint8List?> pickImage() async {
  //   ImagePicker picker = ImagePicker();
  //   XFile? file = await picker.pickImage(source: ImageSource.gallery);
  //   return file!.readAsBytes();
  // }

  String getUid() {
    return (100000 + Random().nextInt(10000)).toString();
  }
}
