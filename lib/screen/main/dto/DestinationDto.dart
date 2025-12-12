//여행지 데이터 추상화
class DestinationDto {
  final int id;
  final String image;
  final String destination;
  final String discount;

  //실제로 이런식으로 많이 사용
  const DestinationDto({
    required this.id,
    required this.image,
    required this.destination,
    required this.discount,
  });
  
}