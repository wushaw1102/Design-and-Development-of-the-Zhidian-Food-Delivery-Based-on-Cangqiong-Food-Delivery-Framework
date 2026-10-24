package com.sky.task;

import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
@Slf4j
public class MyTask {

    /**
     * 自定义定时任务
     *//*
    @Scheduled(cron = "0/5 * * * * ?")
    public void executeTsk() {
        log.info("定时任务执行了");
    }*/
}
