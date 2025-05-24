class CreateGroupState {
  final bool isLoading;
  final String? error;

  const CreateGroupState({this.isLoading = false, this.error});

  CreateGroupState copyWith({bool? isLoading, String? error}) {
    return CreateGroupState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
} 