import 'dart:convert';
import 'package:flutter_jobs/screens/auth/auth_bloc/auth_bloc.dart';
import 'package:flutter_jobs/screens/auth/auth_bloc/auth_state.dart';
import 'package:flutter_jobs/screens/home/order_taxi.dart';
import 'package:flutter_jobs/screens/tabbar_bloc/tabbar-state.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import '../openstreet/example.dart';

class UserPage extends StatefulWidget {
  const UserPage(
      {Key? key,
      required this.page,
      this.uid,
      required this.latit,
      required this.long,
      required this.firstname,
      required this.phone})
      : super(key: key);
  final int page;
  final String? uid;
  final String firstname;

  //final String address;
  final String phone;
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
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: context.watch<AuthBloc>(),
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
                  OpenStreetMapExample(
                    buttonColor: Colors.blueAccent,
                    center: LatLng(widget.latit, widget.long),
                  ),
                ],
              ),
            ),
            _buildUserPanel(state, context)
          ],
        );
      },
    );
  }

  Positioned _buildMap(AuthState state, BuildContext context) {
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
          ),
        ),
      ],
    ));
  }

  Positioned _buildUserPanel(AuthState state, BuildContext context) {
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


                      Navigator.pushAndRemoveUntil<void>(
                        context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) => OrderTaxi(
                                  page: widget.page,
                                  firstname: widget.firstname,
                                  phone: widget.phone,
                                  latit: widget.latit,
                                  long: widget.long,
                                )),
                        ModalRoute.withName('/'),
                      );
                    },
                    child: Text(
                      "Заказать1",
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
