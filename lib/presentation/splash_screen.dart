
// import 'package:budget_management/constant/size.dart';
// import 'package:flutter/material.dart';

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SizedBox(
//         width: context.getWidth,
//         height: context.getHeight,
//         child: Stack(
//           children: [
//             Center(
//               child: Lottie.asset(
//                 'assets/images/money_1.json',
//                 //width: 100, // Width of the widget
//                 //height: 300, // Height of the widget
//                 fit: BoxFit
//                     .cover, // How the animation should fit into the widget
//                 repeat: true, // Set to true to loop the animation
//                 reverse: false,
//               ),
//             ),

//             Positioned(
//               left: 20,
//               right: 20,
//               bottom: 180,
//               child: Row(
//                 children: [
//                   Text(
//                     "Manage Your Budget",
//                     style: TextStyle(color: Colors.black, fontSize: 18),
//                   ),
//                   SizedBox(
//                     width: 20,
//                   ),
//                   InkWell(
//                       onTap: () {
//                         context.pushNav(screen: const HomeScreen());
//                       },
//                       child: Icon(Icons.arrow_forward))
//                 ],
//               ),
//             ),
//             // MovingEarth(
//             //   animatePosition: SplashAnimation(
//             //     topAfter: -150,
//             //     topBefore: -150,
//             //     leftAfter: -650,
//             //     leftBefore: -800,
//             //     bottomAfter: -150,
//             //     bottomBefore: -150,
//             //   ),
//             //   delayInMs: 1000,
//             //   durationInMs: 2500,
//             //   child: GestureDetector(
//             //       onDoubleTap: () {
//             //         // context.pushNav(screen: const HomeScreen());
//             //       },
//             //       child: Image.asset("assets/images/earth_home.jpg")),
//             // ),
//             // Positioned(
//             //     left: 25,
//             //     bottom: 20,
//             //     right: 25,
//             //     child: RichText(
//             //       text: TextSpan(
//             //         style: headerStyle.copyWith(fontSize: 35),
//             //         children: [
//             //           const TextSpan(text: 'Manage your Budget '),
//             //           // TextSpan(
//             //           //     text: 'home',
//             //           //     style: headerStyle.copyWith(color: blue)),
//             //         ],
//             //       ),
//             //     ))
//           ],
//         ),
//       ),
//     );
//   }
// }