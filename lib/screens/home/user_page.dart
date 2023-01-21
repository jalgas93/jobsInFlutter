import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_jobs/screens/tabbar_bloc/tabbar-state.dart';
import 'package:flutter_jobs/screens/tabbar_bloc/tabbar_bloc.dart';
import 'package:flutter_jobs/screens/tabbar_bloc/tabbar_event.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import '../../widgets/theme.dart';
import '../openstreet/example.dart';

class UserPage extends StatefulWidget {
  const UserPage(
      {Key? key,
      required this.page,
      this.uid,
      required this.latit,
      required this.long})
      : super(key: key);
  final int page;
  final String? uid;
  final double latit;
  final double long;

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  PageController? _controller = PageController();
  int _pageIndex = 0;
  MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    _controller = PageController(initialPage: widget.page);
    _pageIndex = widget.page;
    print('pageWidget:${widget.page}');

    _mapController = MapController();
    _mapController.mapEventStream.listen((event) async {
      if (event is MapEventMoveEnd) {
        var client = http.Client();
        String url =
            'https://nominatim.openstreetmap.org/reverse?format=json&lat=${event.center.latitude}&lon=${event.center.longitude}&zoom=18&addressdetails=1';

        var response = await client.post(Uri.parse(url));
        var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes))
            as Map<dynamic, dynamic>;
        _searchController.text = decodedResponse['display_name'];
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return BlocConsumer<TabbarBloc, TabbarState>(
      bloc: context.watch<TabbarBloc>(),
      listener: (context, state) {

        if (state is LoadingState) {
          Text('jalgas ochnis LoadingState');
        } if (state is SendState) {
          Text('jalgas  SendState');
        }

        // if (state is LoadingState) {
        //   CircularProgressIndicator();
        //   print('listener:${state}');
        //   // _controller!.animateToPage(0,
        //   //     duration: Duration(milliseconds: 200), curve: Curves.ease);
        //   setState(() {
        //     _pageIndex = 3;
        //   });
        // } else
          if (state is SendState) {
            print('listener:${state}');

          // _controller!.animateToPage(1,
          //     duration: Duration(milliseconds: 200), curve: Curves.ease);
          // setState(() {
          //   _pageIndex = 4;
          // });
        }
        //   else if (state is AcceptState) {
        //     print('listener:${state}');
        //   // _controller!.animateToPage(2,
        //   //     duration: Duration(milliseconds: 200), curve: Curves.ease);
        //   setState(() {
        //     _pageIndex = 3;
        //   });
        // }
      },
      builder: (context, state) {
        print('build:${state}');
        return Stack(
          children: [
            Container(
              height: screenSize.height,
              width: screenSize.width,
              child: PageView(
                controller: _controller,
                onPageChanged: onPageChanged,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  OpenStreetMapExample(
                    buttonColor: Colors.blueAccent,
                    center: LatLng(widget.latit, widget.long),
                  ),
                  // _buildUserPanel(state, context)
                ],
              ),
            ),
        _buildUserPanel(state, context)
            //_buildMap(state, context)
          ],
        );
      },
    );
  }

  Positioned _buildMap(TabbarState state, BuildContext context) {
    return Positioned(
        child: Stack(
      children: [
        Positioned(
            top: 0,
            bottom: 160,
            right: 0,
            left: 0,
            child: FlutterMap(
              options: MapOptions(
                  center: LatLng(
                      //  widget.center.latitude, widget.center.longitude),
                      widget.latit,
                      widget.long),
                  zoom: 17.0,
                  maxZoom: 20,
                  minZoom: 6),
              // mapController: _mapController,
              layers: [
                TileLayerOptions(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                  // attributionBuilder: (_) {
                  //   return Text("© OpenStreetMap contributors");
                  // },
                ),
              ],
            )),
        Positioned(
            //top: MediaQuery.of(context).size.height * 0.5,
            left: 0,
            right: 0,
            bottom: 200,
            top: 0,
            child: IgnorePointer(
              child: Center(
                child: StatefulBuilder(builder: (context, setState) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      border: Border.all(
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _searchController.text,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }),
              ),
            )),
        Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: IgnorePointer(
              child: Center(
                child: Image.asset('assets/images/pin.png',
                    height: 200,
                    scale: 3,
                    opacity: const AlwaysStoppedAnimation<double>(1)),
              ),
            )),
        // Positioned(
        //     bottom: 260,
        //     right: 5,
        //     child: FloatingActionButton(
        //       heroTag: 'button_current_location',
        //       backgroundColor: Colors.white,
        //       onPressed: () {
        //         getCurrentLocation2().then((value) {
        //           lang = double.parse('${value.longitude}');
        //           latit = double.parse('${value.latitude}');
        //           setState(() {
        //             locationMessage = 'longitude:$lang, latitude:$latit';
        //             _mapController.move(
        //                 LatLng(latit, lang), _mapController.zoom);
        //
        //             _mapController.mapEventStream.listen((event) async {
        //               if (event is MapEventMoveEnd) {
        //                 var client = http.Client();
        //                 String url =
        //                     'https://nominatim.openstreetmap.org/reverse?format=json&lat=${latit}&lon=${lang}&zoom=18&addressdetails=1';
        //
        //                 var response = await client.post(Uri.parse(url));
        //                 var decodedResponse =
        //                 jsonDecode(utf8.decode(response.bodyBytes))
        //                 as Map<dynamic, dynamic>;
        //
        //                 _searchController.text =
        //                 decodedResponse['display_name'];
        //
        //                 setState(() {});
        //               }
        //             });
        //           });
        //           print('jalgas' + locationMessage);
        //         });
        //
        //         pickData().then((value) {
        //           var a = value.address;
        //           setState(() {
        //             _searchController.text = a;
        //             print('jalgassss:${a}');
        //           });
        //         });
        //       },
        //       child: Icon(
        //         Icons.my_location,
        //         color: Colors.black,
        //       ),
        //     )),
        // Positioned(
        //     top: 10,
        //     left: 5,
        //     child: FloatingActionButton(
        //       backgroundColor: Colors.white,
        //       onPressed: () {
        //         _key.currentState!.openDrawer();
        //       },
        //       child: Icon(
        //         Icons.menu,
        //         color: Colors.black,
        //       ),
        //     )),
        // Positioned(
        //   right: 0,
        //   left: 0,
        //   top: 500,
        //   bottom: 0,
        //   child: Padding(
        //     padding: EdgeInsets.all(0.01),
        //     child: Container(
        //         decoration: BoxDecoration(
        //           color: Colors.white,
        //           // image: const DecorationImage(
        //           //   image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
        //           //   fit: BoxFit.cover,
        //           // ),
        //           //   border: Border.all(
        //           //     width: 1,
        //           //   ),
        //           //   borderRadius: BorderRadius.circular(8),
        //         ),
        //         child: Column(
        //           children: [
        //             DefaultTabController(
        //                 length: 3,
        //                 child: Column(
        //                   children: [
        //                     TabBar(
        //                         indicatorColor: Color(0xFFFE8C68),
        //                         unselectedLabelColor: Color(0xFF555555),
        //                         labelColor: Color(0xFFFE8C68),
        //                         labelPadding:
        //                         EdgeInsets.symmetric(horizontal: 5.0),
        //                         tabs: [
        //                           Tab(
        //                             text: 'Такси',
        //                           ),
        //                           Tab(
        //                             text: 'Доставка',
        //                           ),
        //                           Tab(
        //                             text: 'Семейное поездки',
        //                           ),
        //                         ]),
        //                     SizedBox(
        //                       height: 5,
        //                     ),
        //                     Container(
        //                       height: 150.0,
        //                       child: TabBarView(
        //
        //                         children: [
        //                           Container(
        //                             child: ListView(
        //                               scrollDirection: Axis.horizontal,
        //                               children: [
        //                                 ServicesCard(urls[0], 'Эконом', '',
        //                                   5, context,),
        //                                 ServicesCard(urls[0], 'Эконом', 'jjjj',
        //                                     5, context),
        //                                 ServicesCard(urls[2], 'Люкс', '', 3,
        //                                     context),
        //                                 ServicesCard(urls[2], 'Комфорт', '',
        //                                     6, context),
        //                               ],
        //                             ),
        //                           ),
        //                           Container(
        //                             child: ListView(
        //                               scrollDirection: Axis.horizontal,
        //                               children: [
        //                                 ServicesCard(
        //                                     urls[4],
        //                                     'Быстрая доставка',
        //                                     '',
        //                                     3,
        //                                     context),
        //                                 ServicesCard(urls[5], 'Доставка',
        //                                     '', 2, context),
        //                                 ServicesCard(urls[6], 'Доставка',
        //                                     '', 1, context),
        //                               ],
        //                             ),
        //                           ),
        //                           Container(
        //                             child: ListView(
        //                               scrollDirection: Axis.horizontal,
        //                               children: [
        //                                 ServicesCard(urls[7], 'На отдых',
        //                                     '', 5, context),
        //                                 ServicesCard(urls[8], 'Мероприятия',
        //                                     '', 3, context),
        //                                 ServicesCard(urls[9], 'Путешествия',
        //                                     '', 6, context),
        //                               ],
        //                             ),
        //                           )
        //                         ],
        //                       ),
        //                     ),
        //                   ],
        //                 ))
        //           ],
        //         )),
        //   ),
        // ),
      ],
    ));
  }

  Positioned _buildUserPanel(TabbarState state, BuildContext context) {
    return Positioned(
        bottom: 0,
        right: 0,
        left: 0,
        top: 600,
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Container(
            // height: 250,
            // width: MediaQuery.of(context).size.width,
            // decoration: BoxDecoration(
            //   border: Border.all(
            //     width: 8,
            //   ),
            //   borderRadius: BorderRadius.only(
            //     topRight: Radius.circular(10),
            //     topLeft: Radius.circular(10),
            //   ),
            // ),
            child: Column(
              children: [
                // Expanded(
                //   child: TextField(
                //     keyboardType: TextInputType.text,
                //     decoration: InputDecoration(
                //       border: InputBorder.none,
                //       hintText: "Удачного вам поездки!",
                //     ),
                //   ),
                // ),
                // Expanded(
                //   child: TextField(
                //     keyboardType: TextInputType.text,
                //     decoration: InputDecoration(
                //       border: InputBorder.none,
                //       hintText: "Укажите куда на карте ?",
                //     ),
                //   ),
                // ),
                // Divider(
                //   color: Colors.blue,
                //   height: 10,
                //   thickness: 0,
                //   indent: 10,
                //   endIndent: 0,
                // ),
                FloatingActionButton(
                   backgroundColor: state is LoadingState ? Colors.grey[300] : CityTheme.cityblue,
                   child: Icon(_pageIndex == 0
                       ? Icons.check_rounded
                       : Icons.arrow_forward_ios),
                  onPressed:  () {
                          if (state is LoadingState && _pageIndex == 0) {

                            setState(() {
                              _pageIndex = 1;
                              print('pageIndex1:1 ,${_pageIndex}');
                            });
                          } else if (state is SendState || _pageIndex == 1) {
                            BlocProvider.of<TabbarBloc>(context).add(
                              SendEvent(
                                'jalgas',
                                'Amanbaev 67a',
                                '998973486575',
                                state is SendState ? state.uid : widget.uid,
                              ),
                            );

                            setState(() {
                              _pageIndex = 2;
                            });
                          }
                            else if (state is AcceptState || _pageIndex == 2) {
                            BlocProvider.of<TabbarBloc>(context).add(
                              AsseptEvent(
                                state is AcceptState ? state.uid : widget.uid,
                                'Nurlan',
                                'Oqtuvchilar',
                                'Neksia',
                                'beliy',
                                '95 H037HA',
                                '998999559565',
                                10,
                                15000,
                              ),
                            );
                          }
                            else if (state is ErrorState) {
                            Text(
                              'Произашло ошибка',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            );
                          }
                        },
                )
              ],
            ),
          ),
        ));
  }

  void onPageChanged(int value) {
    print('Я здесь');
    print('page:${value}');
    setState(() {
      _pageIndex = value;
    });
  }
}
