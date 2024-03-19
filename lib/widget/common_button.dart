// import 'package:flutter/material.dart';
 

import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({super.key,
  required this.onSubmit,

    this.isLoading,

    required this.bgColor,

    required this.child,

    this.loadingColor = Colors.white,

    this.width = 265,

    this.height = 39,

    this.disabledBgColor,});

      final void Function()? onSubmit;

  final bool? isLoading;

  final Color bgColor;

  final Widget child;

  final Color? loadingColor;

  final double? width;

  final double? height;

  final Color? disabledBgColor;

  
  factory CommonButton.square({

    required Color bgColor,

    required void Function()? onSubmit,

    required Widget child,

    bool? isLoading,

    double? dimension,

  }) {

    return CommonButton(

      width: dimension ?? 39,

      height: dimension ?? 39,

      isLoading: isLoading,

      onSubmit: onSubmit,

      bgColor: bgColor,

      child: child,

    );

  }

  @override Widget build(BuildContext context) {
    return Container();
  }
 
}