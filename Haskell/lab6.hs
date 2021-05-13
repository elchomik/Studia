delta a b c = if a/=0 then b*b-4*a*c else error "Nie można policzyć delty"
delta a b c= b*b-4*a*c

pdelta a b c= if delta>0 then sqrt(delta)
              else if delta==0 then 0
              else error "Delta mniejsza od zera"
               where
               delta=b*b-4*a*c


miejscaZerowe a b c= if a==0 then error "Paremetr a musi być rózny od zera"
                     else if delta<0 then error "Delta nie może być mniejsza od zera"
                     else if delta==0 then [jednoZero,jednoZero]
                     else [x,y]
                      where 
                      delta=b*b-4*a*c
                      x=jednoZero-sqrt delta/(2*a)
                      y=jednoZero+ sqrt delta/(2*a)
                      jednoZero= -b/(2*a)

miejscaZerowe a b c= if delta<0 then error "Delta nie może być mniejsza od zera"
                     else if delta==0 then [jednoZero]
                     else [x,y]
                      where 
                      delta=b*b-4*a*c
                      x=jednoZero-sqrt delta/(2*a)
                      y=jednoZero+ sqrt delta/(2*a)
                      jednoZero= -b/(2*a)


miejscaZerowe a b c= if delta<0 then error "Delta nie może być mniejsza od zera"
                     else (x,y)
                      where 
                      delta=b*b-4*a*c
                      x=jednoZero-sqrt delta/(2*a)
                      y=jednoZero+ sqrt delta/(2*a)
                      jednoZero=(-b/2*a)