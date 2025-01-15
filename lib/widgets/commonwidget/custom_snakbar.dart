import 'package:flutter/material.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';

class SlidingSnackbar {
  final BuildContext context;
  final String message;
  final bool isSuccess;

  SlidingSnackbar({
    required this.context,
    required this.message,
    required this.isSuccess,
  });

  void show() {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;
    final AnimationController animationController = AnimationController(
      vsync: Navigator.of(context),
      duration: const Duration(milliseconds: 300),
    );

    final animation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 20,
        left: 20,
        right: 20,
        child: SlideTransition(
          position: animation,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: isSuccess
                    ? LinearGradient(
                        colors: [
                          const Color(0xFF101435).withOpacity(0.5),
                          const Color(0xFF101435).withOpacity(0.5),
                        ],
                      )
                    :  LinearGradient(
                        colors: [
                          const Color(0xFF101435).withOpacity(0.5),
                          const Color(0xFF101435).withOpacity(0.5),
                        ],
                      ),
                border: Border.all(
                  color: isSuccess ? Colors.green : Colors.red, 
                  width: 2, 
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      message,
                      style: TextStyle(
                        color: isSuccess ? Colors.green : Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Icon(
                    isSuccess ? Broken.tick_square : Broken.warning_2,
                    color: isSuccess ? Colors.green : Colors.red,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);


    animationController.forward();

    Future.delayed(const Duration(seconds: 3), () {
      animationController.reverse().then((_) {
        overlayEntry.remove();
        animationController.dispose();
      });
    });
  }
}
