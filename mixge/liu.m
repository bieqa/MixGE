function Qq = liu(q,lambda)

c1 = sum(lambda,1);
c2 = sum(lambda.^2,1);
c3 = sum(lambda.^3,1);
c4 = sum(lambda.^4,1);

s1 = c3 ./ c2.^(3/2);
s2 = c4 ./ c2.^2;

muQ = c1;
sigmaQ = sqrt(2*c2);
tstar = (q-muQ) ./ sigmaQ;


a2 = 1 ./ (s1 - sqrt(s1.^2 - s2));
delta2 = s1 .* a2.^3 - a2.^2;
l2 = a2.^2 - 2*delta2;

a1 = 1 ./ s1;
delta1 = zeros(1,size(lambda,2));
l1 = c2.^3 ./ c3.^2;

idx = (s1.^2 > s2) + 1;
idx = sub2ind([2,size(lambda,2)],idx,1:size(lambda,2));

a = [a1;a2];
a = a(idx);
delta = [delta1;delta2];
delta = delta(idx);
l = [l1;l2];
l = l(idx);


muX = l + delta;
sigmaX = sqrt(2) * a;

Qq = 1 - ncx2cdf(tstar.*sigmaX+muX, l, delta);

end