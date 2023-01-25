class NoteValidator {
  const NoteValidator._();

  static bool hasValidTitle(String title) => title.isNotEmpty;

  static bool hasValidContent(String email) => email.isNotEmpty;
}
