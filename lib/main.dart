import 'package:flutter/material.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/screens/details/details_screen.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shop_app/theme.dart';

import 'package:flutter/material.dart';
import 'package:shop_app/FruitDataModel.dart';
import 'package:shop_app/FruitDetail.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  static List<String> fruitname =['ما','تر','سي','ثص','ظط'];

  static List url = ['https://www.applesfromny.com/wp-content/uploads/2020/05/Jonagold_NYAS-Apples2.png',
    'https://cdn.mos.cms.futurecdn.net/42E9as7NaTaAi4A6JcuFwG-1200-80.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/Hapus_Mango.jpg/220px-Hapus_Mango.jpg',
    'https://5.imimg.com/data5/VN/YP/MY-33296037/orange-600x600-500x500.jpg',
    'https://5.imimg.com/data5/GJ/MD/MY-35442270/fresh-pineapple-500x500.jpg'];

  final List<FruitDataModel> Fruitdata = List.generate(
      fruitname.length,
          (index)
      => FruitDataModel('${fruitname[index]}', '${url[index]}','${fruitname[index]} Description...'));


  List<String>? foodListSearch;
  final FocusNode _textFocusNode = FocusNode();
  TextEditingController? _textEditingController = TextEditingController();
  @override
  void dispose() {
    _textFocusNode.dispose();
    _textEditingController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Container(
            height:40,
            width: 300,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)),
            child: TextField(
              controller: _textEditingController,
              focusNode: _textFocusNode,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  suffixIcon: Icon(Icons.search),
                  contentPadding: EdgeInsets.all(15)),
              onChanged: (value) {
                setState(() {
                  foodListSearch = fruitname
                      .where(
                          (element) => element.contains(value.toLowerCase()))
                      .toList();
                  if (_textEditingController!.text.isNotEmpty &&
                      foodListSearch!.length == 0) {
                    print('foodListSearch length ${foodListSearch!.length}');
                  }
                });
              },
            ),
          ),
          automaticallyImplyLeading: true,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios),
            onPressed:() =>  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DetailsScreen())),
          ),
        ),
        body:
        _textEditingController!.text.isNotEmpty &&
            foodListSearch!.length == 0
            ? Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.search_off,
                    size: 160,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'No results found',
                    style: TextStyle(
                        fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        )
        :ListView.builder(
            itemCount: _textEditingController!.text.isNotEmpty
                ? foodListSearch!.length
                :Fruitdata.length,
            itemBuilder: (context,index){
              return Card(
                child: ListTile(
                  title: Text(_textEditingController!.text.isNotEmpty
                      ? foodListSearch![index]
                      :Fruitdata[index].name),
                  leading: SizedBox(
                    width: 50,
                    height: 50,
                    child: Image.network(Fruitdata[index].ImageUrl),
                  ),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FruitDetail(fruitDataModel: Fruitdata[index],)));
                  },
                ),
              );
            }
        )
    );
  }
}
