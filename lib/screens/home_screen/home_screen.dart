import 'package:flutter/material.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/providers/gradient_provider.dart';
import 'package:myapp/providers/homecatagory_provider.dart';
import 'package:myapp/widgets/commonwidget/common_colors.dart';
import 'package:myapp/widgets/commonwidget/gradientBorder.dart';
import 'package:myapp/widgets/homewidget/home_carousel.dart';
import 'package:myapp/widgets/homewidget/home_catagory_popup.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(gradient: getAppGradient(context)),
          ),
          SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HomeWelcome(),
                  const SizedBox(height: 15),
                  // const HomeCarousel(),
                  const SizedBox(height: 15),
                  CategoryList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeWelcome extends StatefulWidget {
  const HomeWelcome({super.key});

  @override
  State<HomeWelcome> createState() => _HomeWelcomeState();
}

class _HomeWelcomeState extends State<HomeWelcome> {
  void showCategoryPopup(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) {
        final categoryProvider = Provider.of<CategoryProvider>(context);
        final gradientProvider = Provider.of<GradientProvider>(context);
        return Dialog(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: LayoutBuilder(builder: (context, constraints) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.65,
              width: double.maxFinite,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: gradientProvider.tertiaryColor),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: gradientProvider.secondaryColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                    ),
                    child: const Text(
                      'Configure (Reorderable)',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: snowWhite,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'LexendDeca'),
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
                                key: ValueKey(entry.value),
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: GestureDetector(
                                    onTap: () {
                                      categoryProvider
                                          .moveToBottom(entry.value);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: gradientProvider.secondaryColor,
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 13, vertical: 7),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Broken.recovery_convert,
                                              color: snowWhite,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              child: Text(
                                                entry.value,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: snowWhite,
                                                ),
                                              ),
                                            ),
                                            const Icon(
                                              Icons.check,
                                              color: snowWhite,
                                            )
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
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      height: 1,
                      color: snowWhite,
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                      children: categoryProvider.tempBottomCategories
                          .map((key) => Container(
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: GestureDetector(
                                    onTap: () {
                                      categoryProvider.moveToTop(key);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: gradientProvider.secondaryColor,
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 13, vertical: 7),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Broken.recovery_convert,
                                              color: snowWhite,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              child: Text(
                                                key,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: snowWhite,
                                                ),
                                              ),
                                            ),
                                            const Icon(
                                              Broken.add_circle,
                                              color: snowWhite,
                                            )
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
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: gradientProvider.secondaryColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: dangerRed),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              if (categoryProvider.tempTopCategories.length <
                                  2) {
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
                        ]),
                  ),
                ],
              ),
            );
          }),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
              .animate(CurvedAnimation(parent: anim1, curve: Curves.easeOut)),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Hey,',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  'Developer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
              icon: const Icon(Broken.setting_4, color: Colors.white),
              onPressed: () => showCategoryPopup(context)),
        ],
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    return Column(
      children: categoryProvider.topCategories,
    );
  }
}
