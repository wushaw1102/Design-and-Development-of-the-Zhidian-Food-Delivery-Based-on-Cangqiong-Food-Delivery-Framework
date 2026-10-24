package com.sky.controller.admin;

import com.sky.result.Result;
import com.sky.service.ChatService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/admin/chat")
@Api(tags = "Chat接口")
public class ChatController {

    @Autowired
    private  ChatService chatService;

    @ApiOperation("Ask")
    @PostMapping
    public Result<String> ask(String question) {
        if ("bye".equals(question)) {
            return Result.success("拜拜，欢迎下次使用！");
        }
        String response = chatService.ask(question);
        return Result.success(response);
    }
}
