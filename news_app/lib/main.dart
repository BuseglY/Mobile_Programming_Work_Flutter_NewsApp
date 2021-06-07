import 'package:flutter/material.dart';
import 'package:news_app/data/news_service.dart';
import 'package:news_app/models/article.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Haberler',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch:Colors.red,
      ),
      home: MyHomePage(title: 'Haberler'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Articles> articles= [];

  @override
  void initState() {
    NewsService.getNews().then((value) {
      setState((){
        articles=value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child:ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context,index){
          return Card(
            child: Column(
              children: [
                Image.network(articles[index].urlToImage ?? 'default' ),
                ListTile(
                  leading: Icon(Icons.arrow_drop_down_circle),
                  title: Text(articles[index].title ?? 'default'),
                  subtitle: Text(articles[index].author ?? 'default'),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(articles[index].description ?? 'default'),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: [
                    FlatButton(onPressed: () async{
                      await launch(articles[index].url ?? 'default');
                    }, child: Text('Habere git')),
                  ],
                )
              ],
            ),
            );
        }
      )),
    );
  }
}
