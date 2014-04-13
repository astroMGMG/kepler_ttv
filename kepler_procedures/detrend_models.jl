# a two-parameter linear model
linearmodel(xpts, p) = p[1] + xpts.*p[2];

# a three-parameter quadratic model
quadmodel(xpts, p) = p[1] + xpts.*p[2] + p[3].*xpts.^2;

# a four-parameter cubic model
cubicmodel(xpts, p) = p[1] + xpts.*p[2] + p[3].*xpts.^2 + p[4].*xpts.^3;
