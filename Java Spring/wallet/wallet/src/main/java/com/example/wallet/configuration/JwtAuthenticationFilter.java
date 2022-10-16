package com.example.wallet.configuration;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.example.wallet.privilleges.roles.UserRoles;
import com.example.wallet.readonly.User;
import com.example.wallet.services.UserService;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collections;


public class JwtAuthenticationFilter extends BasicAuthenticationFilter {

    private static final String TOKEN_HEADER = "Authorization";
    private static final String TOKEN_PREFIX = "Bearer ";
    private final UserService userService;
    private final String secret;

    public JwtAuthenticationFilter(final AuthenticationManager authenticationManager,
                                   final UserService userDetailsService, final String secret) {
        super(authenticationManager);
        this.userService = userDetailsService;
        this.secret = secret;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws IOException, ServletException {
        UsernamePasswordAuthenticationToken authenticationToken = getAuthentication(request);

        if (authenticationToken == null) {
            chain.doFilter(request, response);
            return;
        }
        SecurityContextHolder.getContext().setAuthentication(authenticationToken);
        chain.doFilter(request, response);
    }

    private UsernamePasswordAuthenticationToken getAuthentication(HttpServletRequest request) {
        String token = request.getHeader(TOKEN_HEADER);
        if (token != null && token.startsWith(TOKEN_PREFIX)) {
            String userName = JWT.require(Algorithm.HMAC512(secret))
                    .build()
                    .verify(token.replace(TOKEN_PREFIX, ""))
                    .getSubject();
            if (userName != null) {
                User authenticatedUserPriniciple = getAuthenticatedUserPriniciple(userService, userName);
                return new UsernamePasswordAuthenticationToken(authenticatedUserPriniciple, null,
                        Collections.singletonList(new SimpleGrantedAuthority(UserRoles.AUTHENTICATED_USER.name())));
            }
        }
        return null;
    }

    private User getAuthenticatedUserPriniciple(final UserService userService, final String userName) {
        return userService.findUserByLogin(userName);
    }
}
