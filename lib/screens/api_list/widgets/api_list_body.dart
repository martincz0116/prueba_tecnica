import 'package:flutter/material.dart';
import 'package:prueba_tecnica/models/apo_list_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prueba_tecnica/screens/api_list/helpers/api_list_helper.dart';
import 'package:prueba_tecnica/screens/api_list/widgets/item_details_view.dart';
import 'package:prueba_tecnica/ui/color_palette.dart';
import 'package:prueba_tecnica/widgets/Img_widget.dart';
import 'package:prueba_tecnica/widgets/img_not_found_widget.dart';

class ApiListBody extends StatelessWidget {
  const ApiListBody(this.data, {super.key});
  final List<ApodList> data;

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
            builder: (BuildContext context) => ItemDetailsView(index, data[index]),
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
                  Expanded(flex: 2, child: ImgWidget(url: url)),
                if (data[index].mediaType == 'video')
                  Expanded(flex: 2, child: ImgNotFoundWidget()),
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
}
