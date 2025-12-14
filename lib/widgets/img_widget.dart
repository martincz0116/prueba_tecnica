import 'package:flutter/material.dart';
import 'package:prueba_tecnica/ui/color_palette.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImgWidget extends StatelessWidget {
  const ImgWidget({
    super.key,
    required this.url,
    this.radius = const Radius.circular(10),
  });

  final String url;
  final Radius radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: radius,
        topRight: radius,
      ),
      child: CachedNetworkImage(
        imageUrl: url,
        imageBuilder: (context, imageProvider) => Image(
          image: imageProvider,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fill,
        ),
        memCacheHeight: 500,
        memCacheWidth: 500,
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator(color: textColor)),
        errorWidget: (context, url, error) =>
            const Icon(Icons.error_outline, color: Colors.red),
      ),
    );
  }
}
