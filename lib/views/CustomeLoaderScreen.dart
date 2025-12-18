// import 'package:flutter/material.dart';

// class CustomLoadingScreen extends StatelessWidget {
//   final String? message;

//   const CustomLoadingScreen({
//     super.key,
//     this.message,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const SizedBox(
//               width: 50,
//               height: 50,
//               child: CircularProgressIndicator(
//                 strokeWidth: 4,
//               ),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               message ?? "Please wait...",
//               style: const TextStyle(
//                 fontSize: 14,
//                 color: Colors.black54,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
