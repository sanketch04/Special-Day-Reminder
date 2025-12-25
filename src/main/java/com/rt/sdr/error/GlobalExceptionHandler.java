package com.rt.sdr.error;

import org.springframework.ui.Model;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.NoHandlerFoundException;

import javax.validation.ConstraintViolationException;

@ControllerAdvice
public class GlobalExceptionHandler {
	
	// 🔴 404 - URL NOT FOUND
	@ExceptionHandler(NoHandlerFoundException.class)
	public String handle404(Model model) {
	    model.addAttribute("error", "Page not found");
	    return "error";
	}

	// 🔴 405 - METHOD NOT ALLOWED
	@ExceptionHandler(HttpRequestMethodNotSupportedException.class)
	public String handle405(Model model) {
	    model.addAttribute("error", "Invalid request method");
	    return "error";
	}
	
    // 🔴 Missing request parameter (email, otp, etc.)
    @ExceptionHandler(MissingServletRequestParameterException.class)
    public String handleMissingParam(
            MissingServletRequestParameterException ex,
            Model model) {

        model.addAttribute("error",
                "Required information is missing. Please try again.");

        return "error"; // error.jsp
    }

    // 🔴 Validation errors (Hibernate Validator)
    @ExceptionHandler(ConstraintViolationException.class)
    public String handleValidationError(
            ConstraintViolationException ex,
            Model model) {

        model.addAttribute("error",
                "Invalid input. Please check your details.");

        return "error";
    }

    // 🔴 Illegal arguments (OTP mismatch, expired OTP, etc.)
    @ExceptionHandler(IllegalArgumentException.class)
    public String handleIllegalArgument(
            IllegalArgumentException ex,
            Model model) {

        model.addAttribute("error", ex.getMessage());
        return "error";
    }

    // 🔴 Generic fallback (ANY unexpected error)
    @ExceptionHandler(Exception.class)
    public String handleAllExceptions(
            Exception ex,
            Model model) {
        model.addAttribute("error",
                "Something went wrong. Please try again later.");

        return "error";
    }
}
