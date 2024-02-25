MOTIVATION: Introducing the example of a combinatorics problem solved by:
- Linear approach formulation
- Simulation the stochastic behavior using SAS

PROBLEM: Say you draw a circle and choose two chords at random. 
What is the probability that those chords will intersect?

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

A solution x=(s0, t0) of Ax=b, for A and b given, represents the two chords intersect each other only if x is in [0,1].
Cases:
- If the matrix is singular, saying that chords had the same slope, we will assume 
the chords do not intersect for this example, discarding the trivvial case when p=q.
- If the solution is not unique, then the chords do not intersect.
 
