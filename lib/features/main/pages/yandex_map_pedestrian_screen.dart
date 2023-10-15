import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:promenade/common/app_colors.dart';
import 'package:promenade/features/main/blocs/map_cubit/map_cubit.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class YandexMapPedestrianScreen extends StatefulWidget {
  final Future<PedestrianSessionResult> result;
  final PedestrianSession session;
  final PlacemarkMapObject startPlacemark;
  final PlacemarkMapObject endPlacemark;

  const YandexMapPedestrianScreen({super.key, required this.result, required this.session, required this.startPlacemark, required this.endPlacemark});

  @override
  State<YandexMapPedestrianScreen> createState() => _YandexMapPedestrianScreenState();
}

class _YandexMapPedestrianScreenState extends State<YandexMapPedestrianScreen> {
  late final List<MapObject> mapObjects = [widget.endPlacemark];
  Future<bool> get locationPermissionGranted async => (await Permission.location.request().isGranted);
  final List<PedestrianSessionResult> results = [];
  bool _progress = true;
  late YandexMapController controller;
  late Point userGeoPosition;

  List<Widget> _getList() {
    final list = <Widget>[];

    if (results.isEmpty) {
      list.add((const Text('Nothing found')));
    }

    for (var r in results) {
      list.add(Container(height: 20));

      r.routes!.asMap().forEach((i, route) {
        list.add(Text('Route $i: ${route.metadata.weight.time.text}'));
      });

      list.add(Container(height: 20));
    }
    return list;
  }

  Future<void> _handleResult(PedestrianSessionResult result) async {
    setState(() {
      _progress = false;
    });

    if (result.error != null) {
      print('Error: ${result.error}');
      return;
    }

    setState(() {
      results.add(result);
    });
    setState(() {
      mapObjects.add(PolylineMapObject(
        mapId: const MapObjectId('route_0_polyline'),
        polyline: Polyline(points: result.routes!.first.geometry),
        strokeColor: purple,
        strokeWidth: 3,
      ));
    });
  }

  Future<void> _cancel() async {
    await widget.session.cancel();

    setState(() {
      _progress = false;
    });
  }

  Future<void> _close() async {
    await widget.session.close();
  }

  Future<void> _init() async {
    await _handleResult(await widget.result);
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    _close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: YandexMap(
        mapMode: MapMode.driving,
        mapObjects: mapObjects,
        onMapCreated: (yandexMapController) async {
          controller = yandexMapController;
          await controller.toggleTrafficLayer(visible: true);
          if (await locationPermissionGranted) {
            await controller.toggleUserLayer(visible: true);
          }
          await controller.moveCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: widget.startPlacemark.point,
                zoom: 18,
              ),
            ),
            animation: const MapAnimation(),
          );
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
      ),
    );
  }
}
