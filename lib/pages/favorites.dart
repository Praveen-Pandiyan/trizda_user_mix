import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trizda_user/models/comments_model.dart';
import '../models/product_model.dart';
import 'package:provider/provider.dart';

class FavList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final diaryEntries = Firestore.instance
        .collection('Rating')
        .where("id" == "3h3N5JprkMNv0W2MTK4t")
        .snapshots()
        .map((snapshot) {
      return snapshot.documents
          .map((doc) => CommentsEntry.fromDoc(doc))
          .toList();
    });
    return StreamProvider<List<CommentsEntry>>(
      create: (_) => diaryEntries,
      child: MyHomePage(),
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
  @override
  Widget build(BuildContext context) {
    final diaryEntries = Provider.of<List<CommentsEntry>>(context);
    return SizedBox(
      child: ListView(
        children: <Widget>[
          SizedBox(height: 40),
          if (diaryEntries != null)
            for (var diaryData in diaryEntries) Text(diaryData.name),
          if (diaryEntries == null) Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
