(* Implement patricia tree which is based on Fast Mergeable Integer Maps Paper  *)


type node =
  | Empty
  | Leaf of int
  | Branch of int * int * node * node


let lowest_bit x = x land (-x)

let zero_bit k m = (k land m) == 0

let branching_bit p0 p1 = lowest_bit (p0 lxor p1)

let mask p m = p land (m - 1)

let match_prefix k p m = (mask k m) == p

let join (p0, t0, p1, t1) = 
  let m = branching_bit p0 p1 in
  if zero_bit p0 m then 
    Branch (mask p0 m, m, t0, t1)
  else
    Branch (mask p0 m, m, t1, t0) 

(* Add new element k *)
let add k node = 
  let rec insert = function
    | Empty -> Leaf k
    | Leaf i as node ->
      if i == k then node else join (k, Leaf k, i, node)
    | Branch (p, m, t0, t1) as node ->
      if match_prefix k p m then
        if zero_bit k m then
          Branch (p, m, insert t0, t1)
        else 
          Branch (p, m, t0, insert t1)
      else
        join (k, Leaf k, p, node) 
  in 
  insert node


let rec member k = function
  | Empty -> false
  | Leaf i -> k == i
  | Branch (_, m, l, r) -> member k (if zero_bit k m then l else r)

(* Find element k *)
let find k node = if member k node then k else -1

let branch = function
  | (_, _, Empty, node) -> node
  | (_, _, node, Empty) -> node
  | (p, m, t0, t1) -> Branch (p, m, t0, t1)

(* Remove element k *)
let remove k node = 
  let rec remove = function
    | Empty -> Empty
    | Leaf i as node -> if i == k then Empty else node
    | Branch (p, m, t0, t1) -> 
      if match_prefix k p m then
        if zero_bit k m then
          branch (p, m, remove t0, t1)
        else 
          branch (p, m, t0, remove t1)
      else
        node
  in
    remove node  
          
