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

    private static final String API_KEY =
            System.getenv("OPENAI_API_KEY");
    

    private static final String OPENAI_URL = "https://api.openai.com/v1/responses";

    static {
        System.out.println("OPENAI_API_KEY from env = " + API_KEY);
    }
    
    public String generateMessage(
            String event,
            String name,
            String relationship,
            String tone,
            String length
    ) {
        try {
            String apiKey = System.getenv("OPENAI_API_KEY");

            if (apiKey == null || apiKey.isEmpty()) {
                return "OPENAI_API_KEY not found in environment";
            }

            String prompt = buildPrompt(event, name, relationship, tone, length);

            JSONObject body = new JSONObject();
            body.put("model", "gpt-4.1-mini");
            body.put("input", prompt);

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create("https://api.openai.com/v1/responses"))
                    .header("Authorization", "Bearer " + apiKey)
                    .header("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(body.toString()))
                    .build();

            HttpClient client = HttpClient.newHttpClient();
            HttpResponse<String> response =
                    client.send(request, HttpResponse.BodyHandlers.ofString());

            System.out.println("OPENAI RESPONSE:\n" + response.body());

            JSONObject json = new JSONObject(response.body());

            return json
                    .getJSONArray("output")
                    .getJSONObject(0)
                    .getJSONArray("content")
                    .getJSONObject(0)
                    .getString("text");

        } catch (Exception e) {
            e.printStackTrace();
            return "Error generating message.";
        }
    }


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
    
    public String chat(String userMessage) {
        try {
            String apiKey = System.getenv("OPENAI_API_KEY");

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

            JSONObject body = new JSONObject();
            body.put("model", "gpt-4.1-mini");

            JSONArray input = new JSONArray();
            input.put(new JSONObject()
                    .put("role", "system")
                    .put("content", systemPrompt));

            input.put(new JSONObject()
                    .put("role", "user")
                    .put("content", userMessage));

            body.put("input", input);

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create("https://api.openai.com/v1/responses"))
                    .header("Authorization", "Bearer " + apiKey)
                    .header("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(body.toString()))
                    .build();

            HttpClient client = HttpClient.newHttpClient();
            HttpResponse<String> response =
                    client.send(request, HttpResponse.BodyHandlers.ofString());

            JSONObject json = new JSONObject(response.body());

            return json.getJSONArray("output")
                    .getJSONObject(0)
                    .getJSONArray("content")
                    .getJSONObject(0)
                    .getString("text");

        } catch (Exception e) {
            e.printStackTrace();
            return "Something went wrong Mitra.";
        }
    }

}
