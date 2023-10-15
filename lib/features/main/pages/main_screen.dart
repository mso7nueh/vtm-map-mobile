import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:promenade/features/main/widgets/draggable_scrollable_sheet_widget.dart';
import 'package:promenade/features/main/widgets/find_suitable_branch_button_widget.dart';
import 'package:promenade/features/main/widgets/yandex_map_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isOffices = true;
  bool isFilters = false;
  bool isInfo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          YandexMapWidget(),
          const FindSuitableBranchButtonWidget(),
          !isInfo
              ? DraggableScrollableSheetWidget(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: !isFilters
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isOffices = true;
                                      });
                                    },
                                    child: SvgPicture.asset(
                                      isOffices ? 'assets/icons/office_on.svg' : 'assets/icons/office_off.svg',
                                      height: 32.0,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isOffices = false;
                                      });
                                    },
                                    child: SvgPicture.asset(
                                      isOffices ? 'assets/icons/atms_off.svg' : 'assets/icons/atms_on.svg',
                                      height: 32.0,
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isFilters = true;
                                      });
                                    },
                                    child: SvgPicture.asset(
                                      'assets/icons/options.svg',
                                      height: 32.0,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24.0),
                              isOffices
                                  ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isInfo = true;
                                        });
                                      },
                                      child: Image.network(
                                        'https://i.imgur.com/SrwSeAF.png',
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isInfo = true;
                                        });
                                      },
                                      child: Image.network(
                                        'https://i.imgur.com/SnneDX7.png',
                                      ),
                                    ),
                            ],
                          )
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                isFilters = false;
                              });
                            },
                            child: isOffices ? Image.network('https://i.imgur.com/pDwflQq.png') : Image.network('https://i.imgur.com/a0ftTkl.png'),
                          ),
                  ),
                )
              : DraggableScrollableSheetWidget(
                  child: isOffices
                      ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isInfo = false;
                              });
                            },
                            child: Image.network(
                              'https://i.imgur.com/W1XEfYI.png',
                            ),
                          ),
                      )
                      : Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isInfo = false;
                              });
                            },
                            child: Image.network(
                              'https://i.imgur.com/MbRbyYH.png',
                            ),
                          ),
                      ),
                ),
        ],
      ),
    );
  }
}
