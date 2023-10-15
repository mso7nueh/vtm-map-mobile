import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class YandexMapWidget extends StatefulWidget {
  const YandexMapWidget({super.key});

  @override
  State<YandexMapWidget> createState() => _YandexMapWidgetState();
}

class _YandexMapWidgetState extends State<YandexMapWidget> {
  GlobalKey mapKey = GlobalKey();
  late YandexMapController controller;
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
    return YandexMap(
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
            setState(() {});
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
    );
  }
}
