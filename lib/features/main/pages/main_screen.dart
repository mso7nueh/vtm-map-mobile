import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GlobalKey mapKey = GlobalKey();
  late YandexMapController controller;

  Future<bool> get locationPermissionNotGranted async => !(await Permission.location.request().isGranted);

  void _showMessage(Text text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: YandexMap(
        key: mapKey,
        onMapCreated: (YandexMapController yandexMapController) async {
          controller = yandexMapController;
          if (await locationPermissionNotGranted) {
            _showMessage(const Text('Нет доступа к геопозиции'));
            return;
          }
          final mediaQuery = await Future.delayed(Duration.zero, () => MediaQuery.of(context));
          final height = mapKey.currentContext!.size!.height * mediaQuery.devicePixelRatio;
          final width = mapKey.currentContext!.size!.width * mediaQuery.devicePixelRatio;
          await controller.toggleUserLayer(
            visible: true,
            autoZoomEnabled: true,
            anchor: UserLocationAnchor(
              course: Offset(0.5 * width, 0.5 * height),
              normal: Offset(0.5 * width, 0.5 * height),
            ),
          );
        },
        onMapTap: (point) {
          showModalBottomSheet<void>(
            barrierColor: Colors.transparent,
            isScrollControlled: true,
            context: context,
            isDismissible: false,
            backgroundColor: Colors.white,
            showDragHandle: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(24.0),
                topLeft: Radius.circular(24.0),
              ),
            ),
            elevation: 8.0,
            builder: (BuildContext context) {
              return Container(
                height: 10,
              );
            },
          );
        },
      ),
    );
  }
}
