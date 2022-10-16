package com.example.wallet.configuration;

import com.example.wallet.webui.UserDTO;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;

public class JsonObjectAuthenticationFilter extends UsernamePasswordAuthenticationFilter {

    private final ObjectMapper objectMapper;

    public JsonObjectAuthenticationFilter(final ObjectMapper objectMapper) {
        this.objectMapper = objectMapper;
    }

    @Override
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) throws AuthenticationException {
        try{
            BufferedReader reader = request.getReader();
            StringBuilder builder = new StringBuilder();
            String line;
            while((line = reader.readLine())!=null){
                builder.append(line);
            }
            UserDTO authRequest = objectMapper.readValue(builder.toString(), UserDTO.class);
            UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(authRequest.getLogin(), authRequest.getPasswordHash());
            setDetails(request, token);
            return this.getAuthenticationManager().authenticate(token);

        }catch (IOException e){
            throw new IllegalArgumentException(e.getMessage());
        }
    }
}
