
import 'package:love_novel/data/models/public/episode.dart';
import 'package:love_novel/ui/pages/discovery/discovery_sub.dart';

class EpisodeArguments{
  final Episode episode;
  EpisodeArguments({required this.episode});
}
class DiscoveryArguments{
  final DiscoveryBooksController controller;
  DiscoveryArguments({required this.controller});
}