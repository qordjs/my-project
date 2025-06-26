package com.example.backend.api;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(value = "/api",method={RequestMethod.GET,RequestMethod.POST})
public class ApiController {
    @GetMapping("/hello")
    public String hello() {
        return "Hello World";
    }
}
