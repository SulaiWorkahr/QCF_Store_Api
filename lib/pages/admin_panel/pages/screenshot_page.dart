import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:namstore/pages/dashboard/dashboard_page.dart';
import 'package:namstore/widgets/button_widget.dart';

import '../../../constants/app_assets.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_constants.dart';
import '../../../services/comFuncService.dart';
import '../../../services/nam_food_api_service.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/heading_widget.dart';
import '../../../widgets/outline_btn_widget.dart';
import '../../../widgets/sub_heading_widget.dart';
import '../api_model/screenshot_page_model_api.dart';

class ScreenshotPage extends StatefulWidget {
  int? storeId;
  ScreenshotPage({super.key, this.storeId});

  @override
  State<ScreenshotPage> createState() => _ScreenshotPageState();
}

class _ScreenshotPageState extends State<ScreenshotPage> {
  final NamFoodApiService apiService = NamFoodApiService();

  @override
  void initState() {
    super.initState();
    getScreenshotpage();
  }

  List<ScreeenShots> screenshotpage = [];
  List<ScreeenShots> screenshotpageAll = [];
  bool isLoading = false;

  Future getScreenshotpage() async {
    setState(() {
      isLoading = true;
    });

    try {
      var result = await apiService.getScreenshotpage(widget.storeId);
      var response = screenshotPageModelFromJson(result);
      if (response.status.toString() == 'SUCCESS') {
        setState(() {
          screenshotpage = response.list;
          screenshotpageAll = screenshotpage;
          isLoading = false;
        });
      } else {
        setState(() {
          screenshotpage = [];
          screenshotpageAll = [];
          isLoading = false;
        });
        showInSnackBar(context, response.message.toString());
      }
    } catch (e) {
      setState(() {
        screenshotpage = [];
        screenshotpageAll = [];
        isLoading = false;
      });
      showInSnackBar(context, 'Error occurred: $e');
      print(e);
    }

    setState(() {});
  }

  String? selectedValue = 'cash_on_delivery';

  TextEditingController pickupDateCtrl = TextEditingController();
  TextEditingController pickupDateCtrl1 = TextEditingController();
  TextEditingController enteramount = TextEditingController();

  errValidatepickfrom(String? value) {
    return (value) {
      if (value.isEmpty) {
        return 'From Date is required';
      }
      return null;
    };
  }

  errValidatepickto(String? value) {
    return (value) {
      if (value.isEmpty) {
        return 'To Date is required';
      }
      return null;
    };
  }

  void showpayment() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding: EdgeInsets.all(20),
          content: StatefulBuilder(
            // Use StatefulBuilder to update the dialog state
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeadingWidget(
                    title: 'Pay amount',
                    fontSize: 20.0,
                  ),
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomeTextField(
                        control: enteramount,
                        width: double.infinity,
                        hint: 'Enter Amount',
                      ),
                      HeadingWidget(
                        title: 'Select payment method',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Image.asset(AppAssets.moneyIcon,
                                        height: 25,
                                        width: 25,
                                        color: Colors.red),
                                    SizedBox(width: 12),
                                    HeadingWidget(
                                      title: 'Cash on Delivery',
                                      fontSize: 15.0,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                                Radio(
                                  value: 'cash_on_delivery',
                                  groupValue: selectedValue,
                                  activeColor: AppColors.red,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Image.asset(
                                      AppAssets.onlinePaymentIcon,
                                      height: 25,
                                      width: 25,
                                      color: Colors.red,
                                    ),
                                    SizedBox(width: 12),
                                    HeadingWidget(
                                      title: 'Online Payment',
                                      color: Colors.black,
                                      fontSize: 15.0,
                                    ),
                                  ],
                                ),
                                Radio(
                                  value: 'Online Payment',
                                  groupValue: selectedValue,
                                  activeColor: AppColors.red,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      HeadingWidget(
                        title: 'Note: Upload image with shop name',
                        fontSize: 14.0,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      OutlineBtnWidget(
                        height: 40,
                        width: double.infinity,
                        fillColor: AppColors.n_blue.withOpacity(0.1),
                        borderColor: AppColors.n_blue,
                        title: 'Upload Screenshot Image',
                        titleColor: AppColors.n_blue,
                        icon: Icons.add_a_photo_rounded,
                        iconColor: AppColors.n_blue,
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          actions: [
            Center(
                child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              label: Text('Submit'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 40),
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            )),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100.0,
        title: const Text(
          'Back',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.red,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: CustomeTextField(
                      labelText: 'From',
                      prefixIcon: const Icon(
                        Icons.date_range,
                      ),
                      control: pickupDateCtrl,
                      width: MediaQuery.of(context).size.width - 10,
                      readOnly: true, // when true user cannot edit text
                      validator: errValidatepickfrom(pickupDateCtrl.text),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1948),
                          lastDate: DateTime(2100),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: AppColors.red,
                                  // Theme.of(context)
                                  //     .primaryColor, // <-- SEE HERE
                                  onSurface: AppColors.red,

                                  // Theme.of(context)
                                  //     .primaryColor, // <-- SEE HERE
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor: AppColors.lightred,
                                    backgroundColor: AppColors.red,
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );

                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('dd-MM-yyyy').format(pickedDate);

                          setState(() {
                            pickupDateCtrl.text = formattedDate;
                          });
                        } else {
                          print("Date is not selected");
                        }
                      }),
                ),
                SizedBox(width: 10),
                Flexible(
                  flex: 1,
                  child: CustomeTextField(
                      labelText: 'To',
                      prefixIcon: const Icon(
                        Icons.date_range,
                      ),
                      control: pickupDateCtrl1,
                      width: MediaQuery.of(context).size.width - 10,
                      readOnly: true, // when true user cannot edit text
                      validator: errValidatepickto(pickupDateCtrl.text),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1948),
                          lastDate: DateTime(2100),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: AppColors.red,
                                  // Theme.of(context)
                                  //     .primaryColor, // <-- SEE HERE
                                  onSurface: AppColors.red,

                                  // Theme.of(context)
                                  //     .primaryColor, // <-- SEE HERE
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor: AppColors.lightred,
                                    backgroundColor: AppColors.red,
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );

                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('dd-MM-yyyy').format(pickedDate);

                          setState(() {
                            pickupDateCtrl1.text = formattedDate;
                          });
                        } else {
                          print("Date is not selected");
                        }
                      }),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: screenshotpage.length,
                itemBuilder: (context, index) {
                  final e = screenshotpage[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.grey1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HeadingWidget(
                              title: e.storeName.toString(),
                              fontSize: 18.0,
                            ),
                            HeadingWidget(
                              title: e.address.toString(),
                              fontSize: 16.00,
                              fontWeight: FontWeight.w600,
                            ),

                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              height: 10,
                              color: AppColors.grey1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: AppColors.grey1),
                                  ),
                                  child: Image.asset(
                                    AppAssets.UserRounded,
                                    width: 18,
                                    height: 18,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      HeadingWidget(
                                        title: e.ownerName.toString(),
                                      ),
                                      SubHeadingWidget(
                                        title: e.storeMobile.toString(),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  // height: 24,
                                  // width: 24,
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: AppColors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset(
                                    AppAssets.call_icon,
                                    width: 30,
                                    height: 30,
                                    color: AppColors.white,
                                  ),
                                ),
                              ],
                            ),
                            // Add spacing for better alignment
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      HeadingWidget(
                        title: e.createdDate.toString(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.grey1),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SubHeadingWidget(
                                        title: 'Amount',
                                      ),
                                      HeadingWidget(
                                        title: "₹${e.amount}",
                                      )
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: AppColors.lightred,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: SubHeadingWidget(
                                      title:
                                          e.paymentMethod.toString() == 'Cash'
                                              ? 'Cash on delivery'
                                              : 'Online Payment',
                                      color: AppColors.red,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              DottedBorder(
                                color: Colors.grey, // Color of the border
                                strokeWidth: 1, // Width of the border
                                dashPattern: [
                                  6,
                                  3
                                ], // Define dash and gap length
                                borderType:
                                    BorderType.RRect, // Shape of the border
                                radius: Radius.circular(6), // Rounded corners
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.grey1,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      // e.imageUrl != null
                                      //     ?
                                      Image.network(
                                        height: 80,
                                        width: 100,
                                        AppConstants.imgBaseUrl +
                                            (e.imageUrl ?? ''),
                                      ),
                                      // :
                                      //  Image.asset(
                                      //     AppAssets.payment,
                                      //     height: 80,
                                      //     width: 100,
                                      //   ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      SubHeadingWidget(
                                        title: '12455221',
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),

                      //another modelpayment

                      // SizedBox(
                      //   height: 14,
                      // ),
                      // HeadingWidget(
                      //   title: e.date,
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Container(
                      //     padding: const EdgeInsets.all(14),
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(10),
                      //       border: Border.all(color: AppColors.grey1),
                      //     ),
                      //     child: Column(
                      //       children: [
                      //         Row(
                      //           mainAxisAlignment:
                      //               MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             Column(
                      //               crossAxisAlignment:
                      //                   CrossAxisAlignment.start,
                      //               children: [
                      //                 SubHeadingWidget(
                      //                   title: 'Amount',
                      //                 ),
                      //                 HeadingWidget(
                      //                   title: "₹${e.amount}",
                      //                 )
                      //               ],
                      //             ),
                      //             Container(
                      //               padding: EdgeInsets.all(8),
                      //               decoration: BoxDecoration(
                      //                   color: AppColors.lightred,
                      //                   borderRadius:
                      //                       BorderRadius.circular(10)),
                      //               child: SubHeadingWidget(
                      //                 title: 'Cash on delivery',
                      //                 color: AppColors.red,
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //         SizedBox(
                      //           height: 10,
                      //         ),
                      //         e.imageUrl != null
                      //             ? Image.network(
                      //                 AppConstants.imgBaseUrl +
                      //                     (e.imageUrl ?? ''),
                      //               )
                      //             : Image.asset(
                      //                 AppAssets.payment,
                      //                 fit: BoxFit.fill,
                      //               )
                      //       ],
                      //     )),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ButtonWidget(
          title: 'Add Amount',
          width: 250,
          height: 45,
          color: AppColors.red,
          borderRadius: 10,
          onTap: showpayment,
        ),
      ),
    );
  }
}
