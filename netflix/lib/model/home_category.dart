enum HomeCategory {
  nowPlaying,
  popular,
  upcomming
}

extension HomeCategoryExt on HomeCategory {
  String path() {
    switch (this) {
      case HomeCategory.nowPlaying:
        return "movie/now_playing/";
      case HomeCategory.popular:
        return "movie/popular/";
      case HomeCategory.upcomming:
        return "movie/upcoming/";
    }
  }

  String title() {
    switch (this) {
      case HomeCategory.nowPlaying:
        return "Now Playing";
      case HomeCategory.popular:
        return "Popular";
      case HomeCategory.upcomming:
        return "Upcomming";
    }
  }
}