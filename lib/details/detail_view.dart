import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/response_model.dart';
import '../widgets/bottom_info_sheet.dart';
import '../widgets/copy_link.dart';
import '../widgets/expandeable_group.dart';
import '../widgets/star_display.dart';

class MovieDetailScreenWidget extends StatelessWidget {
  final Result series;

  const MovieDetailScreenWidget({super.key, required this.series});

  @override
  Widget build(BuildContext context) {
    var nextInt = Random().nextInt(5);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                '${series.thumbnail.path}.${series.thumbnail.extension}'),
            fit: BoxFit.cover,
            alignment: Alignment.topLeft,
          ),
        ),
        child: Container(
          color: Colors.black.withOpacity(.5),
          child: Stack(
            children: [
              Stack(
                children: [
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CreateIcons(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(
                              CupertinoIcons.back,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              BottomInfoSheet(
                backdrops:
                    '${series.thumbnail.path}.${series.thumbnail.extension}',
                child: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: kElevationToShadow[8],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                  '${series.thumbnail.path}.${series.thumbnail.extension}'),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: series.title,
                                        style: heading.copyWith(
                                            fontSize: 22, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  series.type,
                                  style:
                                      normalText.copyWith(color: Colors.white),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    IconTheme(
                                      data: const IconThemeData(
                                        color: Colors.amber,
                                        size: 20,
                                      ),
                                      child: StarDisplay(
                                        value: (nextInt).round(),
                                      ),
                                    ),
                                    Text(
                                      "  ${nextInt.round()} / 5",
                                      style: normalText.copyWith(
                                        color: Colors.amber,
                                        letterSpacing: 1.2,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 5),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  if (series.description.runtimeType == String)
                    ExpandableGroup(
                      isExpanded: true,
                      expandedIcon: Icon(
                        Icons.arrow_drop_up,
                        color: Colors.white != Colors.white
                            ? Colors.black
                            : Colors.white,
                      ),
                      collapsedIcon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white != Colors.white
                            ? Colors.black
                            : Colors.white,
                      ),
                      header: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Text(
                          "Overview",
                          style: heading.copyWith(color: Colors.white),
                        ),
                      ),
                      items: [
                        ListTile(
                            subtitle: Text(
                          series.description,
                          style: normalText.copyWith(color: Colors.white),
                        )),
                      ],
                    ),
                  ExpandableGroup(
                    isExpanded: true,
                    expandedIcon: Icon(
                      Icons.arrow_drop_up,
                      color: Colors.white != Colors.white
                          ? Colors.black
                          : Colors.white,
                    ),
                    collapsedIcon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white != Colors.white
                          ? Colors.black
                          : Colors.white,
                    ),
                    header: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: Text(
                        "About Movie",
                        style: heading.copyWith(color: Colors.white),
                      ),
                    ),
                    items: [
                      ListTile(
                          title: Text(
                            "Writers",
                            style: heading.copyWith(
                                color: Colors.white, fontSize: 16),
                          ),
                          subtitle: Text(
                            series.creators.items[0].name,
                            style: normalText.copyWith(color: Colors.white),
                          )),
                      ListTile(
                          title: Text(
                            "Director",
                            style: heading.copyWith(
                                color: Colors.white, fontSize: 16),
                          ),
                          subtitle: Text(
                            series.creators.items[0].name,
                            style: normalText.copyWith(color: Colors.white),
                          )),
                      ListTile(
                          title: Text(
                            "Released on/Releasing on",
                            style: heading.copyWith(
                                color: Colors.white, fontSize: 16),
                          ),
                          subtitle: Text(
                            series.startYear.toString(),
                            style: normalText.copyWith(color: Colors.white),
                          )),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: ExpandableGroup(
                      isExpanded: false,
                      expandedIcon: Icon(
                        Icons.arrow_drop_up,
                        color: Colors.white != Colors.white
                            ? Colors.black
                            : Colors.white,
                      ),
                      collapsedIcon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white != Colors.white
                            ? Colors.black
                            : Colors.white,
                      ),
                      header: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Text(
                          "Movie on Boxoffice",
                          style: heading.copyWith(color: Colors.white),
                        ),
                      ),
                      items: [
                        ListTile(
                            title: Text(
                              "Rated",
                              style: heading.copyWith(
                                  color: Colors.white, fontSize: 16),
                            ),
                            subtitle: Text(
                              series.rating,
                              style: normalText.copyWith(color: Colors.white),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateIcons extends StatelessWidget {
  final Widget child;
  final Function()? onTap;
  const CreateIcons({
    Key? key,
    required this.child,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: kElevationToShadow[2],
      ),
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 50),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withOpacity(.5),
            ),
            child: InkWell(onTap: onTap, child: child),
          ),
        ),
      ),
    );
  }
}
