class Article {
  int essayid;
  int likeCount;
  String userName;
  int userId;
  String userAvatar;
  String essayName;
  String essayContent;
  String essayAvatar;
  String publishDate = '';

  Article(
      {this.essayid = 0,
      this.likeCount = 0,
      this.userName = 'diting',
      this.userId = 0,
      this.userAvatar =
          'https://t7.baidu.com/it/u=4036010509,3445021118&fm=193&f=GIF',
      this.essayName = "有生之年",
      this.essayContent =
          '用一句话来形容《有生之年》的故事梗概,那就是不少网友提及的,一个叫高嘉岳（吴慷仁 饰）的男人决定去死。编剧的创作思路,或多或少受到瑞典著名IP《一个叫欧维的男人决定去死》的影响。41岁的高嘉岳的人生,看起来确实很“失败”。他早早离家,与家人关系疏远,多少有点“断亲”。他在台湾省屏东县的小琉球岛上经营一个小餐馆,餐馆评分很低,食客很少,最终走向倒闭。处了多年的女友,受不了他的随性懒散,出轨并怀孕了。而盘下他这家餐厅的新老板,竟是女友的出轨对象。用一句话来形容《有生之年》的故事梗概,那就是不少网友提及的,一个叫高嘉岳（吴慷仁 饰）的男人决定去死。编剧的创作思路,或多或少受到瑞典著名IP《一个叫欧维的男人决定去死》的影响。41岁的高嘉岳的人生,看起来确实很“失败”。他早早离家,与家人关系疏远,多少有点“断亲”。他在台湾省屏东县的小琉球岛上经营一个小餐馆,餐馆评分很低,食客很少,最终走向倒闭。处了多年的女友,受不了他的随性懒散,出轨并怀孕了。而盘下他这家餐厅的新老板,竟是女友的出轨对象。',
      this.essayAvatar =
          'http://s4vhmosi8.hd-bkt.clouddn.com/FpSVKu6mlGLwBgnpmoNrT6lFACsK',
      this.publishDate = ''});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        essayid: json['essayId'],
        likeCount: json['likeCount'],
        userName: json['userName'],
        // userId: json['id'],
        userAvatar: json['userAvatar'],
        essayName: json['essayName'],
        essayContent: json['essayContent'],
        essayAvatar: json['essayAvatar'],
        publishDate: json['publishDate']);
  }
}
