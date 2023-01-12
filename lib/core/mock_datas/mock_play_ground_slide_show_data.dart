import 'package:elearning/core/data/models/comment_model.dart';
import 'package:elearning/core/data/models/slide_show_model.dart';

class MockPlayGroundSlideShowData {
  static List<CommentModel> listComment = [
    CommentModel(
      "Persion 1",
      "Plus, don’t forget to add the Permission_handler if you wanted to run your app in a real device where you can find the code for it here.",
      "1 days ago",
    ),
    CommentModel(
      "Persion 2",
      "Installation bundles are not available for master. However, you can get the SDK directly from GitHub repo by cloning the master channel, and then triggering a download of the SDK dependencies",
      "2 days ago",
    ),
    CommentModel(
      "Persion 3",
      "For additional details on how our installation bundles are structured, see Installation bundles.",
      "3 days ago",
    ),
    CommentModel(
      "Persion 4",
      "You can save image to gallery by using Image_gallery_saver plugin.image_gallery_saver",
      "4 days ago",
    ),
    CommentModel(
      "Persion 5",
      "I've found the solution after 2 days of struggling with that. you should save file as PNG to device path then use image_gallery_saver",
      "5 days ago",
    ),
    CommentModel(
      "Persion 6",
      "A CacheManager to download and cache files in the cache directory of the app. Various settings on how long to keep a file can be changed.",
      "6 days ago",
    ),
    CommentModel(
      "Persion 7",
      "The more basic usage is explained here. See the complete docs for more info.",
      "1 week ago",
    ),
  ];

  static List<SlideShowModel> listSlideShow = [
    SlideShowModel("Page slide show 01"),
    SlideShowModel("Page slide show 02"),
    SlideShowModel("Page slide show 03"),
    SlideShowModel("Page slide show 04"),
    SlideShowModel("Page slide show 05"),
    SlideShowModel("Page slide show 06"),
    SlideShowModel("Page slide show 07"),
  ];
}
