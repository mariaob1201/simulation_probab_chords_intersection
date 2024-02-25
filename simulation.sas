/*
PROBLEM: Say you draw a circle and choose two chords at random. 
What is the probability that those chords will intersect?
*/

/*
MATH FORMULATION:
Given p=(p1,p2), q=(q1,q2), any chords in the unit circle, where p1, p2 are the endpoints in
the unit circle, as vectors itselves, 
and lambda_p, lambda_q the parametrization function of those:
lamba_p(s)=(1-s)*p1+s*p2, respectively lambda_q(t), for s,t i [0,1].

The points p and q intersect if there is s0, t0 such that lambda_p(s0)=lambda_q(t0).

Writing down the condition into a matrix way, 
x=(s,t)T
A=(vector(p1-p2)T, vector(q1-q2)T)
b=q1-p1


A solution x of Ax=b represents the two chords intersect each other if it is in [0,1].
If the solution is not uique, then the chords do not intersect.
If the matrix is singular, saying that chords had the same slope, we will assume 
the chords do not intersect for this example, discarding the trivvial case when p=q.
 
*/

proc iml;
/* Find the intersection between 2D line segments [p1,p2] and [q1,q2].
   This function assumes that the line segments have different slopes (A is nonsingular) */
start IntersectSegsSimple(p1, p2, q1, q2);
   b = colvec(q1 - p1); 
   A = colvec(p2-p1) || colvec(q1-q2); /* nonsingular when segments have different slopes */
   x = solve(A, b);                    /* x = (s,t) */
   if all(0<=x && x<=1) then           /* if x is in [0,1] x [0,1] */
      return (1-x[1])*p1 + x[1]*p2;    /* return intersection */
   else                                /* otherwise, segments do not intersect */
      return ({. .});                  /* return missing values */
finish;
 
/* Generate two random chords on the unit circle.
   Simulate the probability that they intersect  */
N = 1e5;
theta = j(N, 4);
call randseed(123456);
call randgen(theta, "uniform", 0, 2*constant('pi'));
intersect = j(N,1,0);

do i = 1 to N;
   t = theta[i,]`;                 /* 4 random U(0, 2*pi) */
   pts = cos(t) || sin(t);         /* 4 pts on unit circle */
   p1 = pts[1,];    p2 = pts[2,];
   q1 = pts[3,];    q2 = pts[4,];
   intersect[i] = all(IntersectSegsSimple(p1, p2, q1, q2) ^= .);
end;
 
prob = mean(intersect);
print prob;