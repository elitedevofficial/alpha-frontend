import 'package:flutter/material.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/providers/gradient_provider.dart';
import 'package:myapp/providers/homecatagory_provider.dart';
import 'package:myapp/widgets/commonwidget/common_colors.dart';
import 'package:myapp/widgets/commonwidget/gradientBorder.dart';
import 'package:provider/provider.dart';

class ConfigurePopup extends StatefulWidget {
  const ConfigurePopup({super.key});

  @override
  _ConfigurePopupState createState() => _ConfigurePopupState();
}

class _ConfigurePopupState extends State<ConfigurePopup> {
  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final gradientProvider = Provider.of<GradientProvider>(context);
    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.75,
        width: double.maxFinite,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: containerGardient,
        ),
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: GradientBoxBorder(
              gradient: containerBorderGardient,
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              PreferredSize(
                preferredSize: const Size.fromHeight(30),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: AppBar(
                    automaticallyImplyLeading: false,
                    title: const Text(
                      "Configure (Reorderable)",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: snowWhite),
                    ),
                    centerTitle: true,
                    backgroundColor: gradientProvider.tertiaryColor,
                  ),
                ),
              ),

              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Visible Categories",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: snowWhite),
                                ),
                                Icon(Broken.arrow_down_2, color: snowWhite)
                              ],
                            ),
                          ),
                          Expanded(
                            child: ReorderableListView(
                              physics: const BouncingScrollPhysics(),
                              onReorder: categoryProvider.reorderTop,
                              children: categoryProvider.tempTopCategories
                                  .asMap()
                                  .entries
                                  .map((entry) => Container(
                                        key: ValueKey(categoryProvider
                                            .tempTopCategories[entry.key]),
                                        color: Colors.transparent,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, right: 5, bottom: 7),
                                          child: GestureDetector(
                                            onTap: () {
                                              categoryProvider.moveToBottom(
                                                  categoryProvider
                                                          .tempTopCategories[
                                                      entry.key]);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(7),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      Broken.shuffle,
                                                      color: snowWhite,
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        categoryProvider
                                                                .tempTopCategories[
                                                            entry.key],
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: snowWhite,
                                                        ),
                                                      ),
                                                    ),
                                                    const Icon(Icons.check,
                                                        color: snowWhite)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 1,
                      color: snowWhite,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    // Bottom Categories
                    Expanded(
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Hidden Categories",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: snowWhite),
                                ),
                                Icon(Broken.arrow_down_2, color: snowWhite)
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              children: categoryProvider.tempBottomCategories
                                  .map((key) => Container(
                                        color: Colors.transparent,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, right: 5, bottom: 7),
                                          child: GestureDetector(
                                            onTap: () {
                                              categoryProvider.moveToTop(key);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(7),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      Broken.shuffle,
                                                      color: snowWhite,
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        key,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: snowWhite,
                                                        ),
                                                      ),
                                                    ),
                                                    const Icon(
                                                      Broken.add_circle,
                                                      color: snowWhite,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      if (categoryProvider.tempTopCategories.length < 2) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  "At least 2 categories must be visible!")),
                        );
                      } else {
                        categoryProvider.saveChanges();
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      'Done',
                      style: TextStyle(color: snowWhite),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: dangerRed),
                    ),
                  ),
                ],
              )
              // ElevatedButton(
              //   onPressed: () {
              // if (categoryProvider.tempTopCategories.length < 2) {
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     const SnackBar(
              //         content:
              //             Text("At least 2 categories must be visible!")),
              //   );
              // } else {
              //   categoryProvider.saveChanges();
              //   Navigator.pop(context);
              // }
              //   },
              //   child: const Text("Done"),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
