package com.example.backend.skill;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(value = "/api",method={RequestMethod.GET,RequestMethod.POST})
public class SkillController {
}
