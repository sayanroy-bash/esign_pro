import 'package:cached_network_image/cached_network_image.dart';
import 'package:demo_sdk/demo_sdk.dart';
import 'package:flutter/material.dart';

class ListProducts extends StatelessWidget {
  final List<Product> value;

  ListProducts({required this.value, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(top: 15, bottom: 10, left: 18, right: 18),
        shrinkWrap: true,
        itemCount: value.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          mainAxisExtent: 170,
        ),
        itemBuilder: (context, index) {
          return Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: Offset(0.0, 0.0), //(x,y)
                    blurRadius: 1.0,
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      value[index].title.toString(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: CachedNetworkImage(
                      imageUrl: value[index].images.first,
                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                          Center(child: Container(height: 26, width: 26, child: CircularProgressIndicator(value: downloadProgress.progress))),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      '${value[index].price}',
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }
}
