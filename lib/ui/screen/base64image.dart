// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_task_manager_project/ui/utils/assets_utils.dart';
//
//
// class Base64Image {
//   //encode image path to base64 and send to server
//   static Future<String> base64EncodedString(image) async {
//     List<int> imageBytes = await image!.readAsBytes();
//     return base64Encode(imageBytes);
//   }
//
//   //decode base64 before showing on UI
//   static ImageProvider<Object> imageFromBase64String(String str) {
//     List<int> imageBytes = base64Decode(str);
//     return Image.memory(Uint8List.fromList(imageBytes), fit: BoxFit.cover,).image;
//   }
//
//   //check if the received string is in base64 or not
//   static bool isBase64String(String str) {
//     try {
//       base64.decode(str);
//       return true;
//     } catch (_) {
//       return false;
//     }
//   }
//
//   //get the image for UI
//   static ImageProvider<Object> getBase64Image(String base64String) {
//     if (base64String.isNotEmpty) {
//       return imageFromBase64String(base64String);
//     } else {
//       return Image.asset(AssetsUtils.logoSvg).image;
//     }
//   }
// }