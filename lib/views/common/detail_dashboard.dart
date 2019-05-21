import 'package:flutter/material.dart';

class DetailDashboard extends StatelessWidget {
  final String imageUri;
  final String imageHeroTag;
  final List<DataTile> dataItems;
  final Color color;

  const DetailDashboard(
      {Key key,
      this.imageUri,
      this.dataItems = const <DataTile>[],
      this.color = Colors.white,
      this.imageHeroTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget image;
    if (imageUri == null) {
      image = Icon(Icons.album, size: 200);
    } else {
      image = Image.asset(imageUri, width: 200, height: 200);
    }
    return Container(
      color: color,
      padding: EdgeInsets.all(16.0),
      child: SizedBox(
        height: 200,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(child: image, tag: imageHeroTag),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: dataItems,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DataTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const DataTile({Key key, this.icon, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Icon(icon), Text(title != null ? title : '-')],
    );
  }
}