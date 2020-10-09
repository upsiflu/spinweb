module Node exposing ( Node (..), view, serialize )

import Html exposing (..)
import Html.Attributes exposing (..)

type Node
    = A | B | C | D | E | F | Q | R | S | T | X | Y | Z | Wire | Through | Edge | Focus Node







serialize : Node -> String
serialize node =
    case node of
        Wire -> "wire"
        A -> "A"
        B -> "B"
        C -> "C"
        D -> "D"
        E -> "E"
        F -> "F"
        X -> "X"
        Y -> "Y"
        Z -> "Z"
        Q -> "Quilt"
        R -> "Reticule"
        S -> "Spin"
        T -> "Texture"
        Through -> "through"
        Edge -> "edge"
        Focus n -> "FOCUSED: "++serialize n



view : Node -> Html msg
view node =
    case node of
        Focus n ->
            span [class "focus"] [ view n ]
        Wire ->
            span [class "wire"] [ text "~" ]
        _ -> serialize node |> \x -> span [class "node"] [ text x ]