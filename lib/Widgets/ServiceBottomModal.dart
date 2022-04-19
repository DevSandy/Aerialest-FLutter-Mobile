import 'package:aerial_est_mobile/Utils/aecolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geocoding/geocoding.dart';

import '../Screens/mapscreens/Select_Location_Multi.dart';
import '../Screens/mapscreens/Select_Location_Single.dart';
import '../Utils/Apis.dart';

class ServiceBottomModal {
  TextEditingController addresscontroller = TextEditingController();
  showmodal(BuildContext context, servicedata) {
    var screensize = MediaQuery.of(context).size;
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            padding: MediaQuery.of(context).viewInsets,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                    height: 50,
                    width: screensize.width,
                    color: aecolors.primary,
                    child: const Center(
                        child: Text('Details',
                            style:
                                TextStyle(fontSize: 22, color: Colors.white)))),
                Image.network(
                  Apis.base_url + servicedata['image_url'],
                  height: 100,
                  width: 100,
                ),
                Text(
                  servicedata['service_title'],
                  style: const TextStyle(fontSize: 22),
                ),
                Text('Price : \$' + servicedata['service_price'].toString(),
                    style: const TextStyle(fontSize: 22)),
                Container(
                  margin: const EdgeInsets.all(8),
                  // padding: EdgeInsets.only(
                  //     bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: null,
                    controller: addresscontroller,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.add_location_alt),
                        hintText: 'Enter Address'),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if(addresscontroller.text!=''){
                      var locations = await locationFromAddress(addresscontroller.text);
                      Navigator.pop(context);
                      if(servicedata['is_multi']==0){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Select_Location_Single(servicedata,addresscontroller.text,locations)),
                        );
                      }
                      else if(servicedata['is_multi']==1){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Select_Location_Multi(servicedata,addresscontroller.text,locations)),
                        );
                      }
                    }
                  },
                  child: Container(
                    height: 50,
                    width: screensize.width / 1.5,
                    margin: const EdgeInsets.only(top: 20, bottom: 50),
                    decoration: BoxDecoration(
                        color: aecolors.primary,
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(143, 148, 251, .2),
                              blurRadius: 20.0,
                              offset: Offset(0, 10))
                        ]),
                    child: const Center(
                      child: Text(
                        'Proceed',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
