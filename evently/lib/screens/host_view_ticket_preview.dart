import 'package:evently/utils/constants.dart';
import 'package:evently/utils/evently_app_theme.dart';
import 'package:evently/utils/space_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HostTicketPreview extends StatefulWidget {
  const HostTicketPreview({super.key});

  @override
  State<HostTicketPreview> createState() => _HostTicketPreviewState();
}

class _HostTicketPreviewState extends State<HostTicketPreview> {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: EventlyAppTheme.kWhite,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: EventlyAppTheme.kWhite,
          body: Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: Stack(
              children: [
                Image.asset(
                  PngUtils.kHostPreview,
                  width: double.infinity,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25.h, right: 27.w),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.r),
                          topLeft: Radius.circular(10.r),
                        ),
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Image.asset(
                              PngUtils.kPhantom,
                              fit: BoxFit.contain,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.w, bottom: 10.h),
                              child: Text(
                                'The Phantom of the Opera',
                                style: TextStyle(fontSize: 20.sp, color: EventlyAppTheme.kWhite, fontWeight: FontWeight.w700),
                              ),
                            )
                          ],
                        ),
                      ),
                      VerticalSpace(10.h),
                      Padding(
                        padding: EdgeInsets.only(left: 10.w, right: 30.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'DATE',
                                  style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w400, color: EventlyAppTheme.kWhite),
                                ),
                                SizedBox(height: 1.h),
                                Text(
                                  'Jul 04, 2022',
                                  style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: EventlyAppTheme.kWhite),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Time',
                                  style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w400, color: EventlyAppTheme.kWhite),
                                ),
                                SizedBox(height: 1.h),
                                Text(
                                  '7:15 PM',
                                  style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: EventlyAppTheme.kWhite),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      VerticalSpace(20.h),
                      Padding(
                        padding: EdgeInsets.only(left: 10.w, right: 30.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'LOCATION',
                                  style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w400, color: EventlyAppTheme.kWhite),
                                ),
                                SizedBox(height: 1.h),
                                ConstrainedBox(
                                  constraints: BoxConstraints(maxWidth: 1.sw / 2.4),
                                  child: Text(
                                    '245 W 44th St New York, NY 10036',
                                    style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: EventlyAppTheme.kWhite),
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'SEAT',
                                  style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w400, color: EventlyAppTheme.kWhite),
                                ),
                                SizedBox(height: 1.h),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '6A',
                                      style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold, color: EventlyAppTheme.kWhite),
                                    ),
                                    Text(
                                      'Room 3',
                                      style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: EventlyAppTheme.kWhite),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),


                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
