import 'package:flutter_test/flutter_test.dart';
import 'package:makharej_app/core/utils/extensions/string_extension.dart';

void main() {
  const validEmail = 'example@example.com';
  const invalidEmail = 'example';
  const weakPassword = 'password';
  const strongPassword = 'Aa1234566789!@';
  group('Validators', () {
    group('isEmail', () {
      test('returns true for valid email', () {
        expect(validEmail.isEmail(), true);
      });

      test('returns false for invalid email', () {
        expect(invalidEmail.isEmail(), false);
      });
    });

    group('isStrongPassword', () {
      test('returns true for strong password', () {
        expect(strongPassword.isStrongPassword(), true);
      });

      test('returns false for weak password', () {
        expect(weakPassword.isStrongPassword(), false);
      });
    });

    group('emailValidator', () {
      test('returns null for valid email', () {
        expect(validEmail.emailValidator(), null);
      });

      test('returns error message for empty email', () {
        const email = '';
        expect(email.emailValidator(), 'Please enter your email');
      });

      test('returns error message for invalid email', () {
        expect(invalidEmail.emailValidator(), 'Please enter a valid email');
      });
    });
  });
}
