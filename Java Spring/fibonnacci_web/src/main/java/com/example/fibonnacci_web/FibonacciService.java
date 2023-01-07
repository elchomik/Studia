package com.example.fibonnacci_web;

import org.springframework.stereotype.Service;

import java.math.BigInteger;

@Service
public class FibbonnacciService {


    private BigInteger[] matrixPow(BigInteger[] matrix, int n) {
        if(n<0){
            throw new IllegalArgumentException();
        }

        BigInteger[] result = {BigInteger.ONE, BigInteger.ZERO, BigInteger.ZERO, BigInteger.ONE};
        while(n!=0) {
            if(n%2!=0) {
                result = matrixMultiply(result, matrix);
            }
                n/=2;
                matrix = matrixMultiply(matrix, matrix);
        }
        return result;
    }

    private static BigInteger[] matrixMultiply(BigInteger[] x, BigInteger[] y) {
        return new BigInteger[] {
                multiply(x[0], y[0]).add(multiply(x[1],y[2])),
                multiply(x[0], y[1]).add(multiply(x[1],y[3])),
                multiply(x[2], y[0]).add(multiply(x[3],y[2])),
                multiply(x[2],y[1]).add(multiply(x[3],y[3]))
        };
    }

    private static BigInteger multiply(BigInteger x, BigInteger y) {
        return x.multiply(y);
    }
}
