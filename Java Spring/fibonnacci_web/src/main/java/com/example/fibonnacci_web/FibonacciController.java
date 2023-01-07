package com.example.fibonnacci_web;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/app")
public class FibbonacciController {

    @GetMapping("/generate")
    public String getFibbonacciNumber(final int number){
        return "Fibbonnacci";
    }
}
