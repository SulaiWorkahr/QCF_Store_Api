import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:namstore/constants/app_assets.dart';
import 'package:namstore/constants/app_colors.dart';
import 'package:namstore/pages/store_menu/add_new_menu.dart';
import 'package:namstore/pages/store_menu/edit_menu.dart';

import '../../constants/app_constants.dart';
import '../../services/comFuncService.dart';
import '../../services/nam_food_api_service.dart';
import '../../widgets/heading_widget.dart';
import '../models/menu_details_model.dart';
import 'menu_edit_model.dart';
import 'menu_list_model.dart';

class MenuDetailsScreen extends StatefulWidget {
  @override
  _MenuDetailsScreenState createState() => _MenuDetailsScreenState();
}

class _MenuDetailsScreenState extends State<MenuDetailsScreen> {
  final NamFoodApiService apiService = NamFoodApiService();

  bool isOnDuty = true;
  bool inStock1 = true;
  String toggleTitle = "On Duty";
  bool? inStock;
  @override
  void initState() {
    super.initState();
    getdashbordlist();

    getmenuList();
  }

  //Store Menu Details

  List<MenuDetailList> menudeatilslistpage = [];
  List<MenuDetailList> menudeatilslistpageAll = [];
  bool isLoading = false;

  Future getdashbordlist() async {
    setState(() {
      isLoading = true;
    });

    try {
      var result = await apiService.getmenudetailslist();
      var response = storemenulistmodelFromJson(result);
      if (response.status.toString() == 'SUCCESS') {
        setState(() {
          menudeatilslistpage = response.list;
          menudeatilslistpageAll = menudeatilslistpage;
          isLoading = false;
        });
      } else {
        setState(() {
          menudeatilslistpage = [];
          menudeatilslistpageAll = [];
          isLoading = false;
        });
        showInSnackBar(context, response.message.toString());
      }
    } catch (e) {
      setState(() {
        menudeatilslistpage = [];
        menudeatilslistpageAll = [];
        isLoading = false;
      });
      showInSnackBar(context, 'Error occurred: $e');
    }

    setState(() {});
  }

  List<MenuList> MenuListData = [];
  List<MenuList> MenuListAll = [];
  bool isLoading1 = false;

  Future<void> getmenuList() async {
    await apiService.getBearerToken();
    setState(() {
      isLoading1 = true; // Start loading
    });

    try {
      var result = await apiService.getmenuList();
      print("Raw API Response: $result"); // Log raw response for debugging

      // Check if the response is valid JSON
      var jsonResponse;
      try {
        jsonResponse = json.decode(result);
      } catch (e) {
        print("Failed to parse JSON: $e");
        showInSnackBar(context, "Invalid JSON format");
        setState(() => isLoading1 = false);
        return;
      }

      var response = MenuListmodel.fromJson(jsonResponse);
      print("Menu List status: ${response.status}");
      print("Menu List data: ${response.list}");

      if (response.status.toUpperCase() == 'SUCCESS') {
        setState(() {
          MenuListData = response.list;
          MenuListAll =
              List.from(response.list); // Deep copy for further filtering
          isLoading1 = false; // Stop loading after successful fetch
        });
      } else {
        print("API Error Message: ${response.message}");
        showInSnackBar(context, response.message);
        setState(() {
          MenuListData = [];
          MenuListAll = [];
          isLoading1 = false; // Stop loading on error
        });
      }
    } catch (e, stackTrace) {
      print("Exception: $e");
      print("StackTrace: $stackTrace");
      setState(() {
        MenuListData = [];
        MenuListAll = [];
        isLoading1 = false; // Stop loading on exception
      });
      showInSnackBar(context, "An error occurred: $e");
    }
  }

  Future updatemenustock(id, value) async {
    await apiService.getBearerToken();

    Map<String, dynamic> postData = {
      "item_id": id,
      "item_stock": value,
    };
    print("item_stock $postData");
    var result = await apiService.updatemenustock(postData);

    MenuEditmodel response = menuEditmodelFromJson(result);

    if (response.status.toString() == 'SUCCESS') {
      showInSnackBar(context, response.message.toString());
      Navigator.pop(context, {'update': true});
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => Third_party_List(),
      //   ),
      // );
    } else {
      print(response.message.toString());
      showInSnackBar(context, response.message.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 95.0,
        leading: Icon(
          size: 30,
          Icons.menu,
          color: Colors.white,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                HeadingWidget(
                  title: toggleTitle.toString(),
                  color: Colors.white,
                  fontSize: 18.0,
                ),
                SizedBox(
                  width: 8.0,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                    child: Transform.scale(
                        scale: 0.9,
                        child: Switch(
                          value: isOnDuty,
                          onChanged: (value) {
                            setState(() {
                              isOnDuty = value;
                              if (isOnDuty == true) {
                                toggleTitle = "On Duty";
                              } else {
                                toggleTitle = "Off Duty";
                              }
                            });
                          },
                          activeColor: Colors.white,
                          activeTrackColor: Colors.green,
                          inactiveThumbColor: Colors.grey,
                          inactiveTrackColor: Colors.grey.shade300,
                        ))),
              ],
            ),
          )
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        backgroundColor: Color(0xFFE23744),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.only(
                    top: 16.0, left: 16.0, right: 16.0, bottom: 0),
                child: Container(
                  margin: EdgeInsets.only(bottom: 16),
                  //color: Colors.white,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color.fromARGB(255, 217, 216, 216),
                      width: 0.8,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              AppAssets.restaurant_briyani,
                              height: 100,
                              width: 100,
                            )),
                        SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Grill Chicken Arabian\nRestaurant',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            SizedBox(height: 4),
                            Text('South Indian Foods',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14)),
                            SizedBox(height: 4),
                            Text('Open Time: 8.30am - 11.00pm',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14)),
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
            Padding(
                padding: EdgeInsets.only(
                    top: 0.0, left: 16.0, right: 16.0, bottom: 5),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Image.asset(AppAssets.search_icon),
                    hintText: 'Find your dishes',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                )),
            SizedBox(height: 16),
            Padding(
                padding: EdgeInsets.only(
                    top: 5.0, left: 16.0, right: 16.0, bottom: 5),
                child: Text('Menus',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
            SizedBox(height: 8),
            isLoading1
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: MenuListData.length,
                    shrinkWrap:
                        true, // Let the list take only as much space as needed
                    physics:
                        NeverScrollableScrollPhysics(), // Disable scrolling for ListView
                    itemBuilder: (context, index) {
                      final e = MenuListData[index];
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 5.0, left: 16.0, right: 16.0, bottom: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                        AppConstants.imgBaseUrl +
                                            e.itemImageUrl.toString(),
                                        width: 90,
                                        height: 90,
                                        fit: BoxFit.fill, errorBuilder:
                                            (BuildContext context,
                                                Object exception,
                                                StackTrace? stackTrace) {
                                      return Image.asset(
                                        AppAssets.store_menu_briyani,
                                        width: 90,
                                        height: 90,
                                        // fit: BoxFit.cover,
                                      );
                                    }),

                                    //     Image.asset(
                                    //   e.itemImageUrl
                                    //       .toString(), // AppAssets.store_menu_briyani,
                                    //   width: 90,
                                    //   height: 90,
                                    //   fit: BoxFit.cover,
                                    // ),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            e.itemType == 1
                                                ? Image.asset(
                                                    AppAssets.nonveg_icon)
                                                : Image.asset(
                                                    AppAssets.veg_icon),
                                            SizedBox(width: 4),
                                            Text(
                                                e.itemType == 1
                                                    ? "Non-Veg"
                                                    : "Veg", //'Non-Veg',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14)),
                                          ],
                                        ),
                                        Text(e.itemName, //'Chicken Biryani',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                        SizedBox(height: 4),
                                        Text("₹${e.storePrice}", //'₹250.00',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: Color.fromARGB(255, 217, 216, 216),
                                      width: 0.8,
                                    ),
                                    bottom: BorderSide(
                                      color: Color.fromARGB(255, 217, 216, 216),
                                      width: 0.8,
                                    ),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 246, 245, 245),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 10,
                                        bottom: 10,
                                        left: 10,
                                        right: 40),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                            // mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 0.0),
                                                  child: Transform.scale(
                                                      scale: 0.8,
                                                      child: Switch(
                                                        value: e.itemStock == 1,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            e.itemStock =
                                                                value ? 1 : 0;

                                                            updatemenustock(
                                                                e.itemId,
                                                                value ? 1 : 0);
                                                            //  print(e.itemStock);
                                                          });
                                                        },
                                                        activeColor:
                                                            Colors.white,
                                                        activeTrackColor:
                                                            Colors.green,
                                                        inactiveThumbColor:
                                                            Colors.white,
                                                        inactiveTrackColor:
                                                            Colors.grey[300],
                                                      ))),
                                              Text('In stock',
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 18.0))
                                            ]),
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddNewMenu(
                                                            menuId: e.itemId,
                                                          ))).then((value) {});
                                            },
                                            child: Row(
                                                // mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                      AppAssets.edit_icon),
                                                  Text(' Edit',
                                                      style: TextStyle(
                                                          color: AppColors.red,
                                                          fontSize: 18.0))
                                                ])),
                                      ],
                                    ))),
                            SizedBox(
                              height: 10,
                            ),
                          ]);
                    }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNewMenu(),
            ),
          );
        },
        shape: CircleBorder(),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: AppColors.red,
        elevation: 6.0,
      ),
    );
  }
}
