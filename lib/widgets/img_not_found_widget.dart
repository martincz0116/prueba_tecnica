import 'package:flutter/material.dart';

class ImgNotFoundWidget extends StatelessWidget {
  const ImgNotFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(child: Icon(Icons.hide_image_outlined, size: 100));
  }
}
