import 'package:flutter/material.dart';
import 'package:flutter_jobs/style/app_style.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';


import '../serviceCard/service_card.dart';

// void main() => runApp(MaterialApp(
//   debugShowCheckedModeBanner: false,
//   home: MyApp(),
// ));

class MyApp2 extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp2> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Flutter Demo version"),
          backgroundColor: AppStyle.mainColor,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios, color: Colors.black,),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          child: Stack(
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Column(children: [
                    Container(
                        height: 500,
                        width: 500,
                        child:OpenStreetMapSearchAndPick(
                          center: LatLong(42.457247, 59.607034),
// buttonColor: Colors.blue,

// buttonText: 'Set Current Location',
                          onPicked: (pickedData) {
// print(pickedData.latLong.latitude);
// print(pickedData.latLong.longitude);
// print(pickedData.address);
// Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) =>
//           HomeScreen( address: pickedData.address,geo: pickedData.latLong,),
//     ));
                          },
                        ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    DefaultTabController(
                      length: 3,
                      child: Expanded(
                        child: Column(
                          children: [
                            TabBar(
                                indicatorColor: Color(0xFFFE8C68),
                                unselectedLabelColor: Color(0xFF555555),
                                labelColor: Color(0xFFFE8C68),
                                labelPadding:
                                EdgeInsets.symmetric(horizontal: 5.0),
                                tabs: [
                                  Tab(
                                    text: 'Такси',
                                  ),
                                  Tab(
                                    text: 'Доставка',
                                  ),
                                  Tab(
                                    text: 'Семейное поездки',
                                  ),
                                ]),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 130.0,
                              child: TabBarView(
                                children: [
                                  Container(
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        ServicesCard(
                                            urls[0], 'Эконом', '', 5, context),
                                        ServicesCard(
                                            urls[2], 'Люкс', '', 3, context),
                                        ServicesCard(
                                            urls[2], 'Комфорт', '', 6, context),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        ServicesCard(urls[4],
                                            'Быстрая доставка', '', 3, context),
                                        ServicesCard(urls[5], 'Доставка', '', 2,
                                            context),
                                        ServicesCard(urls[6], 'Доставка', '', 1,
                                            context),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        ServicesCard(urls[7], 'На отдых', '', 5,
                                            context),
                                        ServicesCard(urls[8], 'Мероприятия', '',
                                            3, context),
                                        ServicesCard(urls[9], 'Путешествия', '',
                                            6, context),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ),

            ],
          ),
        ));
  }
}
// }FlutterMap(
//
// options: MapOptions(
// center: LatLng(42.448214, 59.602192), zoom: 13.0),
// layers: [
// TileLayerOptions(
// urlTemplate:
// 'https://tile.openstreetmap.org/{z}/{x}/{y}.png'),
//
// MarkerLayerOptions(
// markers: [
// Marker(
// width: 30.0,
// height: 30.0,
// point: LatLng(42.457247, 59.607034),
// builder: (ctx) => Container(
// child: Container(
// child: Icon(
// Icons.location_on,
// color: Colors.blueAccent,
// size: 40,
// ),
// ),
// ),
// )
// ],
// )
// ],
// ),
