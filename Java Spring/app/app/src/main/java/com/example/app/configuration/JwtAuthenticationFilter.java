package com.example.app.configuration;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.example.app.readonly.AccountProjection;
import com.example.app.readonly.AccountRoles;
import com.example.app.services.AccountService;
import org.springframework.beans.factory.annotation.Value;
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
import java.util.Objects;

public class JwtAuthenticationFilter extends BasicAuthenticationFilter {

    private static final String TOKEN_HEADER = "Authorization";
    private static final String TOKEN_PREFIX = "Bearer ";
    private final String secret;
    private final AccountService accountService;

    public JwtAuthenticationFilter(final AuthenticationManager authenticationManager,
                                   final @Value("${jwt.secret}") String secret,
                                   final AccountService accountService) {
        super(authenticationManager);
        this.secret = secret;
        this.accountService = accountService;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response,
                                    FilterChain chain) throws IOException, ServletException {
        final UsernamePasswordAuthenticationToken authenticationToken = getAuthentication(request);
        if(Objects.isNull(authenticationToken)){
            chain.doFilter(request, response);
            return;
        }
        SecurityContextHolder.getContext().setAuthentication(authenticationToken);
        chain.doFilter(request, response);
    }

    private UsernamePasswordAuthenticationToken getAuthentication(HttpServletRequest request) {
        final String token = request.getHeader(TOKEN_HEADER);
        if(Objects.nonNull(token) && token.startsWith(TOKEN_PREFIX)){
            final String login = JWT.require(Algorithm.HMAC512(secret))
                    .build()
                    .verify(token.replace(TOKEN_PREFIX, ""))
                    .getSubject();
            if(Objects.nonNull(login)){
                final AccountProjection authenticatedAccountPrinciple =
                        getAuthenticatedAccountPrinciple(accountService, login);
                return new UsernamePasswordAuthenticationToken(authenticatedAccountPrinciple,
                        null, Collections
                        .singletonList(new SimpleGrantedAuthority(AccountRoles.AUTHENTICATED_ACCOUNT.name())));
            }
        }
        return null;
    }

    private AccountProjection getAuthenticatedAccountPrinciple(final AccountService accountService,
                                                               final String login) {
        return accountService.findAccountByLogin(login);
    }

    @Override
    protected boolean shouldNotFilter(HttpServletRequest request) {
        return request.getRequestURI().equals("/register") ||
                request.getRequestURI().equals("/loginToApp");
    }
}
