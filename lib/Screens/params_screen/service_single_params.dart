import 'dart:async';
import 'dart:io';
import 'package:aerial_est_mobile/Widgets/LoaderDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding_platform_interface/src/models/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../Methods/GetLogos.dart';
import '../../Utils/Apis.dart';

class Service_single_params extends StatefulWidget {
  Service_single_params(
      this.servicedata, this.address, this.locations, this.markers,
      {Key? key})
      : super(key: key);
  Map servicedata;
  String address;
  List<Location> locations;
  Set<Marker> markers;
  @override
  _Service_single_paramsState createState() => _Service_single_paramsState();
}

class _Service_single_paramsState extends State<Service_single_params> {
  Completer<GoogleMapController> _controller = Completer();

  MapType _currentMapType = MapType.satellite;
  static LatLng _center = const LatLng(45.521563, -122.677433);

  int service_price = 0;
  List<String> latlong = [];
  List<String> headinglist = [];

  Map parammap = {};

  String selectedimageurl = '';

  List<String> chips=[];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map finalparam_map = {};
  @override
  void initState() {
    // TODO: implement initState
    init();
    service_price = widget.servicedata['service_price'];
    finalparam_map['price'] = service_price;
    super.initState();

  }
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Est.Price : \$" + finalparam_map['est'].toString()),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  height: screensize.height / 4,
                  width: screensize.width,
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    rotateGesturesEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 18.0,
                    ),
                    mapType: _currentMapType,
                    markers: widget.markers,
                  ),
                ),
                Positioned(
                    top: 16,
                    right: 16,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 75,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(colors: [
                              Colors.blue,
                              Colors.blue,
                            ])),
                        child: const Center(
                            child: Text(
                          'Edit',
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    )),
                Positioned(
                  top: 16,
                  left: 8,
                  right: 100,
                  child: Container(
                    width: screensize.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade200.withOpacity(0.8)),
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Address : ' + widget.address,
                          style: const TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 8,
                  right: 100,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade200.withOpacity(0.8)),
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Latitude : ' + latlong[0],
                          style: const TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        Text(
                          'Longitude : ' + latlong[1],
                          style: const TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Container(
                margin: const EdgeInsets.all(8),
                width: screensize.width,
                child: Form(
                  key: _formKey,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start  ,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i = 0; i < headinglist.length; i++)
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(headinglist[i],style: const TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold)),
                              ),
                              if(parammap[headinglist[i]]['type'][0]=='radio')
                                DropdownButtonFormField<String>(
                                    hint: Text("Please select any option"),
                                    items: [
                                      for(int j = 0;j<parammap[headinglist[i]]['params'].length;j++)
                                        DropdownMenuItem(
                                            value: parammap[headinglist[i]]['params'][j],
                                            child: Text(parammap[headinglist[i]]['params'][j])),
                                    ],
                                    onSaved: (String? val) async {
                                      await updateprice(context,finalparam_map);
                                      finalparam_map[headinglist[i]]=val.toString();
                                    },
                                    onChanged: (String? val) async {
                                      finalparam_map[headinglist[i]]=val.toString();
                                      await updateprice(context,finalparam_map);
                                    }
                                ),
                              if(parammap[headinglist[i]]['type'][0]=='text_area')
                                TextFormField(
                                  maxLines: 3,
                                  minLines: 3,
                                  decoration: InputDecoration(
                                      // border: InputBorder.none,
                                      hintText: parammap[headinglist[i]]['params'][0]
                                  ),
                                  onSaved: (value){
                                    finalparam_map[headinglist[i]] = value!;
                                  },
                                ),
                              if(parammap[headinglist[i]]['type'][0]=='upload')
                                Container(
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          bottommodallogooption(context);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.all(8),
                                          height: 75,
                                          width: 75,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                              borderRadius: BorderRadius.all(Radius.circular(20))
                                          ),
                                          child: Center(
                                            child: Icon(Icons.add),
                                          ),
                                        ),
                                      ),
                                      selectedimageurl!=''?Image.network(selectedimageurl,width: 75,height: 75,):SizedBox(),
                                    ],
                                  ),
                                ),
                                // Text(parammap[headinglist[i]]['params'].toString()),
                              if(parammap[headinglist[i]]['type'][0]=='text_field')
                                TextFormField(
                                  decoration: InputDecoration(
                                      // border: InputBorder.none,
                                      hintText: parammap[headinglist[i]]['params'][0]
                                  ),
                                  onSaved: (value){
                                    finalparam_map[headinglist[i]] = value!;
                                  },
                                ),
                              if(parammap[headinglist[i]]['type'][0]=='check_box')
                                Column(
                                  children: [
                                    MultiSelectChipDisplay(
                                      chipColor: Colors.blue,
                                      textStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.normal),
                                      onTap: (value) async {
                                        if(chips.length==2){
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                            content: Text("Maximum allowed items are 2"),
                                          ));
                                        }else{
                                          for(int k =0;k<chips.length;k++){
                                            if(chips[k]==value.toString()){
                                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                content: Text("Already added !"),
                                              ));
                                              return ;
                                            }
                                          }
                                          chips.add(value.toString());
                                          finalparam_map[headinglist[i]]=chips;
                                          await updateprice(context,finalparam_map);
                                          setState(() {});
                                        }
                                      },
                                      items: [
                                        for(int j = 0;j<parammap[headinglist[i]]['params'].length;j++)
                                          MultiSelectItem(
                                              parammap[headinglist[i]]['params'][j],
                                              parammap[headinglist[i]]['params'][j]
                                          )
                                      ],
                                    ),
                                    chips.length!=0?Container(
                                      width: screensize.width,
                                      padding: EdgeInsets.all(8),
                                      child: Row(
                                        children: [
                                          for(int k = 0;k<chips.length;k++)
                                            Container(
                                              margin: EdgeInsets.all(2),
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.grey.shade800,
                                                  ),
                                                  borderRadius: BorderRadius.all(Radius.circular(20))
                                              ),
                                              child: Row(
                                                children: [
                                                  Text(chips[k]),
                                                  SizedBox(width: 10,),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      for(int x=0;x<chips.length;x++){
                                                        if(chips[x]==chips[k]){
                                                          chips.removeAt(x);
                                                          finalparam_map[headinglist[i]]=chips;
                                                          await updateprice(context,finalparam_map);
                                                          setState(() {});
                                                        }
                                                      }
                                                    },
                                                      child: Icon(Icons.cancel)
                                                  )
                                                ],
                                              ),
                                            )
                                        ],
                                      ),
                                    ):Container(),
                                  ],
                                )
                                // Text(parammap[headinglist[i]]['params'].toString())
                            ],
                          ),
                        RaisedButton(onPressed: () async {
                          _formKey.currentState!.save();
                          if(selectedimageurl!=''){
                            finalparam_map['logo']=selectedimageurl;
                          }
                          await updateprice(context, finalparam_map);
                        })
                      ],
                      //all param goes here
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  void init() {
    headinglist = [];
    String latlngstring =
        widget.markers.elementAt(0).markerId.value.substring(6);
    latlngstring = latlngstring.substring(1, latlngstring.length - 1);
    latlong = latlngstring.split(",");
    _center = LatLng(double.parse(latlong[0]), double.parse(latlong[1]));
    for (int i = 0; i < widget.servicedata['service_params'].length; i++) {
      headinglist.add(widget.servicedata['service_params'][i].paramHeading);
    }
    headinglist = headinglist.toSet().toList();
    List<String> param= [];
    List<String> paramtype= [];
    List<int> paramprice= [];
    parammap = {};
    for (int i = 0; i < headinglist.length; i++) {
      for(int j = 0;j< widget.servicedata['service_params'].length;j++){
       if(headinglist[i]==widget.servicedata['service_params'][j].paramHeading){
        param.add(widget.servicedata['service_params'][j].param);
        paramtype.add(widget.servicedata['service_params'][j].paramtype);
        paramprice.add(widget.servicedata['service_params'][j].paramPrice);
       }
      }
      parammap[headinglist[i]]= {
        'type':paramtype,
        'params':param,
        'paramprice':paramprice
      };
      param=[];
      paramtype=[];
      paramprice=[];
    }
    setState(() {});
  }

  bottommodallogooption(BuildContext context) {
    return showModalBottomSheet(context: context, builder: (context){
      return Wrap(
        children: [
          Container(
            color: Colors.transparent, //could change this to Color(0xFF737373),
            child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 20,left: 15),
                        child: Text('Choose an option',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)),
                    Container(
                      margin: EdgeInsets.all(15),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap:() async {
                                   File pickedImage = await ImagePicker.pickImage(source: ImageSource.gallery);
                                   if(pickedImage!=null){
                                     selectedimageurl = await GetLogos().uploadlogotoserver(pickedImage);
                                     Navigator.pop(context);
                                     setState(() {});
                                   }else{
                                     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                       content: Text("Something Went Wrong"),
                                     ));
                                   }
                                  },
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.shade200.withOpacity(0.8)),
                                    child: Center(
                                      child: Icon(Icons.add),
                                    ),
                                  ),
                                ),
                                Text('Upload new')
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap:() async {
                                    Navigator.pop(context);
                                    LoaderDialog(context);
                                    List logolist = await GetLogos().getuserlogos();
                                    Navigator.pop(context);
                                    await showmodalselectexistinglogo(context,logolist);
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.shade200.withOpacity(0.8)),
                                    child: Center(
                                      child: Image.asset('assets/images/logo.png'),
                                    ),
                                  ),
                                ),
                                Text('Choose existing')
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ],
      );
    });
  }

  showmodalselectexistinglogo(BuildContext context, List<dynamic> logolist) {
    return showModalBottomSheet(context: context, builder: (context){
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
              margin: EdgeInsets.all(8),
              child: Text('Choose logo',style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),)),
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              children: List.generate(logolist.length, (index){
                return GestureDetector(
                  onTap: () async {
                    selectedimageurl = Apis.base_url+logolist[index];
                    Navigator.pop(context);
                  },
                  child: Container(
                    color: Colors.blue.shade200,
                    height: 50,
                    width: 50,
                    child: Center(
                      child: Image.network(Apis.base_url+logolist[index].toString()),
                    ),
                  ),
                );
              }),
            ),
          )
        ],
      );
    });
    }

  updateprice(BuildContext context, Map finalparam_map) {
    finalparam_map.forEach((key,value){
      if(parammap[key]!=null){
        for(int i = 0 ;i<parammap[key]['params'].length;i++){
          if(parammap[key]['params'][i]==value){
            print('price is '+parammap[key]['paramprice'][i].toString());
          }
        }
      }
    });
  }

}
