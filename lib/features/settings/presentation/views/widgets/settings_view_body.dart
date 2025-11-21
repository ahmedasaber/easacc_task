import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:easacc_task/features/settings/presentation/views/widgets/scan_button.dart';
import 'package:easacc_task/features/settings/presentation/views/widgets/url_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../../cubit/scan_devices_cubit.dart';

class SettingViewBody extends StatefulWidget {
  const SettingViewBody({
    super.key,
  });

  @override
  State<SettingViewBody> createState() => _SettingViewBodyState();
}

class _SettingViewBodyState extends State<SettingViewBody> {
  late TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24,),
          Text('Web URL', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          URLTextField(controller: controller,),
          Divider(height: 32,),
          Text('Network Devices', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          ScanButton(onPressed: () async{
              context.read<ScanDevicesCubit>().scanDevices();
              await showScanDevicesBottomSheet(context);
              if(!context.mounted)return;
              await context.read<ScanDevicesCubit>().stopScan();
            },
          ),
        ],
      ),
    );
  }

  Future<void> showScanDevicesBottomSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        ),
      builder: (context){
        return BlocBuilder<ScanDevicesCubit, ScanDevicesState>(
          builder: (context, state){
            if(state is ScanDevicesLoading){
              return SizedBox(
                height: MediaQuery.of(context).size.height * .5,
                width: double.infinity,
                child: Center(child: CircularProgressIndicator(),)
              );
            }else if(state is ScanDevicesSuccess){
              List<ScanResult> devices = state.devices;
              if (devices.isEmpty) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * .5,
                  width: double.infinity,
                  child: Center(child: Text('Not Found'))
                );
              } else{
                return SizedBox(
                  height: MediaQuery.of(context).size.height * .5,
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: devices.length,
                    itemBuilder: (context, i){
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${devices[i].device.remoteId.toString()}, ${devices[i].rssi.toString()}')
                          ],),
                      );
                    }
                  ),
                );
              }
            }else if(state is ScanDevicesFailure){
              return Container(
                height: MediaQuery.of(context).size.height * .5,
                width: double.infinity,
                color: Colors.white,child: Center(child: Text(state.message,),));
            }else{
              return SizedBox();
            }
        });
    });
  }
}