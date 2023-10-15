import 'package:flutter/material.dart';

class DraggableScrollableSheetWidget extends StatelessWidget {
  final Widget? child;
  const DraggableScrollableSheetWidget({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      snap: true,
      snapSizes: const [0.25, 0.64, 1],
      initialChildSize: 0.64,
      snapAnimationDuration: const Duration(milliseconds: 200),
      builder: (context, scrollController) {
        return ListView.builder(
          controller: scrollController,
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              alignment: Alignment.topCenter,
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0),
                ),
              ),
              child: child,
            );
          },
        );
      },
    );
  }
}
