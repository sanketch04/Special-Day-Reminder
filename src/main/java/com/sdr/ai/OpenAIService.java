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

    private static final String OPENAI_URL = "https://api.openai.com/v1/responses";

    static {
        System.out.println("OPENAI_API_KEY from env = " + System.getenv("OPENAI_API_KEY"));
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
            String apiKey = System.getenv("OPENAI_API_KEY");
            if (apiKey == null || apiKey.isBlank()) {
                return "OPENAI_API_KEY not found in environment.";
            }

            String prompt = buildPrompt(event, name, relationship, tone, length);

            JSONObject body = new JSONObject();
            body.put("model", "gpt-4.1-mini");
            body.put("input", prompt);

            HttpResponse<String> response = sendRequest(apiKey, body);
            return extractText(response.body());

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
            String apiKey = System.getenv("OPENAI_API_KEY");
            if (apiKey == null || apiKey.isBlank()) {
                return "OPENAI_API_KEY not found in environment.";
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

            JSONArray input = new JSONArray();
            input.put(new JSONObject()
                    .put("role", "system")
                    .put("content", systemPrompt));
            input.put(new JSONObject()
                    .put("role", "user")
                    .put("content", userMessage));

            JSONObject body = new JSONObject();
            body.put("model", "gpt-4.1-mini");
            body.put("input", input);

            HttpResponse<String> response = sendRequest(apiKey, body);
            return extractText(response.body());

        } catch (Exception e) {
            e.printStackTrace();
            return "Something went wrong Mitra.";
        }
    }

    // -----------------------------
    // HTTP call (shared)
    // -----------------------------
    private HttpResponse<String> sendRequest(String apiKey, JSONObject body) throws Exception {
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(OPENAI_URL))
                .header("Authorization", "Bearer " + apiKey)
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(body.toString()))
                .build();

        HttpClient client = HttpClient.newHttpClient();
        HttpResponse<String> response =
                client.send(request, HttpResponse.BodyHandlers.ofString());

        System.out.println("RAW OPENAI RESPONSE:\n" + response.body());
        return response;
    }

    // -----------------------------
    // SAFE response parser
    // -----------------------------
    private String extractText(String responseBody) {
        JSONObject json = new JSONObject(responseBody);

        // ✅ New Responses API shortcut
        if (json.has("output_text")) {
            return json.getString("output_text");
        }

        // ✅ Structured response fallback
        if (json.has("output")) {
            return json.getJSONArray("output")
                    .getJSONObject(0)
                    .getJSONArray("content")
                    .getJSONObject(0)
                    .getString("text");
        }

        // ❌ OpenAI error
        if (json.has("error")) {
            return "OpenAI error: " +
                    json.getJSONObject("error").optString("message", "Unknown error");
        }

        // ❓ Unexpected format
        return "Unexpected OpenAI response: " + responseBody;
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
