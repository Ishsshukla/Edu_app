import 'package:cached_network_image/cached_network_image.dart';
import 'package:edu_app/students_screens/utils/utils.dart';
import 'package:flutter/material.dart';

Widget newsBox(snapshot, index, text1, height, width, h2, context, page) {
  final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;

  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => page));
    },
    child: Container(
        height: screenHeight * height,
        width: screenWidth * width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Column(
            children: [
              Container(
                height: screenHeight * h2,
                child: CachedNetworkImage(
                    imageUrl:
                        snapshot.data.articles![index].urlToImage.toString(),
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                          child: spinKit2,
                        )),
                // errorWidge/t:(context)
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(6),
                //   // image: DecorationImage(
                //   //   image: AssetImage(image),
                //   //   fit: BoxFit.cover,
                //   // ),
                //   child:ChacheNetworkImage()
                // ),
              ),
              Text(
                snapshot.data!.articles![index].title.toString(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Color(0xFF00184A),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  // height: 0,
                ),
              ),
            ],
          ),
        )),
  );
}