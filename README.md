# EquivariantToInvariant
Experimental implementations of the $\mathsf{Symmetrize}$ algorithm given in Propositions 18 and 20 on the paper https://www.sciencedirect.com/science/article/pii/S0747717122000992?dgcid using the $\mathsf{Maple}$ computer
algebra system. 

$\mathbf{\large Goal}$

Let $S = S_{l_1} \times \cdots \times S_{l_r}$ with $l_1 + \cdots + l_r = l$ and  $S_{l_i}$ being
the symmetric group of order $l_i!$. Given a sequence $\mathbf{q} = (q_1, \dots, q_l)$ in $\mathbb{K}[z_1, \dots, z_l]$ such that 
 - $\mathbf{q}$ is $S$-equivariant, i.e., $\sigma(q_i) = q_i(z_{\sigma(1)}, \dots, z_{\sigma(l)}) = q_i$ for all $i=1, \dots, l$, and
 - $(z_i - z_j)$ divides $(q_i - q_j)$ for all $1 \le i < j \le l $.

 We want to compute a sequence of polynomials $\mathbf{p} = (p_1, \dots, p_l)$ in $\mathbb{K}[z_1, \dots, z_l]$ such that
  - $\mathbf{p}$ is $S$-invariant, i.e., $p_{\sigma(i)}(z_1,\dots, z_l) = p_i(z_{\sigma(1)}, \dots, z_{\sigma(l)}) = p_i$ for all $i$,
  - $\deg(p_i) =   d-l+i$, where $\deg(\mathbf{q}) = d$, in particular, if $l \ge d+2$, then $p_i = 0$ for $i = 1, \dots, l-d-1$, and
  -  $\mathbf{p} \mathbf{U} = \mathbf{q}$, where $\mathbf{U} \in \mathbb{K}[z_1, \dots, z_l]$ has  determinant a unit in $\mathbb{K}[z_1, \dots, z_l, 1/\Delta]$, with $\Delta = \prod_{1 \le i < j \le l}(z_i - z_j)$ being the  Vandermonde determinant. In other words,  $\mathbf{p}$ and $\mathbf{q}$ generate the same ideal in the localization $\mathbb{K}[z_1, \dots, z_l]_{\Delta}$ of $\mathbb{K}[z_1, \dots, z_l]$. 

$\mathbf{\large Usage}$

The main function is $\mathsf{Equivariant}$ \_ $\mathsf{To}$ \_ $\mathsf{Invariant}(\mathbf{eqs, blocksvars})$ in "EquivToInv.mpl". 
 - $\mathbf{eqs}$ is a list of equivariant polynomials 
 - $\mathbf{blocksvars}$ is a list of blocks of variables for which $\mathbf{eqs}$ is equivariant in


$\mathbf{\large Examples}$

$\mathbf{Example ~1:}$ We consider a sequence $\mathbf{q} = (-12z_1z_2^2z_3^4+2z_1+1, -12z_1^2z_2z_3^4+2z_2+1, -12z_1^2z_2^2z_3^3+2z_3+1)$ of $S_2 \times S_1$-equivariant  polynomials and $S = [[z_1, z_2], [z_3]]$. 

Then $\mathsf{Equivariant}$ \_ $\mathsf{To}$ \_ $\mathsf{Invariant}(\mathbf{q}, S)$ returns $\mathbf{p} = [-12z_1z_2z_3^3, -12z_1^2z_2z_3^3-12z_1z_2^2z_3^3-4, -12z_1^2z_2^2z_3^3+2z_3+1]$ which is block symmetric in $[z_1, z_2]$
and $[z_3]$. 

$\mathbf{Example ~2:}$  Let $\mathbf{q}= [-6z_1z_2^2z_3^4z_4^4+3z_1^2+1, -6z_1^2z_2z_3^4z_4^4+3z_2^2+1, -6z_1^2z_2^2z_3^3z_4^4+3z_3^2+1, -6z_1^2z_2^2z_3^4z_4^3+3z_4^2+1]$ which is $S_2 \times S_2$-equivariant and $S = [[z_1, z_2], [z_3,z_4]]$.

Then $\mathsf{Equivariant}$ \_ $\mathsf{To}$ \_ $\mathsf{Invariant}(\mathbf{q}, S)$ returns $\mathbf{p} = [-6z_1z_2z_3^3z_4^3, -6z_1^2z_2z_3^3z_4^3-6z_1z_2^2z_3^3z_4^3+6, -6z_1^2z_2^2z_3^3z_4^3-3z_3-3z_4, -6z_1^2z_2^2z_3^4z_4^3 6z_1^2z_2^2z_3^3z_4^4+3z_3^2+3z_4^2+2]$ which is block symmetric in $[z_1, z_2]$ and $[z_3,z_4]$.
