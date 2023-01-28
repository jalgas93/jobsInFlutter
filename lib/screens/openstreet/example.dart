import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jobs/screens/utils/images_assets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class OpenStreetMapExample extends StatefulWidget {
  final LatLng center;
  Color buttonColor;

  OpenStreetMapExample({
    Key? key,
    required this.center,
    this.buttonColor = Colors.white,
  }) : super(key: key);

  @override
  State<OpenStreetMapExample> createState() => _OpenStreetMapExampleState();
}

class _OpenStreetMapExampleState extends State<OpenStreetMapExample> {
  MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  List<String> urls = [
    "https://resofrance.e"
        "u/wp-content/uploads/2018/09/hotel-luxe-mandarin-oriental-paris.jpg",
    "https://lh3.googleusercontent.com/proxy/wTkD1USQGpbVXzZFNLCZBDCL1OQS1bFzSgPa44cHwiheaY9DpoqMdNjBgEJcCIZSQeSkCO-2q5gfuhtnuz4cDhtpansOcWos093YsGvogdQqWnpWlA",
    "https://images.squarespace-cdn.com/content/v1/57d5245815d5db80eadeef3b/1558864684068-1CX3SZ0SFYZA1DFJSCYD/ke17ZwdGBToddI8pDm48kIpXjvpiLxnd0TWe793Q1fcUqsxRUqqbr1mOJYKfIPR7LoDQ9mXPOjoJoqy81S2I8N_N4V1vUb5AoIIIbLZhVYxCRW4BPu10St3TBAUQYVKcZwk0euuUA52dtKj-h3u7rSTnusqQy-ueHttlzqk_avnQ5Fuy2HU38XIezBtUAeHK/Marataba+Safari+lodge",
    "https://lh3.googleusercontent.com/proxy/ovCSxeucYYoir_rZdSYq8FfCHPeot49lbYqlk7nXs7sXjqAfbZ2uw_1E9iivLT85LwIZiGSnXuqkdbQ_xKFhd91M7Y05G94d",
    "https://q-xx.bstatic.com/xdata/images/hotel/max500/216968639.jpg?k=a65c7ca7141416ffec244cbc1175bf3bae188d1b4919d5fb294fab5ec8ee2fd2&o=",
    "https://hubinstitute.com/sites/default/files/styles/1200x500_crop/public/2018-06/photo-1439130490301-25e322d88054.jpeg?h=f720410d&itok=HI5-oD_g",
    "https://cdn.contexttravel.com/image/upload/c_fill,q_60,w_2600/v1549318570/production/city/hero_image_2_1549318566.jpg",
    "https://www.shieldsgazette.com/images-i.jpimedia.uk/imagefetch/https://jpgreatcontent.co.uk/wp-content/uploads/2020/04/spain.jpg",
    "https://www.telegraph.co.uk/content/dam/Travel/2017/November/tunisia-sidi-bou-GettyImages-575664325.jpg",
    "https://lp-cms-production.imgix.net/features/2018/06/byrsa-hill-carthage-tunis-tunisia-2d96efe7b9bf.jpg"
  ];

  String locationMessage = "Current location of the User";
  late double lang;
  late double latit;

  @override
  void initState() {
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
    return SafeArea(
      child: Scaffold(
        key: _key,
        drawer: Drawer(
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.green,
                ), //BoxDecoration
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.green),
                  accountName: Text(
                    "Ungarbaev jalgas",
                    style: TextStyle(fontSize: 18),
                  ),
                  accountEmail: Text("+998973486575"),
                  currentAccountPictureSize: Size.square(50),
                  currentAccountPicture: CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.blueGrey,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/jalgas.jpg'),
                    ), //Text
                  ), //circleAvatar
                ), //UserAccountDrawerHeader
              ), //DrawerHeader
              ListTile(
                leading: const Icon(Icons.book),
                title: const Text(' История заказов '),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.workspace_premium),
                title: const Text(' Помощь '),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text(' Настройки '),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Выйти'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        backgroundColor: Colors.blue[50],
        body: Stack(
          children: [
            Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                left: 0,
                child: FlutterMap(
                  options: MapOptions(
                      center: LatLng(
                          widget.center.latitude, widget.center.longitude),
                      zoom: 17.0,
                      maxZoom: 20,
                      minZoom: 6),
                  mapController: _mapController,
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
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
            Positioned(
                bottom: 260,
                right: 5,
                child: FloatingActionButton(
                  heroTag: 'button_current_location',
                  backgroundColor: Colors.white,
                  onPressed: () {
                    getCurrentLocation2().then((value) {
                      lang = double.parse('${value.longitude}');
                      latit = double.parse('${value.latitude}');
                      setState(() {
                        locationMessage = 'longitude:$lang, latitude:$latit';
                        _mapController.move(
                            LatLng(latit, lang), _mapController.zoom);

                        _mapController.mapEventStream.listen((event) async {
                          if (event is MapEventMoveEnd) {
                            var client = http.Client();
                            String url =
                                'https://nominatim.openstreetmap.org/reverse?format=json&lat=${latit}&lon=${lang}&zoom=18&addressdetails=1';

                            var response = await client.post(Uri.parse(url));
                            var decodedResponse =
                                jsonDecode(utf8.decode(response.bodyBytes))
                                    as Map<dynamic, dynamic>;

                            _searchController.text =
                                decodedResponse['display_name'];

                            setState(() {});
                          }
                        });
                      });
                      print('jalgas' + locationMessage);
                    });

                    pickData().then((value) {
                      var a = value.address;
                      setState(() {
                        _searchController.text = a;
                        print('jalgassss:${a}');
                      });
                    });
                  },
                  child: Icon(
                    Icons.my_location,
                    color: Colors.black,
                  ),
                )),
            Positioned(
                top: 10,
                left: 5,
                child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () {
                    _key.currentState!.openDrawer();
                  },
                  child: Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Future<PickedData> pickData() async {
    LatLong center = LatLong(
        _mapController.center.latitude, _mapController.center.longitude);
    var client = http.Client();
    String url =
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=${_mapController.center.latitude}&lon=${_mapController.center.longitude}&zoom=18&addressdetails=1';

    var response = await client.post(Uri.parse(url));
    var decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<dynamic, dynamic>;
    String displayName = decodedResponse['display_name'];

    _searchController.text = decodedResponse['display_name'];
    return PickedData(center, displayName);
  }
}

class LatLong {
  final double latitude;
  final double longitude;

  LatLong(this.latitude, this.longitude);
}

class PickedData {
  final LatLong latLong;
  final String address;

  PickedData(this.latLong, this.address);
}

Future<Position> getCurrentLocation2() async {
  bool serviceEnable = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnable) {
    return Future.error('Location service is disabled');
  }
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        "Location permissons are  permanentl danied, we cannot request permission");
  }
  return await Geolocator.getCurrentPosition();
}
