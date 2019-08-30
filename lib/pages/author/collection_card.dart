import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_eyepetizer/entity/issue_entity.dart';
import 'package:flutter_eyepetizer/pages/video/video_details_page.dart';
import 'package:path/path.dart';

class CollectionCard extends StatelessWidget {
  final Item item;
  final int childIndex;

  CollectionCard({Key key, this.item, this.childIndex});

  Widget _renderWidget(index) {
    if ((index + 1) % 2 == 0) {
      return Padding(
        padding: EdgeInsets.only(left: 6, right: 6),
        child: _renderItemWidget(context, index),
      );
    } else {
      return _renderItemWidget(context, index);
    }
  }

  Widget _renderItemWidget(context, index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Stack(
            alignment: FractionalOffset(0.97, 0.05),
            children: <Widget>[
              GestureDetector(
                child: CachedNetworkImage(
                  width: 300,
                  fit: BoxFit.cover,
                  imageUrl: item.data.itemList[index].data.cover.feed,
                  errorWidget: (context, url, error) =>
                      Image.asset('images/img_load_fail'),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VideoDetailsPage(
                                item: item.data.itemList[index],
                              )));
                },
              ),
              Positioned(
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      item.data.itemList[index].data.category,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white30,
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 10, top: 5, bottom: 5),
          child: Text(
            item.data.itemList[index].data.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
            ),
          ),
        ),
        Text(
          DateUtil.formatDateMs(
              item.data.itemList[index].data.author.latestReleaseTime,
              format: 'yyyy/MM/dd HH:mm'),
          style: TextStyle(color: Colors.black26, fontSize: 12),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 10,
        top: 10,
        right: 10,
        bottom: 10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: 10,
            ),
            child: Text(
              item.data.header.title,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 245,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return _renderWidget(index);
              },
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: item.data.itemList.length,
            ),
          ),
        ],
      ),
    );
  }
}
