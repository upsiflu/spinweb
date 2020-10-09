module Main exposing (main)

import Browser
import Html exposing (Html, text, div, h1, h2, img, br, span, label, hr)
import Html.Attributes exposing (src, class)


import Loop exposing (..)
import Tree exposing (..)
import TreeZipper exposing (..)
import Spinweb exposing (..)



---- MODEL ----


type alias Model =
    {}


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view _ =
    div []
        [ h1 [] [ text "Zippers, Graphs,", br [] [], text " Trees and Loops" ]
        , h2 [] [ text "Loopy Loop" ]
        , span [ class "focus container loop" ] 
               [ Loop.view loop0 ]
        , h2 [] [ text "Tree" ]
        , span [ class "focus container with_3D_effect" ] [ Tree.view tree0 ]
        , h2 [] [ text "Zipper of a Tree" ]
        , span [ class "container" ] 
            [ TreeZipper.view 
                ( treeZipper0 
                    |> TreeZipper.up {-  
                    |> TreeZipper.down 
                    |> TreeZipper.up 
                    |> TreeZipper.down
                    |> TreeZipper.down
                    |> TreeZipper.down-}
                )
            , label [] [ text "viewed with separate focus and exploded context." ]
            ]
        , span [ class "container" ]
            [ Tree.view 
                ( treeZipper0
                    |> TreeZipper.to_tree
                ) 
            , label [] [ text "viewed as a tree, with marked focus." ]
            ]
        , h2 [] [ text "Loop" ]
        , span [ class "container" ] 
            [ Spinweb.view beispiel
            , hr [] []
            , Spinweb.view test
            , Spinweb.view test2
            , Spinweb.view test3
            ]
        ]




berechnen y =
    case y of
        0 -> y
        _ -> y + (berechnen (y-1))




---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }
