import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prueba_tecnica/models/apo_list_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prueba_tecnica/ui/color_palette.dart';

class ApiListBody extends StatelessWidget {
  const ApiListBody(this.data, {super.key});
  final List<ApodList> data;

  String? setImgUrl(String? url, String? uhdUrl) {
    return uhdUrl ?? url;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 40,
        crossAxisSpacing: 40,
      ),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      itemCount: data.length,
      itemBuilder: (context, index) {
        String? url = setImgUrl(data[index].url, data[index].hdurl);
        return _items(url, index, context);
      },
    );
  }

  Widget _items(String? url, int index, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (BuildContext context) => Scaffold(
              appBar: AppBar(title: const Text('Second Page')),
              body: Center(
                child: Hero(
                  tag: index,
                  child: url != null ? _img(url) : _imgNotFound(),
                ),
              ),
            ),
          ),
        );
      },
      child: Hero(
        tag: index,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: accentColor.withValues(alpha: 0.3),
                blurRadius: 8,
                spreadRadius: 1,
                offset: const Offset(3, 5),
              ),
            ],
          ),
          child: Card(
            elevation: 0,
            color: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              children: [
                if (url != null && data[index].mediaType == 'image')
                  Expanded(flex: 2, child: _img(url)),
                if (data[index].mediaType == 'video')
                  Expanded(flex: 2, child: _imgNotFound()),
                Flexible(child: _imgTitle(index)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _imgTitle(int index) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.r),
          bottomRight: Radius.circular(10.r),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Text(
        data[index].title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: textColor,
          fontSize: 16.sp,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  FittedBox _imgNotFound() {
    return FittedBox(child: Icon(Icons.hide_image_outlined, size: 100));
  }

  ClipRRect _img(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.r),
        topRight: Radius.circular(10.r),
      ),
      child: CachedNetworkImage(
        imageUrl: url,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.fill,
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator(color: textColor)),
        errorWidget: (context, url, error) =>
            const Icon(Icons.error_outline, color: Colors.red),
      ),
    );
  }
}
