import 'package:demixr_app/providers/youtube_provider.dart';
import 'package:demixr_app/screens/youtube/components/search_bar.dart' as demixr_search_bar; // Use alias for clarity
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class YoutubeScreen extends StatelessWidget {
  const YoutubeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => YoutubeProvider(Get.arguments),
        child: Stack(
          fit: StackFit.expand,
          children: const [
            demixr_search_bar.SearchBar(), // Use the alias to explicitly reference the SearchBar
          ],
        ),
      ),
    );
  }
}