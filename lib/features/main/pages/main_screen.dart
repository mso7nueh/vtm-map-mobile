import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:promenade/features/main/widgets/find_suitable_branch_button_widget.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GlobalKey mapKey = GlobalKey();
  late YandexMapController controller;

  Future<bool> get locationPermissionGranted async => (await Permission.location.request().isGranted);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          YandexMap(
            key: mapKey,
            mapObjects: [
              PlacemarkMapObject(
                mapId: const MapObjectId('vtb'),
                point: const Point(latitude: 55.760428, longitude: 37.650028),
                opacity: 1,
                icon: PlacemarkIcon.single(
                  PlacemarkIconStyle(
                    image: BitmapDescriptor.fromAssetImage('assets/images/vtb.png'),
                    scale: 0.6,
                  ),
                ),
                onTap: (placeMarkObject, point) {},
              ),
            ],
            onMapCreated: (YandexMapController yandexMapController) async {
              controller = yandexMapController;
              if (await locationPermissionGranted) {
                await controller.toggleUserLayer(visible: true);
              }
            },
            onUserLocationAdded: (UserLocationView view) async {
              CameraPosition? geoPosition = await controller.getUserCameraPosition();
              if (geoPosition != null) {
                await controller.moveCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: geoPosition.target,
                    ),
                  ),
                  animation: const MapAnimation(),
                );
              }
              return view.copyWith(
                arrow: view.arrow.copyWith(
                  icon: PlacemarkIcon.single(
                    PlacemarkIconStyle(
                      image: BitmapDescriptor.fromAssetImage('assets/images/me.png'),
                      scale: 0.6,
                    ),
                  ),
                ),
              );
            },
          ),
          const FindSuitableBranchButtonWidget(),
          DraggableScrollableSheet(
            snap: true,
            snapSizes: const [0.25, 0.5, 0.9],
            snapAnimationDuration: const Duration(milliseconds: 200),
            builder: (context, scrollController) {
              return ListView.builder(
                controller: scrollController,
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 5000,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0))),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
