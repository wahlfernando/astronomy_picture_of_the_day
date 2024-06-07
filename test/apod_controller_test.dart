import 'package:flutter_test/flutter_test.dart';
import 'package:astronomy_picture_of_the_day/src/controllers/apod_controller.dart';
import 'package:astronomy_picture_of_the_day/src/models/apod_model.dart';
import 'package:astronomy_picture_of_the_day/src/utils/api_service.dart';
import 'package:mockito/mockito.dart';

// Gerado pelo mockito
class MockAPIService extends Mock implements APIService {}

void main() {
  group('APODController', () {
    late APODController apodController;
    late MockAPIService mockAPIService;

    setUp(() {
      mockAPIService = MockAPIService();
      apodController = APODController();
      apodController.apiService = mockAPIService;
    });

    test('initial values are correct', () {
      expect(apodController.apods, []);
      expect(apodController.isLoading, false);
    });

    test('fetchAPODs sets apods and isLoading correctly', () async {
      final mockAPOD = APODModel(
        date: '2024-06-07',
        explanation: 'Test explanation',
        title: 'Test title',
        url: 'https://example.com/image.jpg',
      );
      when(mockAPIService.fetchAPOD('')).thenAnswer(
        (_) async => {
          'date': mockAPOD.date,
          'explanation': mockAPOD.explanation,
          'title': mockAPOD.title,
          'url': mockAPOD.url,
        },
      );

      expect(apodController.isLoading, false);
      final dates = ['2024-06-07'];

      final future = apodController.fetchAPODs(dates);

      expect(apodController.isLoading, true);
      await future;
      expect(apodController.isLoading, false);

      expect(apodController.apods.length, 1);
      expect(apodController.apods.first.date, mockAPOD.date);
      expect(apodController.apods.first.explanation, mockAPOD.explanation);
      expect(apodController.apods.first.title, mockAPOD.title);
      expect(apodController.apods.first.url, mockAPOD.url);
    });

    test('fetchAPODs handles empty dates list correctly', () async {
      final dates = <String>[];

      await apodController.fetchAPODs(dates);

      expect(apodController.apods, []);
      expect(apodController.isLoading, false);
    });

    test('fetchAPODs handles API errors gracefully', () async {
      when(mockAPIService.fetchAPOD('')).thenThrow(Exception('API error'));

      final dates = ['2024-06-07'];

      await apodController.fetchAPODs(dates);

      expect(apodController.apods, []);
      expect(apodController.isLoading, false);
    });
  });
}
