Ao = 2;
rhoo = 3;
Eo = 4;
s1 = 0.1;
s2 = 0.2;
s3 = 0.3;
L = 5;
N = 4;

mat = CMaterialProperties(Ao,Eo,rhoo,s1,s2,s3);
ful = CFullMatrices(L,N,mat);

M = ful.mass();
K = ful.stiffness();

[eigVectorsMass,eigValuesMass] = eig(M);
[eigVectorsStiffness,eigValuesStiffness] = eig(K);
