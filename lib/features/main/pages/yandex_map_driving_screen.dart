import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promenade/common/app_colors.dart';
import 'package:promenade/features/main/blocs/map_cubit/map_cubit.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class YandexMapDrivingScreen extends StatefulWidget {
  final Future<DrivingSessionResult> result;
  final DrivingSession session;
  final PlacemarkMapObject startPlacemark;
  final PlacemarkMapObject endPlacemark;

  const YandexMapDrivingScreen({super.key, required this.result, required this.session, required this.startPlacemark, required this.endPlacemark});

  @override
  State<YandexMapDrivingScreen> createState() => _YandexMapDrivingScreenState();
}

class _YandexMapDrivingScreenState extends State<YandexMapDrivingScreen> {
  late final List<MapObject> mapObjects = [widget.startPlacemark, widget.endPlacemark];

  final List<DrivingSessionResult> results = [];
  bool _progress = true;

  List<Widget> _getList() {
    final list = <Widget>[];

    if (results.isEmpty) {
      list.add((const Text('Nothing found')));
    }

    for (var r in results) {
      list.add(Container(height: 20));

      r.routes!.asMap().forEach((i, route) {
        list.add(Text('Route $i: ${route.metadata.weight.timeWithTraffic.text}'));
      });

      list.add(Container(height: 20));
    }

    return list;
  }

  Future<void> _handleResult(DrivingSessionResult result) async {
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
      result.routes!.asMap().forEach((i, route) {
        mapObjects.add(PolylineMapObject(
          mapId: MapObjectId('route_${i}_polyline'),
          polyline: Polyline(points: route.geometry),
          strokeColor: blue,
          strokeWidth: 3,
        ));
      });
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
        onMapCreated: (controller) async {
          await controller.moveCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: widget.startPlacemark.point,
              ),
            ),
            animation: const MapAnimation(),
          );
        },
      ),
    );
  }
}
