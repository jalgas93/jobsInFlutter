import 'package:flutter/material.dart';
import 'package:flutter_jobs/screens/tabbar_bloc/tabbar-state.dart';
import 'package:flutter_jobs/screens/tabbar_bloc/tabbar_event.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import '../auth/auth_bloc/auth_bloc.dart';
import '../openstreet/example.dart';
import '../tabbar_bloc/tabbar_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderTaxi extends StatefulWidget {
  const OrderTaxi(
      {Key? key,
      required this.page,
      this.uid,
      required this.latit,
      required this.long, required this.firstname, required this.phone})
      : super(key: key);
  final int page;
  final String? uid;
  final String firstname;

  final String phone;
  final double latit;
  final double long;

  @override
  _OrderTaxiState createState() => _OrderTaxiState();
}

class _OrderTaxiState extends State<OrderTaxi> {
  @override
  void setState(VoidCallback fn) {
    _controller = PageController(initialPage: widget.page);
    _pageIndex = 0;
    print('pageWidget:${widget.page}');
    // TODO: implement setState
    super.setState(fn);
  }

  PageController? _controller = PageController();
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return BlocProvider(
      create: (_) => TabbarBloc()..add(LoadingEvent()),
      child: Scaffold(
        body: _OrderTaxi(context),
      ),
    );
  }

  Widget _OrderTaxi(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return BlocConsumer<TabbarBloc, TabbarState>(
        listener: (context, state) {
          if (state is SendState) {
            print('listener:${state}');
          }
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
                  // GeolocatorWidget(locationMessage: '',),
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

  Positioned _buildMap() {
    return Positioned(
        child: Stack(
      children: [
        Positioned(
            top: 0,
            bottom: 0,
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
                      'sdfa',
                      //  _searchController.text,
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
          ),
        ),
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
            height: 250,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.deepPurpleAccent,
                width: 2,
              ),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Удачного вам поездки!",
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Укажите куда на карте ?",
                    ),
                  ),
                ),
                Divider(
                  color: Colors.red,
                  height: 30,
                  thickness: 2,
                  indent: 20,
                  endIndent: 0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.green,
                        width: 0.5,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.green,
                  ),
                  child: TextButton(
                    onPressed: () {
                      print('click:');
                      BlocProvider.of<TabbarBloc>(context).add(
                        SendEvent(
                          widget.firstname,
                          'Amanbaev 67a',
                          widget.phone,
                          state is SendState ? state.uid : widget.uid,
                        ),
                      );
                      if (state is LoadingState) {
                        CircularProgressIndicator();
                        setState(() {
                          _pageIndex = 1;
                          print('pageIndex1:1 ,${_pageIndex}');
                        });
                      } else if (state is SendState || _pageIndex == 1) {
                        BlocProvider.of<TabbarBloc>(context).add(
                          SendEvent(
                            widget.firstname,
                            'dsaf',
                            widget.phone,
                            state is SendState ? state.uid : widget.uid,
                          ),
                        );

                        setState(() {
                          _pageIndex = 2;
                        });
                      } else if (state is AcceptState || _pageIndex == 2) {
                        BlocProvider.of<TabbarBloc>(context).add(
                          AsseptEvent(
                            state is AcceptState ? state.uid : widget.uid,
                            widget.firstname,
                            'asdfa',
                            'Neksia',
                            'beliy',
                            '95 H037HA',
                            '998999559565',
                            10,
                            15000,
                          ),
                        );
                      } else if (state is ErrorState) {
                        Text(
                          'Произашло ошибка',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        );
                      }
                    },
                    child: Text(
                      "Заказать",
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          backgroundColor: Colors.green),
                    ),
                  ),
                ),
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
