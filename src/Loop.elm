module Loop exposing (loop0, view)

import Node exposing (..)

import Helpers exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)



{-
A Loop is a tree with additional cross connections (wires).
The wires are woven into the tree construction.
If we assume that each subtree can be reordered arbitrarily,
the we can use this reordering to push the wires onto any lane.
-}


type Loop
    = End Node              -- Drop All
    | Drop Node Loop        -- Keep Wire
    | Fork Fork             -- Split Both
    | Wire Loop             -- Drop Wire

type Fork
    = Part Loop Loop
    | Join Fork

view : Loop -> Html msg
view loop = 
    case loop of
        End n ->
            nest [ "end", "head" ] ( Node.view n )
        Drop n l ->
            span [class "sequence" ] 
                [ nest ["head"] <| Node.view n
                , view l
                ]
        Fork ( Part l r ) ->
            span [class "part"] 
                [ nest ["head"] (text "" )
                , view l |> nest ["left"]
                , view r |> nest ["right"]
                ]
        Fork ( Join f ) ->
            span [class "join" ] [ nest ["head"] (text "" ), view ( Fork f ) ]
        Wire l ->
            span [class "wire" ] [ nest ["head"] (text "" ), view l ]

loop0: Loop
loop0 = 
    Drop A 
        <| Fork <| Join <| Join <| Part
            ( Fork <| Join <| Part
                ( End B )
                ( End C )
            )
            ( Fork <| Join <| Part
                ( End D )
                ( End E )
            )

loop1 : Loop
loop1 =
    Part
        ( Part 
            ( End D ) 
            ( End E )
            |> Join |> Fork 
        )
        ( Part 
            ( End D ) 
            ( End E )
            |> Join |> Fork
        )
    |> Join |> Join |> Fork
    |> Drop A