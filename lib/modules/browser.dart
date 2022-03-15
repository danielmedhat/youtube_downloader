import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tubera/cubit/home_cubit.dart';
import 'package:tubera/cubit/home_states.dart';
import 'package:tubera/models/search_model.dart';
import 'package:tubera/modules/video_link.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Browser extends StatelessWidget {
  const Browser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit=HomeCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
            body: SafeArea(
              child: SingleChildScrollView(
                
                child: Column(
                        children: [
                SizedBox(
                  height: 7,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: TextFormField(
                    onChanged: (String value) {
                      
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter cideo name';
                      } else
                        return null;
                    },
                    controller: HomeCubit.get(context).searchController,
                    decoration: InputDecoration(
                      hintText: 'Video Name',
                      prefixIcon: Icon(Icons.search, color: Colors.lightBlueAccent),
                      filled: true,
                      fillColor: Colors.grey[300],
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.white)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                ElevatedButton(onPressed: (){
                  HomeCubit.get(context).searchChange(cubit.searchController.text);
                }, child: Text('Search')),

                if (HomeCubit.get(context).linkModel == null&&HomeCubit.get(context).searchModel == null)
                  Container()
                else if(state is GetLoadingState)
                Center(child: CircularProgressIndicator(),)
                else if (cubit.searchValue!.startsWith('https://www.youtube.com/')&&cubit.linkModel!=null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => buildLinkItem(
                           // HomeCubit.get(context).searchModel!.items[index]
                           context ,cubit
                            ),
                        separatorBuilder: (context, index) => Container(
                              width: double.infinity,
                              height: 1,
                              color: Colors.grey[300],
                            ),
                        itemCount:cubit.isLink==true?1:
                            HomeCubit.get(context).searchModel!.items.length),
                  )
                else //(HomeCubit.get(context).searchModel != null&&cubit.isLink==false)
                 Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => buildSearchItem(
                           context,HomeCubit.get(context).searchModel!.items[index]
                            
                            ),
                        separatorBuilder: (context, index) => Container(
                              width: double.infinity,
                              height: 1,
                              color: Colors.grey[300],
                            ),
                        itemCount:cubit.isLink==true?1:
                            HomeCubit.get(context).searchModel!.items.length),
                  )
              
                  
                        ],
                      ),
              ),
            )
            //  WebView(
            //   initialUrl: 'https://www.youtube.com',
            //   javascriptMode: JavascriptMode.unrestricted,
            //   onWebViewCreated: (controller) {
            //     HomeCubit.get(context).onCreated(controller);
            //     print('{_controller.currentUrl()}');
            //   },
            //   onWebResourceError: (error) {
            //   showDialog(
            //       context: context,
            //       barrierColor: Colors.grey,
            //       builder: (context) {
            //         return AlertDialog(
            //           title: Text("Something went wrong!"),
            //           content: Text("Missing Internet connection"),
            //           scrollable: true,
            //           actions: [
            //             TextButton(
            //                 onPressed: () {
            //                   Navigator.pushAndRemoveUntil(
            //                       context,
            //                       MaterialPageRoute(builder: (_) => VideoLink()),
            //                       (route) => false);
            //                 },
            //                 child: Text("Okay"))
            //           ],
            //         );
            //       });
            // },
            // ),
            // floatingActionButton:
            //     HomeCubit.get(context).showDownloadButton == false
            //         ? null
            //         : FloatingActionButton(onPressed: () {}),
            );
      },
    );
  }



   Widget buildSearchItem( context,Items model,) {
    return Container(
      height: 132,
      width: double.infinity,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                width: 150,
                height: 110,
                child: Image(
                  fit: BoxFit.cover,
                  image:
                      NetworkImage(
                        // // cubit.isLink?
                        // cubit.linkModel!.items[0].snippet!.thumbnails!.medium!.url.toString()
                     model.snippet!.thumbnails!.medium!.url.toString()
                       ),
                ),
              ),
              Icon(
                Icons.play_circle_filled_rounded,
                size: 40,
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                   // cubit.isLink?
                    // cubit.linkModel!.items[0].snippet!.title.toString(),
                   model.snippet!.title.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          // //cubit.isLink?
                          // cubit.linkModel!.items[0].snippet!.channelTitle.toString(),
                         model.snippet!.channelTitle.toString(),
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            AlertDialog alertDialog =AlertDialog(
                                title: Text("select video quality "),
                                content: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                  
                                  ElevatedButton(onPressed: (){
                                    // HomeCubit.get(context).downloadSearchVideo(
                                    //   model.id!.videoId.toString(),18 ,'new video');
                                  }, child: Text('360')),
                                
                                   SizedBox(width: 20,),
                                 
                                  
                                  ElevatedButton(onPressed: (){
                                    // HomeCubit.get(context).downloadSearchVideo(
                                    //   model.id!.videoId.toString(),22,'new video' );
                                  }, child: Text('720')),
                                  
                                ],)
                              );
                              showDialog
                              (context: context, builder: (BuildContext context){
                                return alertDialog;
                              });
                            
                            // HomeCubit.get(context).downloadSearchVideo(
                            //     model.id!.videoId.toString(), );
                          },
                          icon: Icon(Icons.download_rounded))
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
    //   Container(
    //     height: 320,
    //     child: Stack(
    //       children: [
    // Column(
    //   children: [
    //     Stack(
    //       alignment: AlignmentDirectional.center,
    //       children: [
    //         Container(
    //           width: double.infinity,
    //           height: 250,
    //           child: Image(fit:BoxFit.cover,image: NetworkImage("${model.snippet!.thumbnails!.medium!.url}"),),
    //         ),Icon(Icons.play_circle_filled_rounded,
    //         size: 100,)
    //       ],
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.all(10.0),
    //       child: Text(model.snippet!.title.toString(),
    //       style: TextStyle(
    //         fontWeight: FontWeight.bold,
    //         fontSize: 20
    //       ),
    //       maxLines: 2,
    //       overflow: TextOverflow.ellipsis,
    //       ),
    //     )

    //   ],
    // ),
    //         IconButton(onPressed: (){}, icon:Icon( Icons.download_rounded),iconSize:80 ,color: Colors.blue,)
    //       ],
    //     ),
    //   );
  }


  Widget buildLinkItem( context,HomeCubit cubit,) {
    return Container(
      height: 132,
      width: double.infinity,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                width: 150,
                height: 110,
                child: Image(
                  fit: BoxFit.cover,
                  image:
                      NetworkImage(
                        // cubit.isLink?
                        cubit.linkModel!.items[0].snippet!.thumbnails!.medium!.url.toString()
                     // : model.snippet!.thumbnails!.medium!.url.toString()
                       ),
                ),
              ),
              Icon(
                Icons.play_circle_filled_rounded,
                size: 40,
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                   // cubit.isLink?
                    cubit.linkModel!.items[0].snippet!.title.toString(),
                    //:model.snippet!.title.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          //cubit.isLink?
                          cubit.linkModel!.items[0].snippet!.channelTitle.toString(),
                         //: model.snippet!.channelTitle.toString(),
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            AlertDialog alertDialog =AlertDialog(
                                title: Text("select video quality "),
                                content: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                  
                                  ElevatedButton(onPressed: (){
                                    // HomeCubit.get(context).downloadSearchVideo(
                                    //   model.id!.videoId.toString(),18 ,'new video');
                                  }, child: Text('360')),
                                
                                   SizedBox(width: 20,),
                                 
                                  
                                  ElevatedButton(onPressed: (){
                                    // HomeCubit.get(context).downloadSearchVideo(
                                    //   model.id!.videoId.toString(),22,'new video' );
                                  }, child: Text('720')),
                                  
                                ],)
                              );
                              showDialog
                              (context: context, builder: (BuildContext context){
                                return alertDialog;
                              });
                            
                            // HomeCubit.get(context).downloadSearchVideo(
                            //     model.id!.videoId.toString(), );
                          },
                          icon: Icon(Icons.download_rounded))
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
    //   Container(
    //     height: 320,
    //     child: Stack(
    //       children: [
    // Column(
    //   children: [
    //     Stack(
    //       alignment: AlignmentDirectional.center,
    //       children: [
    //         Container(
    //           width: double.infinity,
    //           height: 250,
    //           child: Image(fit:BoxFit.cover,image: NetworkImage("${model.snippet!.thumbnails!.medium!.url}"),),
    //         ),Icon(Icons.play_circle_filled_rounded,
    //         size: 100,)
    //       ],
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.all(10.0),
    //       child: Text(model.snippet!.title.toString(),
    //       style: TextStyle(
    //         fontWeight: FontWeight.bold,
    //         fontSize: 20
    //       ),
    //       maxLines: 2,
    //       overflow: TextOverflow.ellipsis,
    //       ),
    //     )

    //   ],
    // ),
    //         IconButton(onPressed: (){}, icon:Icon( Icons.download_rounded),iconSize:80 ,color: Colors.blue,)
    //       ],
    //     ),
    //   );
  }
}
