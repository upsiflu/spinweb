module Tree exposing (Tree, append, branches, prepend, mark, root, singleton, tree0, tree1, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Node exposing (Node(..))



--TYPE


type Tree
    = Tree Node (List Tree)



--SYNTHESIZE


tree0 : Tree
tree0 =
    Tree A [ Tree B [],  Tree C [] ]




{-
    Tree R
        [ Tree B []
        , Tree C
            [ Tree D
                [ Tree R []
                , Tree S [ Tree E [ Tree F [] ] ]
                ]
            ]
        , Tree X
            [ Tree Y [ Tree Q [] ]
            , Tree Z []
            ]
        ]
-}

tree1 : Tree
tree1 =
    Tree Q 
        [ Tree S []
        , Tree R [] 
        ]


singleton : Node -> Tree
singleton n =
    Tree n []



--ANALYZE


branches : Tree -> List Tree
branches (Tree _ b) =
    b


root : Tree -> Node
root (Tree r _) =
    r



--MODIFY


prepend : Tree -> Tree -> Tree
prepend t (Tree node kids) =
    Tree node <| t :: kids


append : Tree -> Tree -> Tree
append t (Tree r b) =
    Tree r <| b ++ [ t ]


mark : ( Node -> Node ) -> Tree -> Tree
mark fu ( Tree r b ) =
    Tree ( fu r ) b



--VIEW


view : Tree -> Html msg
view (Tree r b) =
    span [ class "tree", class (Node.serialize r) ]
        [ r |> Node.view |> List.singleton |> span [ class "root" ]
        , b |> List.map view |> span [ class "branches" ]
        ]
