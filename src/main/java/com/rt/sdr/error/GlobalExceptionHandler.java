package com.rt.sdr.error;

import javax.servlet.http.HttpServletRequest;
import javax.validation.ConstraintViolationException;

import org.springframework.ui.Model;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.NoHandlerFoundException;

@ControllerAdvice
public class GlobalExceptionHandler {

    // 🔴 404 - Page Not Found
    @ExceptionHandler(NoHandlerFoundException.class)
    public String handle404(Model model) {
        model.addAttribute("error", "Page not found");
        
        return "error";
    }

    // 🔴 405 - Method Not Allowed
    @ExceptionHandler(HttpRequestMethodNotSupportedException.class)
    public String handle405(Model model) {
        model.addAttribute("error", "Invalid request method");
        return "error";
    }

    // 🔴 Missing parameters
    @ExceptionHandler(MissingServletRequestParameterException.class)
    public String handleMissingParam(
            MissingServletRequestParameterException ex,
            Model model,
            HttpServletRequest request) {

        model.addAttribute("error", "Required information is missing.");

        return resolvePage(request);
    }

    // 🔴 Validation errors
    @ExceptionHandler(ConstraintViolationException.class)
    public String handleValidationError(
            ConstraintViolationException ex,
            Model model,
            HttpServletRequest request) {

        model.addAttribute("error", "Invalid input. Please check your details.");
        return resolvePage(request);
    }

    // 🔴 Business logic errors (OTP, password mismatch, etc.)
    @ExceptionHandler(IllegalArgumentException.class)
    public String handleIllegalArgument(
            IllegalArgumentException ex,
            Model model,
            HttpServletRequest request) {

        model.addAttribute("error", ex.getMessage());
        return resolvePage(request);
    }

    // 🔴 Fallback
    @ExceptionHandler(Exception.class)
    public String handleAllExceptions(
            Exception ex,
            Model model) {

        model.addAttribute("error",
                "Something went wrong. Please try again later.");
        return "error";
    }

    // 🔁 Decide which page to return
    private String resolvePage(HttpServletRequest request) {
        String uri = request.getRequestURI();

        if (uri.contains("verify-otp")) return "verify-otp";
        if (uri.contains("reset-password")) return "reset-password";
        if (uri.contains("login")) return "login";
        if (uri.contains("register")) return "register";

        return "error";
    }
}
