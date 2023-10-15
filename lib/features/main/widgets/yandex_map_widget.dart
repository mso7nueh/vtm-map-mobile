import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:promenade/features/main/blocs/map_cubit/map_cubit.dart';
import 'package:promenade/features/main/blocs/map_cubit/map_state.dart';
import 'package:promenade/features/main/pages/yandex_map_driving_screen.dart';
import 'package:promenade/features/main/pages/yandex_map_pedestrian_screen.dart';
import 'package:promenade/locator_service.dart';
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

  late final List<PlacemarkMapObject> mapObjects = [
    PlacemarkMapObject(
      mapId: const MapObjectId('ул. Покровка, 28, стр. 1'),
      point: const Point(latitude: 55.760429, longitude: 37.650028),
      opacity: 1,
      icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage('assets/images/vtb.png'),
          scale: 0.6,
        ),
      ),
    ),
  ];

  late Point userGeoPosition;
  final List<DrivingSessionResult> results = [];

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

  Future<DrivingResultWithSession> getDrivingTime(Point point) async {
    var resultWithSession = YandexDriving.requestRoutes(
      points: [
        RequestPoint(point: Point(latitude: userGeoPosition.latitude, longitude: userGeoPosition.longitude), requestPointType: RequestPointType.wayPoint),
        RequestPoint(point: Point(latitude: point.latitude, longitude: point.longitude), requestPointType: RequestPointType.wayPoint),
      ],
      drivingOptions: const DrivingOptions(initialAzimuth: 0, routesCount: 1, avoidTolls: true),
    );
    return resultWithSession;
  }

  Future<PedestrianResultWithSession> getTimePedestrian(Point point) async {
    var resultWithSession = YandexPedestrian.requestRoutes(
      points: [
        RequestPoint(point: Point(latitude: userGeoPosition.latitude, longitude: userGeoPosition.longitude), requestPointType: RequestPointType.wayPoint),
        RequestPoint(point: Point(latitude: point.latitude, longitude: point.longitude), requestPointType: RequestPointType.wayPoint),
      ],
    );
    return resultWithSession;
  }

  goToPedestrianScreen() async {
    final resultWithSession = await getTimePedestrian(mapObjects[0].point);
    await Future.delayed(
      Duration.zero,
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => YandexMapPedestrianScreen(
            session: resultWithSession.session,
            result: resultWithSession.result,
            startPlacemark: PlacemarkMapObject(
              mapId: const MapObjectId('me'),
              point: userGeoPosition,
              icon: PlacemarkIcon.single(
                PlacemarkIconStyle(
                  image: BitmapDescriptor.fromAssetImage('assets/images/me.png'),
                  scale: 0.6,
                ),
              ),
              opacity: 1,
            ),
            endPlacemark: mapObjects[0],
          ),
        ),
      ),
    );
  }

  goToDrivingScreen() async {
    final resultWithSession = await getDrivingTime(mapObjects[0].point);
    await Future.delayed(
      Duration.zero,
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => YandexMapDrivingScreen(
            session: resultWithSession.session,
            result: resultWithSession.result,
            startPlacemark: PlacemarkMapObject(
              mapId: const MapObjectId('me'),
              point: userGeoPosition,
              icon: PlacemarkIcon.single(
                PlacemarkIconStyle(
                  image: BitmapDescriptor.fromAssetImage('assets/images/me.png'),
                  scale: 0.6,
                ),
              ),
              opacity: 1,
            ),
            endPlacemark: mapObjects[0],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapCubit, MapState>(
      builder: (context, state) {
        if (state is MapStateBuildRoute) {
          if (state.isPedestrian) {
            Future.delayed(Duration.zero, () => goToPedestrianScreen());
          } else {
            goToDrivingScreen();
          }
        }
        return YandexMap(
          key: mapKey,
          mapObjects: mapObjects,
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
              userGeoPosition = geoPosition.target;
              await controller.moveCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: geoPosition.target,
                    zoom: 14,
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
      },
    );
  }
}
