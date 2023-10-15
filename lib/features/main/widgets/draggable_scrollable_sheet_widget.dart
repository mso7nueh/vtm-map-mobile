import 'package:flutter/material.dart';

class DraggableScrollableSheetWidget extends StatelessWidget {
  const DraggableScrollableSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      snap: true,
      snapSizes: const [0.25, 0.5, 1],
      snapAnimationDuration: const Duration(milliseconds: 200),
      builder: (context, scrollController) {
        return ListView.builder(
          controller: scrollController,
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
