import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grocerycustomerdemo/Models/category.dart';
import 'package:grocerycustomerdemo/Pages/items.dart';
import 'package:grocerycustomerdemo/Themes/colors.dart';
import 'package:grocerycustomerdemo/providers/categoryProvider.dart';
import 'package:provider/provider.dart';

class ImageSlider extends StatefulWidget {
  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int photoIndex = 0;

  List photos = [];

  void _previousImage() {
    setState(() {
      photoIndex = photoIndex > 0 ? photoIndex - 1 : photos.length - 1;
    });
  }

  void _nextImage() {
    setState(() {
      photoIndex = photoIndex < photos.length - 1 ? photoIndex + 1 : photoIndex;
    });
  }

  var startHorizontalDragDetails;
  var updateHorizontalDragDetails;

  @override
  void didChangeDependencies() {
    var categoryprovider = Provider.of<CategoryProvider>(context);
    if (categoryprovider.initSlider) {
      categoryprovider.fetchAndSetSlider();
    }
    photos = categoryprovider.slider;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var categoryprovider = Provider.of<CategoryProvider>(context);
    bool sliderLoad = categoryprovider.loadedSlider;
    return sliderLoad
        ? Container()
        : Column(
            children: <Widget>[
              Container(
                height: 3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [kMainColor, kWhiteColor, kYellowColor],
                  ),
                ),
              ),
              photos == []
                  ? Container()
                  : GestureDetector(
                      onTap: () {
                        Category displayedCategory;
                        var categoryForLoop = categoryprovider.category;
                        for (int i = 0; i < categoryForLoop.length; i++) {
                          if (categoryForLoop[i].categoryId ==
                              photos[photoIndex].masterHomeSliderCategoryId) {
                            displayedCategory = categoryForLoop[i];
                          }
                        }
                        displayedCategory.categoryStatus == '0'
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ItemsPage(
                                    displayedCategory.categoryName,
                                    CachedNetworkImageProvider(
                                        displayedCategory.categoryImage),
                                    displayedCategory.categoryId,
                                  ),
                                ),
                              )
                            : null;
                      },
                      onHorizontalDragStart: (dragDetails) {
                        startHorizontalDragDetails = dragDetails;
                        print(startHorizontalDragDetails);
                      },
                      onHorizontalDragUpdate: (dragDetails) {
                        updateHorizontalDragDetails = dragDetails;
                        print(updateHorizontalDragDetails);
                      },
                      onHorizontalDragEnd: (endDetails) {
                        double dx =
                            updateHorizontalDragDetails.globalPosition.dx -
                                startHorizontalDragDetails.globalPosition.dx;
                        double dy =
                            updateHorizontalDragDetails.globalPosition.dy -
                                startHorizontalDragDetails.globalPosition.dy;
                        if (dx < 0) {
                          setState(() {
                            _previousImage();
                          });
                        }
                        if (dx > 0) {
                          setState(() {
                            _nextImage();
                          });
                        }
                      },
                      child: photos == []
                          ? Container()
                          : GestureDetector(
                              child: Container(
                                height: 210,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      photos[photoIndex].masterHomeSliderImage,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                    ),
              Container(
                height: 3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [kMainColor, kWhiteColor, kYellowColor],
                  ),
                ),
              ),
            ],
          );
  }
}
