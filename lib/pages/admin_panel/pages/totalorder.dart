import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:namstore/widgets/button_widget.dart';
import 'package:namstore/widgets/custom_text_field.dart';

import '../../../constants/app_colors.dart';
import '../../../widgets/heading_widget.dart';
import '../../../widgets/sub_heading_widget.dart';

class Totalorder extends StatefulWidget {
  const Totalorder({super.key});

  @override
  State<Totalorder> createState() => _TotalorderState();
}

class _TotalorderState extends State<Totalorder> {
  int selectedIndex = 0;
  int selectedIndex1 = 0;

  TextEditingController pickupDateCtrl = TextEditingController();
  TextEditingController pickupDateCtrl1 = TextEditingController();

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

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
          return FractionallySizedBox(
            heightFactor: 0.7, // Adjust the height factor as needed
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HeadingWidget(
                        title: 'Filter',
                        fontSize: 20.0,
                      ),
                      Text(
                        'Clear filter',
                        style: TextStyle(
                          color: AppColors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.red,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  HeadingWidget(
                    title: 'Date',
                    fontWeight: FontWeight.w500,
                  ),
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
                  SizedBox(height: 10),
                  HeadingWidget(
                    title: 'Order Status',
                    fontWeight: FontWeight.w500,
                  ),

                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10, // Adds spacing between all children
                      children: [
                        _buildStatusTab(
                          'Delivered Orders',
                          1,
                          (index) {
                            setState(() {
                              // If the selected index is the same, reset to the initial state
                              if (selectedIndex == index) {
                                selectedIndex =
                                    -1; // or any initial value you want
                              } else {
                                selectedIndex = index;
                              }
                            });
                            setModalState(() {
                              // Reset to initial state if clicked again
                              if (selectedIndex == index) {
                                selectedIndex = index; // reset to initial state
                              } else {
                                selectedIndex = -1;
                              }
                            });
                          },
                        ),
                        _buildStatusTab(
                          'Cancelled Orders',
                          2,
                          (index) {
                            setState(() {
                              // If the selected index is the same, reset to the initial state
                              if (selectedIndex == index) {
                                selectedIndex =
                                    -1; // or any initial value you want
                              } else {
                                selectedIndex = index;
                              }
                            });
                            setModalState(() {
                              // Reset to initial state if clicked again
                              if (selectedIndex == index) {
                                selectedIndex = index; // reset to initial state
                              } else {
                                selectedIndex = -1;
                              }
                            });
                          },
                        ),
                        _buildStatusTab(
                          'In process',
                          3,
                          (index) {
                            setState(() {
                              // If the selected index is the same, reset to the initial state
                              if (selectedIndex == index) {
                                selectedIndex =
                                    -1; // or any initial value you want
                              } else {
                                selectedIndex = index;
                              }
                            });
                            setModalState(() {
                              // Reset to initial state if clicked again
                              if (selectedIndex == index) {
                                selectedIndex = index; // reset to initial state
                              } else {
                                selectedIndex = -1;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10),
                  HeadingWidget(
                    title: 'Order Time',
                    fontWeight: FontWeight.w500,
                  ),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Wrap(
                      spacing: 10, // Adds spacing between children

                      children: [
                        _buildStatusTab1(
                          'Past 30 days',
                          1,
                          (index) {
                            setState(() {
                              // If the selected index is the same, reset to the initial state
                              if (selectedIndex1 == index) {
                                selectedIndex1 =
                                    -1; // or any initial value you want
                              } else {
                                selectedIndex1 = index;
                              }
                            });
                            setModalState(() {
                              // Reset to initial state if clicked again
                              if (selectedIndex1 == index) {
                                selectedIndex1 =
                                    index; // reset to initial state
                              } else {
                                selectedIndex1 = -1;
                              }
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  Spacer(), // Pushes the button to the bottom
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.white,
                            side: BorderSide(color: AppColors.red),
                            minimumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context); // Close the bottom sheet
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.red),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        flex: 1,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.red,
                            minimumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context); // Close the bottom sheet
                          },
                          child: const Text(
                            'Apply',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.0,
        title: const Text(
          'Total orders',
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
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 3,
                  child: CustomeTextField(
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.red,
                    ),
                    hint: 'Search',
                    hintColor: AppColors.grey,
                    borderColor: AppColors.grey1,
                    width: double.infinity,
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  flex: 1,
                  child: ButtonWidget(
                    borderRadius: 10,
                    title: 'Filter',
                    width: double.infinity,
                    color: AppColors.red,
                    onTap: _showFilterSheet,
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        title: HeadingWidget(
                          fontSize: 20.0,
                          title: 'Order ID #2333563356',
                        ),
                        subtitle: SubHeadingWidget(
                          title: '3 items | 29-Oct-2024',
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        ),
                      ),
                      Divider(
                        color: AppColors.grey1,
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // // oderstatus
  Widget _buildStatusTab(String label, int index, Function(int) onTap) {
    final bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.red : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
              color: isSelected ? Colors.transparent : Colors.grey.shade300),
        ),
        child: Text(
          '$label',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSelected ? AppColors.white : AppColors.black,
          ),
        ),
      ),
    );
  }

  // // ordertime
  Widget _buildStatusTab1(String label, int index, Function(int) onTap) {
    final bool isSelected = selectedIndex1 == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.red : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
              color: isSelected ? Colors.transparent : Colors.grey.shade300),
        ),
        child: Text(
          '$label',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSelected ? AppColors.white : AppColors.black,
          ),
        ),
      ),
    );
  }
}
