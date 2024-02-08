import 'package:animated_bottom_nav_bar/models/nav_item_model.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<SMIBool> riveIconInputs = [];
  List<StateMachineController?> controllers = [];
  int selectedIndex = 0;

  @override
  void dispose() {
    for(var controller in controllers){
      controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 70,
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.3),
              offset: const Offset(0, 20),
              blurRadius: 20,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(bottomNavItems.length, (index) {
            final riveIcon = bottomNavItems[index].rive;
            return GestureDetector(
              onTap: () {
                riveIconInputs[index].change(true);
                Future.delayed(const Duration(seconds: 1), () {
                  riveIconInputs[index].change(false);
                });
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedBar(isActive: selectedIndex == index,),
                  SizedBox(
                    height: 36,
                    width: 36,
                    child: Opacity(
                      opacity: selectedIndex == index ? 1 : 0.5,
                      child: RiveAnimation.asset(
                        riveIcon.src,
                        artboard: bottomNavItems[index].rive.artboard,
                        onInit: (artboard) {
                          StateMachineController? controller =
                              StateMachineController.fromArtboard(
                                  artboard, riveIcon.stateMachineName);
                          artboard.addController(controller!);
                          controllers.add(controller);
                          riveIconInputs.add(
                              controller.findInput<bool>('active') as SMIBool);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

class AnimatedBar extends StatelessWidget {
  const AnimatedBar({
    super.key, required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 200,
      ),
      margin: const EdgeInsets.only(bottom: 2),
      height: 4,
      width: isActive? 20 : 0,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
