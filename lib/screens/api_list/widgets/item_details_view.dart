import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:prueba_tecnica/models/apo_list_model.dart';
import 'package:prueba_tecnica/screens/api_list/helpers/api_list_helper.dart';
import 'package:prueba_tecnica/ui/color_palette.dart';
import 'package:prueba_tecnica/ui/decorations.dart';
import 'package:prueba_tecnica/widgets/img_not_found_widget.dart';
import 'package:prueba_tecnica/widgets/img_widget.dart';

class ItemDetailsView extends StatelessWidget {
  ItemDetailsView(this.index, this.item, {super.key});
  final int index;
  final ApodList item;
  late final TextEditingController controller = TextEditingController(
    text: item.title,
  );
  late final String? url = setImgUrl(item.url, item.hdurl);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: BackButton(color: Colors.white),
          actions: [
            IconButton(
              icon: const Icon(Icons.bookmark_outline),
              color: Colors.white,
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: url == null
                  ? const ImgNotFoundWidget()
                  : ImgWidget(url: url!, radius: Radius.zero),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(color: backgroundColor),
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: TextField(
                        controller: controller,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        cursorColor: textColor,
                        showCursor: true,
                        decoration: textFieldDecoration(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: textColor,
                          fontSize: 18.sp,
                          wordSpacing: 2,
                        ),
                      ),
                    ),
                    Gap(10),
                    Text(
                      'Fecha: ${DateFormat('dd/MM/yyyy').format(item.date)}',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16.sp,
                        wordSpacing: 2,
                      ),
                    ),
                    Gap(10),
                    Expanded(
                      flex: 4,
                      child: SingleChildScrollView(
                        child: Text(
                          item.explanation,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 16.sp,
                            wordSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
