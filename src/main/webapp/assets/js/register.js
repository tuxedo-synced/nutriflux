
document.addEventListener("DOMContentLoaded", () => {

    // FORM ELEMENTS

    const form = document.getElementById("registerForm");

    const fullName = document.getElementById("fullName");
    const username = document.getElementById("username");
    const email = document.getElementById("email");
    const password = document.getElementById("password");
    const confirmPassword = document.getElementById("confirmPassword");
    const terms = document.getElementById("terms");


    // ERROR ELEMENTS

    const fullNameError = document.getElementById("fullNameError");
    const usernameError = document.getElementById("usernameError");
    const emailError = document.getElementById("emailError");
    const passwordError = document.getElementById("passwordError");
    const termsError = document.getElementById("termsError");


    // REGEX

    const fullNameRegex = /^[a-zA-Z][a-zA-Z\s.'-]{2,49}$/;

    const usernameRegex = /^[a-zA-Z][a-zA-Z0-9_]{3,19}$/;

    const emailRegex =
        /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;


    // SHOW ERROR

    function showError(input, element, message) {

        element.textContent = "✕ " + message;

        input.classList.add("input-error");
        input.classList.remove("input-valid");

        element.classList.add("error-message");
        element.classList.remove("success-message");
    }


    // CLEAR ERROR

    function clearError(input, element) {

        element.textContent = "";

        input.classList.remove("input-error");
        input.classList.remove("input-valid");

        element.classList.remove("error-message");
        element.classList.remove("success-message");
    }


    // FULL NAME VALIDATION

    function validateFullName() {

        const value = fullName.value.trim();

        if (!value) {

            showError(fullName, fullNameError,
                "Full name is required.");

            return false;
        }

        if (!fullNameRegex.test(value)) {

            showError(fullName, fullNameError,
                "Enter a valid name (3-50 characters).");

            return false;
        }

        clearError(fullName, fullNameError);

        return true;
    }


    // USERNAME VALIDATION

    function validateUsername() {

        const value = username.value.trim();

        if (!value) {

            showError(username, usernameError,
                "Username is required.");

            return false;
        }

        if (!usernameRegex.test(value)) {

            showError(username, usernameError,
                "Username must be 4-20 characters, start with a letter, and contain only letters, numbers, and underscores.");

            return false;
        }

        clearError(username, usernameError);

        return true;
    }


    // EMAIL VALIDATION

    function validateEmail() {

        const value = email.value.trim();

        if (!value) {

            showError(email, emailError,
                "Email address is required.");

            return false;
        }

        if (!emailRegex.test(value)) {

            showError(email, emailError,
                "Please enter a valid email address.");

            return false;
        }

        clearError(email, emailError);

        return true;
    }


    // PASSWORD VALIDATION

    function validatePassword() {

        if (!password.value) {

            showError(confirmPassword, passwordError,
                "Password is required.");

            return false;
        }

        if (password.value.length < 8 ||
            password.value.length > 72) {

            showError(confirmPassword, passwordError,
                "Password must be 8-72 characters.");

            return false;
        }

        if (!confirmPassword.value) {

            showError(confirmPassword, passwordError,
                "Please confirm your password.");

            return false;
        }

        if (password.value !== confirmPassword.value) {

            showError(confirmPassword, passwordError,
                "Re-entered password does not match.");

            return false;
        }

        clearError(confirmPassword, passwordError);

        return true;
    }


    // TERMS VALIDATION

    function validateTerms() {

        if (!terms.checked) {

            termsError.textContent =
                "Please accept the terms before registering.";

            termsError.classList.add("error-message");

            return false;
        }

        termsError.textContent = "";

        termsError.classList.remove("error-message");

        return true;
    }


    // DYNAMIC VALIDATION WHILE TYPING

    fullName.addEventListener("input", validateFullName);

    username.addEventListener("input", validateUsername);

    email.addEventListener("input", validateEmail);

    password.addEventListener("input", validatePassword);

    confirmPassword.addEventListener("input", validatePassword);


    // VALIDATION WHEN LEAVING INPUT

    fullName.addEventListener("blur", validateFullName);

    username.addEventListener("blur", validateUsername);

    email.addEventListener("blur", validateEmail);

    confirmPassword.addEventListener("blur", validatePassword);


    // TERMS CHECKBOX

    terms.addEventListener("change", validateTerms);


    // FORM SUBMISSION VALIDATION

    form.addEventListener("submit", function(event) {

        const fullNameValid = validateFullName();

        const usernameValid = validateUsername();

        const emailValid = validateEmail();

        const passwordValid = validatePassword();

        const termsValid = validateTerms();

        if (
            !fullNameValid ||
            !usernameValid ||
            !emailValid ||
            !passwordValid ||
            !termsValid
        ) {

            event.preventDefault();

        }

    });

});
