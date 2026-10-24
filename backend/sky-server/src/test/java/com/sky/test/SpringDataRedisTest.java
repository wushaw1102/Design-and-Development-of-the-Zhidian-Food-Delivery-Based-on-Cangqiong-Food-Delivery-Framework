package com.sky.test;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.redis.core.*;

import java.util.List;
import java.util.Set;
import java.util.concurrent.TimeUnit;

//@SpringBootTest
public class SpringDataRedisTest {
    //@Autowired
    private RedisTemplate redisTemplate;

    //@Test
    public void testRedisTemplate(){
        System.out.println(redisTemplate);
        ValueOperations valueOperations = redisTemplate.opsForValue();
        HashOperations hashOperations = redisTemplate.opsForHash();
        ListOperations listOperations = redisTemplate.opsForList();
        SetOperations setOperations = redisTemplate.opsForSet();
        ZSetOperations zSetOperations = redisTemplate.opsForZSet();
    }

    /**
     * 操作字符串类型的数据
     */
    //Test
    public void testString(){
        //set get setex setnx
        ValueOperations valueOperations = redisTemplate.opsForValue();
        valueOperations.set("city","北京");
        String city = (String) valueOperations.get("city");
        System.out.println(city);
        valueOperations.set("code","1234",3, TimeUnit.MINUTES);
        valueOperations.setIfAbsent("lock", "1");
        valueOperations.setIfAbsent("lock", "2");
    }

    /**
     * 操作Hash类型数据
     */
    //@Test
    public void testHash(){
        //hset hget hdel hkeys hvals
        HashOperations hashOperations = redisTemplate.opsForHash();
        hashOperations.put("99", "name","cp");
        hashOperations.put("99", "age","20");

        String name = (String) hashOperations.get("99", "name");
        System.out.println(name);

        Set keys = hashOperations.keys("99");
        System.out.println(keys);
        List values = hashOperations.values("99");
        System.out.println(values);

        hashOperations.delete("99", "age");
    }
}
