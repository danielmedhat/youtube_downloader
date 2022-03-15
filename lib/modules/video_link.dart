import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tubera/cubit/home_cubit.dart';

class VideoLink extends StatelessWidget {
  const VideoLink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _controller = TextEditingController();
    AlertDialog? alertDialog;

    final GlobalKey<FormState> downloadKey = GlobalKey<FormState>();
    return Scaffold(
      body: Form(
        key: downloadKey,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'No Video Link';
                  } else
                    return null;
                },
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Video Link',
                  prefixIcon: Icon(Icons.search, color: Colors.lightBlueAccent),
                  filled: true,
                  fillColor: Colors.grey[200],
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
              height: 50,
            ),
            ElevatedButton(
                onPressed: () {
                  if (downloadKey.currentState!.validate())
                    alertDialog = AlertDialog(
                        title: Text("select video quality "),
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            
                            ElevatedButton(
                                onPressed: () {
                                  HomeCubit.get(context)
                                      .downloadVideo(_controller.text, 18,'new video');
                                },
                                child: Text('360')),
                                SizedBox(width: 20,),
                         
                            ElevatedButton(
                                onPressed: () {
                                  HomeCubit.get(context)
                                      .downloadVideo(_controller.text, 22,'new video');
                                },
                                child: Text('720')),
                            
                          ],
                        ));
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alertDialog!;
                      });

                  // HomeCubit.get(context)
                  //     .downloadVideo(
                  //         _controller.text)
                  // .then((value) => {
                  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //           duration: Duration(seconds: 3),
                  //           content: Text('Download Started')))
                  //     });
                },
                child: Text('Download Video'))
          ],
        ),
      ),
    );
  }
}
