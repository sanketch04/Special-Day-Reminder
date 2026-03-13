package com.sdr.ai;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Service;

@Service
public class OpenAIService {

    private static final String GROQ_URL = "https://api.groq.com/openai/v1/chat/completions";
    private static final String MODEL = "llama-3.1-8b-instant";

    // API key from environment variable
    private static final String GROQ_API_KEY = System.getenv("GROK_API");

    static {
        System.out.println("GROQ_API_KEY loaded: " + (GROQ_API_KEY != null));
    }

    // -----------------------------
    // Generate predefined message
    // -----------------------------
    public String generateMessage(
            String event,
            String name,
            String relationship,
            String tone,
            String length
    ) {
        try {
            String prompt = buildPrompt(event, name, relationship, tone, length);
            return chat(prompt);

        } catch (Exception e) {
            e.printStackTrace();
            return "Error generating message.";
        }
    }

    // -----------------------------
    // Chat-style message
    // -----------------------------
    public String chat(String userMessage) {
        try {

            if (GROQ_API_KEY == null || GROQ_API_KEY.isBlank()) {
                return "Groq API key not found. Please set GROQ_API_KEY environment variable.";
            }

            String systemPrompt = """
                You are an AI assistant for writing messages.
                Rules:
                - Do NOT explain anything
                - Do NOT add greetings like "Sure" or "Here you go"
                - Output ONLY the final content
                - Use clean formatting
                - If email is requested, include Subject and proper email body
                - If message is requested, keep it short and ready to copy
                """;

            JSONArray messages = new JSONArray();
            messages.put(new JSONObject()
                    .put("role", "system")
                    .put("content", systemPrompt));

            messages.put(new JSONObject()
                    .put("role", "user")
                    .put("content", userMessage));

            JSONObject body = new JSONObject();
            body.put("model", MODEL);
            body.put("messages", messages);
            body.put("temperature", 0.7);
            body.put("max_tokens", 1024);

            HttpResponse<String> response = sendRequest(body);
            return extractText(response.body());

        } catch (Exception e) {
            e.printStackTrace();
            return "Something went wrong.";
        }
    }

    // -----------------------------
    // HTTP request
    // -----------------------------
    private HttpResponse<String> sendRequest(JSONObject body) throws Exception {

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(GROQ_URL))
                .header("Authorization", "Bearer " + GROQ_API_KEY)
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(body.toString()))
                .build();

        HttpClient client = HttpClient.newHttpClient();

        HttpResponse<String> response =
                client.send(request, HttpResponse.BodyHandlers.ofString());

        System.out.println("RAW GROQ RESPONSE:\n" + response.body());

        return response;
    }

    // -----------------------------
    // Extract AI text
    // -----------------------------
    private String extractText(String responseBody) {

        JSONObject json = new JSONObject(responseBody);

        if (json.has("choices")) {
            return json.getJSONArray("choices")
                    .getJSONObject(0)
                    .getJSONObject("message")
                    .getString("content");
        }

        if (json.has("error")) {
            return "Groq error: " +
                    json.getJSONObject("error").optString("message", "Unknown error");
        }

        return "Unexpected response: " + responseBody;
    }

    // -----------------------------
    // Prompt builder
    // -----------------------------
    private String buildPrompt(
            String event,
            String name,
            String relationship,
            String tone,
            String length
    ) {

        return String.format(
                "Write a %s message for %s. Relationship: %s. Tone: %s. Length: %s.",
                event, name, relationship, tone, length
        );
    }
}