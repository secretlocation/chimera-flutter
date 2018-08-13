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