import 'package:flutter/painting.dart';

class VideoContent
{
  VideoContent(String newTitle, String newDescription, String newThumbnail, String newUrl)
  {
    this.title = newTitle;
    this.description = newDescription;
    this.thumbnail = new AssetImage(newThumbnail);
    this.videoUrl = newUrl;
  }
  String title;
  String description;
  AssetImage thumbnail;
  String videoUrl;
}

final List<VideoContent> data = <VideoContent>[
  VideoContent("Mule",
              "Sample video description body Text",
              "graphics/panda.png",
              "http://yt-dash-mse-test.commondatastorage.googleapis.com/media/car-20120827-87.mp4"),
  VideoContent("Catatonic",
              "Another sample video's description body text",
              "graphics/panda.png",
              "http://yt-dash-mse-test.commondatastorage.googleapis.com/media/motion-20120802-87.mp4"),
  VideoContent("Burlap",
      "Another sample video's description body text",
      "graphics/panda.png",
      "http://yt-dash-mse-test.commondatastorage.googleapis.com/media/motion-20120802-87.mp4"),
];
