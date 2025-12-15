import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:prueba_tecnica/ui/color_palette.dart';

class ReintentarWidget extends StatelessWidget {
  const ReintentarWidget({super.key, required this.onRetry});
  final void Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Ocurrio un error al obtener los datos',
            style: TextStyle(
              color: textColor,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(10),
          ElevatedButton(
            onPressed: onRetry,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(accentSecondary),
              foregroundColor: WidgetStateProperty.all(textColor),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              elevation: WidgetStateProperty.all(0),
            ),
            child: Text('Reintentar', style: TextStyle(fontSize: 18.sp)),
          ),
        ],
      ),
    );
  }
}
