/*
class MyApp extends StatelessWidget {
  //Uint8List memory = base64Decode("");

  List<Contact> list = List.generate(100, (index) {
    return Contact(name: "$index", phone: "$index", address: "$index");
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: const Duration(seconds: 3),
                    content: const Text('I am snackbar'),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {},
                      textColor: Colors.white,
                    )));
              },
              icon: const Icon(
                Icons.notification_add_rounded,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.message,
                color: Colors.white,
              ))
        ],
        leading: FlutterLogo(),
        title: const Text(
          "AppBar Lesson",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.brown,
        */
/*toolbarHeight: 120,
        elevation: 2,
        shadowColor: Colors.grey,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)))*//*

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  color: Colors.brown,
                  width: double.infinity,
                  height: 350,
                ),
                const Positioned(
                  top: 50,
                  left: 100,
                  right: 100,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage(
                      "images/test.png",
                    ),
                  ),
                ),
                const Positioned(
                  top: 200,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Text(
                        "Mg Mg",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      )
                    ],
                  ),
                ),
                const Positioned(
                  top: 260,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Text(
                        "Bangkok",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 300,
                  left: 12,
                  right: 12,
                  child: Card(elevation: 2, child: CardRow()),
                ),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            ListView.builder(
                padding: const EdgeInsets.only(left: 12, right: 12),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      title: Text(list[index].name ?? "dd"),
                      subtitle: Text(list[index].phone ?? "dd"),
                      trailing: Text(list[index].address ?? "dd"),
                    ),
                  );
                })
          ],
        ),
      ),
      */
/*GridView.builder(
        itemCount: list.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12
        ),
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: (index % 2 == 0) ? Colors.red : Colors.green,
            child: ListTile(
              title: Text(list[index].name ?? "dd"),
              subtitle: Text(list[index].phone ?? "dd"),
              trailing: Text(list[index].address ?? "dd"),
            ),
          );
        },
      ),*//*

      */
/*ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                title: Text(list[index].name ?? "dd"),
                subtitle: Text(list[index].phone ?? "dd"),
                trailing: Text(list[index].address ?? "dd"),
              ),
            );
          }),*//*

      */
/*Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              color: Colors.red,
              height: 400,
            ),
            Positioned(
              bottom: 100,
              child: Container(
                color: Colors.green,
                width: 200,
                height: 200,
              ),

            ),
            Positioned(
              bottom: -100,
              child: Stack(
                children: [
                  DottedBorder(
                    stackFit: StackFit.passthrough,
                    borderType: BorderType.Circle,
                    radius: Radius.circular(10),
                    padding: EdgeInsets.all(4),
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset("images/test.png",fit: BoxFit.cover,),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),*//*


      */
/*Center(
        child: Column(
          children: [
            TextButton(onPressed: () {}, child: Text('Text Button')),
            ElevatedButton(onPressed: (){}, child: Text('Elevated Button'),style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12) )
            ),),
            OutlinedButton(onPressed: (){}, child: Text('Outline Button'))
            *//*
 */
/*Expanded(child: Container(child: Image.asset("images/test.png",height: 300,fit: BoxFit.fill,))),
            Expanded(child: Image.memory(memory)),
            Expanded(
                child: Image.network(
                    "https://media.gettyimages.com/id/175515475/photo/mountains.jpg?s=612x612&w=0&k=20&c=e0TxdqpmQxgSYoHiB6F6x-SLsLbIeW7yM3weSBNyZ5U=",loadingBuilder:(_,widget,progress){
                      if (progress == null) return widget;
                      return CircularProgressIndicator();
                })
            )*//*
 */
/*
          ],
        ),
      )*//*


      */
/*Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.red,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.green,
            ),
          ),
          Expanded(
              flex: 2,

              child: Container(
            color: Colors.blue,
          ))
        ],
      ),*//*

      */
/*Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Text one'),
            Expanded(child: Text('the button will be disabled and will not react to touch.')),
            Text('Text three')
          ],
          *//*

      */
/*child: Container(
            margin: const EdgeInsets.only(left: 52,right: 12),
            padding: const EdgeInsets.only(left: 12,right: 12),
            //color: Colors.brown,
            //transform: Matrix4.identity()..rotateZ(0.3),
            constraints: const BoxConstraints(
                minWidth: 200, minHeight: 200, maxWidth: 300, maxHeight: 300),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                    colors: [Colors.cyan, Colors.green, Colors.grey],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight
                ),
                color: Colors.red,
                border: Border.all(color: Colors.black, width: 6)),
            child: const Text(
              'the button will be disabled and will not react to touch. It is highly discouraged to disable a floating action button as there is no indication to the user that the button is disabled.',
              maxLines: 1,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Lora',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: Colors.deepOrange,
                  decorationThickness: 2),
            ),
          ),*//*
 */
/*
        ),*//*

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MyStateFulPage()));
          //print('Click Floating action button');
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget CardRow() {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CardItem(title: "Photo", message: '500'),
          Container(height: 60, width: 1, color: Colors.black),
          CardItem(title: "Followers", message: '500'),
          Container(height: 60, width: 1, color: Colors.black),
          CardItem(title: "Following", message: '500'),
        ]);
  }

  Widget CardItem({required String title, required String message}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
        Text(
          message,
          style: const TextStyle(color: Colors.black, fontSize: 24),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

*/
/*Widget ContactItemView( ) {
  return Column();
}*//*


class Contact {
  final String? name;
  final String? phone;
  final String? address;

  Contact({this.name, this.phone, this.address});
}*/
