import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// extension ToastExt on FToast {
//   void showToastText(String textMsg) {
//     showToast(
//       child: Card(
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
//           color: const Color.fromARGB(255, 213, 213, 213),
//           child: Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Text(
//               textMsg,
//               style: const TextStyle(color: Colors.black, fontSize: 16),
//             ),
//           )),
//       gravity: ToastGravity.SNACKBAR,
//       toastDuration: const Duration(seconds: 3),
//     );
//   }
// }

extension BuildContextExt on BuildContext {
  void showSnackBar({required String msg, int durationS = 2}) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(msg),
      duration: Duration(seconds: durationS),
    ));
  }
}
