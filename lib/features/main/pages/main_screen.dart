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
  String text = '';
  int level = 0;
  Color trafficColor = Colors.white;

  Future<bool> get locationPermissionGranted async => (await Permission.location.request().isGranted);

  Color _colorFromTraffic(TrafficColor trafficColor) {
    switch (trafficColor) {
      case TrafficColor.red:
        return Colors.red;
      case TrafficColor.yellow:
        return Colors.yellow;
      case TrafficColor.green:
        return Colors.green;
      default:
        return Colors.white;
    }
  }

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
                mapId: const MapObjectId('ул. Покровка, 28, стр. 1'),
                point: const Point(latitude: 55.760428, longitude: 37.650028),
                opacity: 1,
                icon: PlacemarkIcon.single(
                  PlacemarkIconStyle(
                    image: BitmapDescriptor.fromAssetImage('assets/images/vtb.png'),
                    scale: 0.6,
                  ),
                ),
                onTap: (placeMarkObject, point) {
                  setState(() {
                    text = placeMarkObject.mapId.toString();
                  });
                },
              ),
            ],
            onMapCreated: (YandexMapController yandexMapController) async {
              controller = yandexMapController;
              await controller.toggleTrafficLayer(visible: true);
              if (await locationPermissionGranted) {
                await controller.toggleUserLayer(visible: true);
              }
            },
            onTrafficChanged: (TrafficLevel? trafficLevel) {
              setState(() {
                level = trafficLevel?.level ?? 0;
                trafficColor = trafficLevel != null ? _colorFromTraffic(trafficLevel.color) : Colors.white;
              });
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
                  opacity: 1,
                ),
                pin: view.pin.copyWith(
                  icon: PlacemarkIcon.single(
                    PlacemarkIconStyle(
                      image: BitmapDescriptor.fromAssetImage('assets/images/me.png'),
                      scale: 0.6,
                    ),
                  ),
                  opacity: 1,
                ),
              );
            },
          ),
          const FindSuitableBranchButtonWidget(),
          DraggableScrollableSheet(
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
                    child: Text(text),
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
