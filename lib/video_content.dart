import 'package:flutter/painting.dart';

class VideoContent
{
  VideoContent(String newTitle, String newDescription, List<String> parallaxLayers, int runtime, String newUrl, String newPlayButton)
  {
    this.title = newTitle;
    this.description = newDescription;
    this.videoUrl = newUrl;
    this.runtime = runtime;

    this.thumbnail = [];
    parallaxLayers.forEach((layerString) =>
      this.thumbnail.add( AssetImage(layerString) )
    );

    this.playButton = AssetImage(newPlayButton);
  }

  String title;
  String description;
  List<AssetImage> thumbnail;
  int runtime;
  String videoUrl;
  AssetImage playButton;
}
