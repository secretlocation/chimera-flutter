import 'package:flutter/painting.dart';

class VideoContent
{
  VideoContent(String newTitle,
      String newDescription,
      List<String> parallaxLayers,
      int runtime,
      String newUrl,
      String newPlayButton,
      int newColor,)
  {
    this.title = newTitle;
    this.description = newDescription;
    this.videoUrl = newUrl;
    this.runtime = runtime;

    this.thumbnail = [];
    parallaxLayers.forEach((layerString) =>
      this.thumbnail.add( AssetImage(layerString) )
    );

    if (newPlayButton != null) {
      this.playButton = AssetImage(newPlayButton);
    }

    this.customColor = Color(newColor);
  }

  String title;
  String description;
  List<AssetImage> thumbnail;
  int runtime;
  String videoUrl;
  AssetImage playButton;
  Color customColor;
}
