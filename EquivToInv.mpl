(*
Main function: equivariant_to_invariant()

Implementation of the Symmetrize algorithm based on the paper "Computing critical points for invariant algebraic systems J.-C. Faugère, G. Labahn, M. Safey El Din, É. Schost, and T. X. Vu.
*)


##################################################
##################################################
##################################################

(*
Input: A list L, an integer k < nops(L) + 1
Output: The elementary symmetric poly of degree k in the elements of L.

Eg: elementary_pol_value([1,2,4], 2) =  1*2 + 1*4 + 2*4 = 14;
*)

elementary_pol_value := proc(L, k)
local i, pol, n, r, LL, pp;
    n := nops(L); pol:=simplify(expand(mul(y-L[i],i=1..n)),y);
    pp := [seq((-1)^(r+n)*coeff(pol,y,r), r = 0..(n-1))];
    LL := ListTools[Reverse](pp);
    if k=0 then
        return 1;
    else
        return LL[k];
    end if;
end proc;

(*
Input: a list of polynomial polsys, list of vars, list of integers
Output: the list_inters divided differences of polsys
*)
divided_differences_case := proc(polsys, vars, list_inters)
	local LPQ, pq, i, vars_NEW, proc_list, LI, k;
	LPQ := [seq(polsys[list_inters[i]], i=1..nops(list_inters))];
	vars_NEW := [seq(vars[list_inters[i]], i=1..nops(list_inters))];
	proc_list := [];
	for i from 1 to nops(vars_NEW) do:
	    LI := [];
	    for k from 1 to i-1 do:
	    	LI := [op(LI), vars_NEW[i] - vars_NEW[k]];
	    end do;
	    for k from i+1 to nops(vars_NEW) do:
	    	LI := [op(LI), vars_NEW[i] - vars_NEW[k]];
	    end do;
	    proc_list := [op(proc_list), mul(LI[j], j=1..nops(LI))];
    end do;

	return simplify(add(LPQ[i]/proc_list[i], i=1..nops(LPQ)));
end proc;

divided_differences := proc(polsys, vars, list_inters)
    if nops(list_inters) mod 2 = 1 then
        return divided_differences_case(polsys, vars, list_inters);
    else
        return - divided_differences_case(polsys, vars, list_inters);
    end if;
end proc;

##################################################


(*
Input: a list qq S_lambda-equivariant pols, where S_lambda is a direct product of symmetric groups
Ouput: a list S_lambda-invariant pols
*)
equivariant_to_invariant:= proc(qq, Slam)
local tau1, tau, i, j, k, r, ell, tau0, pp, hh, vars;
    tau0 := 0; pp := [seq(0, i=1..nops(qq))];
    hh := [seq(0, i=1..nops(qq))];
    vars := [op(indets(qq))];
    r := nops(Slam);
    tau := []; tau1 := [];
    for i from 1 to r do:
        tau1 := [op(tau1), nops(Slam[i])];
        tau := [op(tau), add(tau1[j], j=1..i)];
    end do;
    ell := map(nops, Slam);

    ### k = 0
    for j from 1 to ell[1] do:
       hh[j]:= add(divided_differences(qq, vars, [i, seq(l, l=j+1..tau[r])]), i=1..j);
    end do;

    for j from 1 to ell[1]-1 do:
        pp[j] := add(elementary_pol_value([seq(vars[m], m=s+2..ell[1])], j-s)*hh[s], s=1..j);
    end do;
    pp[ell[1]]:=hh[ell[1]];

    ### k> 0
    for k from 1 to r-1 do:
        for j from 1 to ell[k+1] do:
            hh[tau[k]+j] := add(divided_differences(qq, vars, [i, seq(l, l=tau[k]+j+1..tau[r])]), i=(tau[k]+1)..(tau[k]+j));
        end do;
    end do;
    for k from 1 to r-1 do:
        for j from 1 to ell[k+1]-1 do:
            pp[tau[k]+j] := add(elementary_pol_value([seq(vars[m], m=tau[k]+s+2..tau[k+1])], j-s)*hh[tau[k]+s], s=1..j);
        end do;
    end do;
    for k from 1 to r-1 do:
        pp[tau[k]+ell[k+1]] := hh[tau[k]+ell[k+1]];
    end do;

    return expand(pp);
end proc;

