module Spinweb exposing (test, test2, test3, view, beispiel)

import Node exposing (Node(..))

import Html exposing (..)
import Html.Attributes exposing (..)



type Spinweb
    = L Node Spinweb
            ( List Spinweb )
            ( List Spinweb )           --Loop
    | S Spinweb ( List Spinweb )       --Sequence
    | N Node ( List Node )             --Node Sequence
    





view : Spinweb -> Html msg
view =
    (\loop -> S loop [])
        >> view_spinweb 
        >> List.singleton 
        >> span [ class "zipper" ]

view_spinweb : Spinweb -> Html msg
view_spinweb spinweb =
    case spinweb of
        -- Loop
        L node initial back forth ->
            span [ class "loop" ] 
                [ span [ class "pivot" ] [ Node.view node ]
                , span [ class "tails" ]
                    [ span [ class "back" ] <| List.map view_spinweb back
                    , span [ class "forth" ] <| List.map view_spinweb ( initial::forth )
                    ]
                ]
        -- Sequence
        S initial rest ->
            span [ class "sequence" ]
                <| List.map view_spinweb ( initial::rest )
        N initial rest ->
            span [ class "nodesequence" ]
                <| List.map Node.view ( initial::rest )


               
        


miniloop: Spinweb
miniloop = L X ( N X [] ) [] []



beispiel : Spinweb
beispiel = miniloop


test: Spinweb
test =
    L A miniloop
        [ S 
          ( L B ( N Wire [ D ] )
                [] 
                []
          )
          [ L C ( N Wire [] )
                [ N Q
                    [ Wire, X ]
                ]
                []
          ]
        ]
        []

test2 : Spinweb
test2 =
    L A ( S 
          ( L B ( N Wire [ D ] )
                [] 
                []
          )
          [ L Q ( N Wire [] )
                []
                []
          ]
        )
        []
        []

test3 : Spinweb
test3 =
    L A miniloop
        [ S 
          ( L B ( S 
                  ( N Wire [ D ] )
                  []
                )
                [ miniloop ] 
                []
          )
          [ L C miniloop
                [ N Q
                    [ Wire, X ]
                ]
                []
          ]
        ]
        [ L A ( N Wire [] )
                [ N Q
                    [ Wire ]
                ]
                []
        ]

