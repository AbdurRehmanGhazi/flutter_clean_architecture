// import 'package:flutter/material.dart';
// import 'package:salaam_stocks_app/core/widgets/widgets/loader.dart';
//
// import '../../theme/app_pallete.dart';
//
//
// class SubmitButton extends StatelessWidget {
//   const SubmitButton({
//     super.key,
//     required this.buttonText,
//     required this.onPressed,
//     this.isLoading = false,
//     this.isEnable = true,
//     this.height = 50,
//   });
//
//   final String buttonText;
//   final VoidCallback onPressed;
//   final bool isLoading;
//   final bool isEnable;
//   final double height;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: height,
//       decoration: BoxDecoration(
//           color: isLoading
//               ? AppPallete.transparentColor
//               : isEnable ? AppPallete.primaryButtonColor : AppPallete.unselectedItemColor,
//           borderRadius: BorderRadius.circular(6),
//           border: Border.all(color: AppPallete.primaryColor)),
//       child: isLoading
//           ? const Loader()
//           : ElevatedButton(
//         onPressed: isEnable ? onPressed : null,
//         style: ElevatedButton.styleFrom(
//             backgroundColor: AppPallete.transparentColor,
//             shadowColor: AppPallete.transparentColor,
//             padding: EdgeInsets.zero
//         ),
//         child: Text(
//           buttonText,
//           style: TextStyle(
//             color: AppPallete.primaryButtonTextColor,
//             fontSize: 14,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//       ),
//     );
//   }
// }
