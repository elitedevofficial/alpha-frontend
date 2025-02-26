import 'package:flutter/material.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/widgets/commonwidget/common_colors.dart';
import 'package:myapp/widgets/commonwidget/gradientBorder.dart';

class HomecatagoryWidget extends StatefulWidget {
  final String homeCatagoriesTitle;
  final IconData homeCatagoriesIcon;
  final String homeMusicTitle;
  final String homeMusicArtist;
  final String homeMusicImageUrl;
  final VoidCallback homeMusicOnTap;
  const HomecatagoryWidget({
    super.key,
    required this.homeCatagoriesTitle,
    required this.homeCatagoriesIcon,
    required this.homeMusicTitle,
    required this.homeMusicArtist,
    required this.homeMusicImageUrl,
    required this.homeMusicOnTap,
  });

  @override
  State<HomecatagoryWidget> createState() => _HomecatagoryWidgetState();
}

class _HomecatagoryWidgetState extends State<HomecatagoryWidget> {
  String _truncateText(String text, int limit) {
    if (text.length <= limit) {
      return text;
    } else {
      return '${text.substring(0, limit)}..';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GestureDetector(
            onTap: widget.homeMusicOnTap,
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  Icon(
                    widget.homeCatagoriesIcon,
                    color: snowWhite,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      widget.homeCatagoriesTitle,
                      style: const TextStyle(
                          color: snowWhite,
                          fontSize: 17,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  const Icon(
                    Broken.arrow_right_3,
                    color: snowWhite,
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 150,
          color: Colors.transparent,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Container(
                width: 115,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  gradient: containerGardient,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: GradientBoxBorder(
                      gradient: containerBorderGardient,
                      width: 1.5,
                    ),
                  ),
                  alignment: Alignment.topCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 115,
                        height: 105,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            widget.homeMusicImageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_truncateText(widget.homeMusicTitle, 13),
                                style: const TextStyle(
                                    color: snowWhite,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600)),
                            Text(_truncateText(widget.homeMusicArtist, 15),
                                style: const TextStyle(
                                    color: snowWhite,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
