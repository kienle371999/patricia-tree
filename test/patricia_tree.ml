(* Test Patricia Tree with AlcoTest *)

open Lib_patricia_tree

let k = 5

let node = Patricia_tree.Empty


let test_add_element () = 
  let new_node = Patricia_tree.add k node in
  let found_element = Patricia_tree.find k new_node in
  Alcotest.(check (int)) "Find Element!!!" k found_element

let test_remove_element () = 
  let new_node = Patricia_tree.remove k node in
  let found_element = Patricia_tree.find k new_node in
  Alcotest.(check (int)) "Remove Element!!!" (-1) found_element


let () =
let open Alcotest in
  run "All Cases" [
    "manipulate-data", [
      test_case "test-add-element" `Quick test_add_element;
      test_case "test-remove-element" `Quick test_remove_element; 
    ]
  ]
  