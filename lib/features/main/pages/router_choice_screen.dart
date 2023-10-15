import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:promenade/features/main/blocs/map_cubit/map_cubit.dart';
import 'package:promenade/features/main/pages/main_screen.dart';
import 'package:promenade/features/main/widgets/draggable_scrollable_sheet_widget.dart';
import 'package:promenade/features/main/widgets/yandex_map_widget.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class RouterChoiceScreen extends StatefulWidget {
  const RouterChoiceScreen({super.key});

  @override
  State<RouterChoiceScreen> createState() => _RouterChoiceScreenState();
}

class _RouterChoiceScreenState extends State<RouterChoiceScreen> {
  bool isPedestrian = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 128,
        leadingWidth: 40.0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 64.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen()));
            },
            child: SvgPicture.asset(
              'assets/icons/back_button.svg',
            ),
          ),
        ),
        titleSpacing: 0,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'assets/icons/7701.svg',
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isPedestrian = true;
                      });
                    },
                    child: SvgPicture.asset(
                      isPedestrian ? 'assets/icons/walk_on.svg' : 'assets/icons/walk_off.svg',
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isPedestrian = false;
                      });
                    },
                    child: SvgPicture.asset(
                      isPedestrian ? 'assets/icons/car_off.svg' : 'assets/icons/car_on.svg',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          YandexMapWidget(),
          DraggableScrollableSheetWidget(
            child: GestureDetector(
              onTap: () {
                context.read<MapCubit>().buildRoute(isPedestrian);
              },
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: isPedestrian ? Image.network('https://i.imgur.com/sHnBJzh.png') : Image.network('https://i.imgur.com/PJOv0ac.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
