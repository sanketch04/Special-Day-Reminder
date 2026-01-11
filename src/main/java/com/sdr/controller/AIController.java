package com.sdr.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sdr.ai.OpenAIService;

@Controller
@RequestMapping("/OpenAI")
public class AIController {

    @Autowired
    private OpenAIService openAIService;

    @GetMapping("/ai-chat")
    public String aiPage(HttpSession session) {
        if (session.getAttribute("loggedUser") == null) {
            return "redirect:/login";
        }
        return "ai-chat";
    }

    @PostMapping("/ai/generate")
    public String generate(
            @RequestParam String event,
            @RequestParam String name,
            @RequestParam String relationship,
            @RequestParam String tone,
            @RequestParam String length,
            Model model
    ) {

        String message = openAIService.generateMessage(
                event, name, relationship, tone, length
        );

        model.addAttribute("generatedMessage", message);
        return "ai-chat";
    }
    @GetMapping("/chat")
    public String chatPage(HttpSession session) {
        if (session.getAttribute("loggedUser") == null) {
            return "redirect:/login";
        }
        return "ai-chat";
    }

    @PostMapping("/chat/send")
    @ResponseBody
    public String chatSend(@RequestParam("message") String message) {
        return openAIService.chat(message);
    }

}
