function refinamentomalha



t =230;

for I = 5:-1:3
    %%%%%%%%% Computing Referece solution %%%%%%%
    n_exp = 10-I;   N = 2^n_exp;
    m_exp = 8-I;    M = 2^m_exp;
    
    %[u , E , FIG_name];
     PRINCIPALSEMIBIFASICO4(t,n_exp,m_exp);
    
end






end
