import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:odoo_apexive/blocs/timesheets_api_bloc/timesheets_api_bloc.dart';
import 'package:odoo_apexive/data/api/custom_exception.dart';
import 'package:odoo_apexive/data/api/result.dart';
import 'package:odoo_apexive/data/repository/timesheets_repo.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:odoo_apexive/utils/mock_creators.dart';

class MockTimesheetsRepo extends Mock implements TimesheetsRepo {}

void main() {
  late TimesheetsApiBloc bloc;
  late MockTimesheetsRepo mockTimesheetsRepo;

  setUp(() {
    mockTimesheetsRepo = MockTimesheetsRepo();
    bloc = TimesheetsApiBloc(mockTimesheetsRepo);
  });

  test('initial state is TimesheetsApiInitial', () {
    expect(bloc.state, equals(TimesheetsApiInitial()));
  });

  group('LoadProjectsEvent', () {
    blocTest(
      'emits [DataLoading, ProjectsLoaded] when timesheetsRepo.fetchProjects returns projects',
      build: () {
        when(() => mockTimesheetsRepo.fetchProjects())
            .thenAnswer((_) async => Success(MockDTO.projects));
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadProjectsEvent()),
      expect: () => [
        DataLoading(),
        ProjectsLoaded(MockDTO.projects),
      ],
    );

    blocTest(
      'emits [DataLoading, TimesheetsApiProjectsRequestError] when timesheetsRepo.fetchProjects throws an error',
      build: () {
        when(() => mockTimesheetsRepo.fetchProjects()).thenAnswer(
          (_) async => Failure(ResultException('Error fetching projects')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const LoadProjectsEvent()),
      expect: () => [
        DataLoading(),
        TimesheetsApiProjectsRequestError(error: 'Error fetching projects'),
      ],
    );
  });

  group('LoadTasksEvent', () {
    final project = MockDTO.projects[0];
    blocTest(
      'emits [DataLoading, TasksLoaded] when timesheetsRepo.fetchTasks returns tasks',
      build: () {
        when(() => mockTimesheetsRepo.fetchTasks(project: project))
            .thenAnswer((_) async => Success(MockDTO.tasks));
        return bloc;
      },
      act: (bloc) => bloc.add(LoadTasksEvent(project: project)),
      expect: () => [
        DataLoading(),
        TasksLoaded(MockDTO.tasks),
      ],
    );

    blocTest(
      'emits [DataLoading, TimesheetsApiTasksRequestError] when timesheetsRepo.fetchTasks throws an error',
      build: () {
        when(() => mockTimesheetsRepo.fetchTasks(project: project)).thenAnswer(
          (_) async => Failure(ResultException('Error fetching tasks')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(LoadTasksEvent(project: project)),
      expect: () => [
        DataLoading(),
        TimesheetsApiTasksRequestError(error: 'Error fetching tasks'),
      ],
    );
  });

  tearDown(() {
    bloc.close();
  });
}
