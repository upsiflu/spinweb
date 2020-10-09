module TreeZipper exposing (treeZipper0, view, up, upmost, down, to_tree)

import Html exposing (..)
import Html.Attributes exposing (..)




import Tree exposing (Tree)
import Node exposing (Node(..))

import Helpers exposing (nest)




--TYPES

type TreeZipper
    = TreeZipper
        { tree : Tree 
        , context : List Context
        }



type alias Context =
    { left: List Tree 
    , up : Node
    , right : List Tree }





-- MOVEMENT

up : TreeZipper -> TreeZipper
up (TreeZipper t) =
    case t.context of
        [] -> TreeZipper t
        x::xs ->
            TreeZipper
                { tree = x.left++t.tree::x.right |> List.foldl Tree.append (Tree.singleton x.up)
                , context = xs
                }


down : TreeZipper -> TreeZipper
down (TreeZipper t) =
    case Tree.branches t.tree of
        [] -> TreeZipper t
        x::xs ->
            TreeZipper
                { tree = x 
                , context =
                    { left = []
                    , up = Tree.root t.tree
                    , right = xs
                    }::t.context
                }




upmost : TreeZipper -> TreeZipper
upmost t =
    if up t == t then t else upmost ( up t )

--ANALYZE

to_tree : TreeZipper -> Tree
to_tree =
    mark Focus >> upmost >> (\(TreeZipper { tree }) -> tree)



mark : ( Node -> Node ) -> TreeZipper -> TreeZipper
mark fu (TreeZipper t) =
    TreeZipper
        { t | tree = Tree.mark fu t.tree }

--SYNTHESIZE

treeZipper0:TreeZipper
treeZipper0 =
    TreeZipper
        { tree = 
            Tree.singleton S 
                |> Tree.append Tree.tree1 
                |> Tree.append ( Tree.singleton C |> Tree.append Tree.tree1)
        , context = 
            [ Context 
                [ Tree.tree0 
                    |> Tree.append ( Tree.singleton X )
                ] 
                B 
                [ Tree.singleton C, Tree.tree1, Tree.singleton Y ]
            , Context 
                [ Tree.singleton F
                , Tree.tree1
                , Tree.singleton Z
                ] 
                C 
                [ Tree.tree1 
                    |> Tree.append ( Tree.singleton Q )
                ]
            ]
        }




--VIEW

view : TreeZipper -> Html msg
view (TreeZipper {tree, context}) =
    span [ class "treeZipper" ]
        [ context |> List.reverse |> List.map view_context |> span [class "context" ]
        , tree |> Tree.mark Focus |> Tree.view |> List.singleton |> span [class "focus" ]
        ]

view_context : Context -> Html msg
view_context c =
    span [class "breadcrumb"]
        [ c.up |> Node.view |> nest ["root", "tree", "up"]
        , c.left ++ [ Tree.singleton Edge ] |> List.map Tree.view |> span [ class "left tree"]
        , Tree.singleton Edge :: c.right |> List.map Tree.view |> span [ class "right tree" ]
        ]