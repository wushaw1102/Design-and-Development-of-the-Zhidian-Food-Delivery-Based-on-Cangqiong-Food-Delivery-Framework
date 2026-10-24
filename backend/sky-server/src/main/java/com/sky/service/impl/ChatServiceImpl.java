package com.sky.service.impl;

import com.google.gson.Gson;
import com.sky.controller.admin.ReportController;
import com.sky.service.ChatService;
import com.sky.service.ReportService;
import com.sky.vo.SalesTop10ReportVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.io.InputStream;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;


@Service
public class ChatServiceImpl implements ChatService {

    private static  String API_KEY;
    private static  String API_URL;

    @Autowired
    private  RestTemplate restTemplate;
    @Autowired
    private ReportService reportService;
    static {
        Properties properties = new Properties();
        try {

            InputStream is = ChatServiceImpl.class.getResourceAsStream("/config.properties");
            properties.load(is);
            API_KEY = properties.getProperty("key");
            API_URL = properties.getProperty("url");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
    @Override
    public String ask(String content) {
        // 创建消息列表
        List<Message> messages = new ArrayList<>();
        content = "问题:" + content;
        messages.add(new Message("user", content));

        LocalDate dateBegin = LocalDate.now().minusDays(30);
        LocalDate dateEnd = LocalDate.now();
        SalesTop10ReportVO salesTop10 = reportService.getSalesTop10(dateBegin, dateEnd);
        String content1 = "菜品销量数据:" + salesTop10.toString() + ",问题中没问有关菜品销量数据有关数据时，就当没看到菜品销量数据，正常回答";
        messages.add(new Message("assistant", content1));

        // 构建请求体
        ChatRequest requestBody = new ChatRequest(
                "deepseek-chat",  // 模型名称，根据文档调整
                messages,
                0.7,  // temperature
                1000  // max_tokens
        );

        // 发送请求
        return sendRequest(requestBody);
    }

    private String sendRequest(ChatRequest requestBody) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("Authorization", "Bearer " + API_KEY);

        HttpEntity<String> requestEntity = new HttpEntity<>(new Gson().toJson(requestBody), headers);

        try {
            ResponseEntity<String> response = restTemplate.postForEntity(API_URL, requestEntity, String.class);
            if (response.getStatusCode().is2xxSuccessful()) {
                // 解析响应
                ChatResponse chatResponse = new Gson().fromJson(response.getBody(), ChatResponse.class);
                return chatResponse.getChoices().get(0).getMessage().getContent();
            } else {
                return "请求失败，状态码: " + response.getStatusCode() + ", 响应: " + response.getBody();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "请求异常: " + e.getMessage();
        }
    }

    // 内部类定义请求/响应结构
    static class Message {
        private String role;
        private String content;

        public Message(String role, String content) {
            this.role = role;
            this.content = content;
        }

        public String getContent() {
            return content;
        }
    }

    public static class ChatRequest {
        private String model;
        private List<Message> messages;
        private double temperature;
        private int max_tokens;

        public ChatRequest(String model, List<Message> messages, double temperature, int max_tokens) {
            this.model = model;
            this.messages = messages;
            this.temperature = temperature;
            this.max_tokens = max_tokens;
        }
    }
    static class ChatResponse {
        private List<Choice> choices;

        public List<Choice> getChoices() {
            return choices;
        }

        static class Choice {
            private Message message;

            public Message getMessage() {
                return message;
            }
        }
    }
}
