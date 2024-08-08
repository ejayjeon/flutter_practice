class Photo {
  final String title;
  final String subtitle;
  final String imageUrl;

  const Photo({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });
}

const assetPrefix = 'assets/images';

const photos = [
  Photo(
    title: '문정역에서, 형님커플과',
    subtitle: '미도리 샤워 존맛~~',
    imageUrl: '$assetPrefix/img_0.jpeg',
  ),
  Photo(
    title: '수원화성 데이트~',
    subtitle: '센스 있는 커플키링',
    imageUrl: '$assetPrefix/img_1.jpeg',
  ),
  Photo(
    title: '경주 여행, 불국사에서!',
    subtitle: '불국사 석가탑 앞에서!',
    imageUrl: '$assetPrefix/img_2.jpeg',
  ),
  Photo(
    title: '경주 여행, 보문단지 예쁜 카페에서',
    subtitle: '여기 디저트 존맛이었지~?',
    imageUrl: '$assetPrefix/img_3.jpeg',
  ),
  Photo(
    title: '경주 여행, 신라 한복 체험',
    subtitle: '한복 입고 거울 앞에서 한 컷',
    imageUrl: '$assetPrefix/img_4.jpeg',
  ),
  Photo(
    title: '경주 여행, 첨성대 장군?',
    subtitle: '오! 흑검 장군님?!!',
    imageUrl: '$assetPrefix/img_5.jpeg',
  ),
  Photo(
    title: '경주 여행, 닝닝 공주!',
    subtitle: '나는야 닝닝이~',
    imageUrl: '$assetPrefix/img_6.jpeg',
  ),
];
