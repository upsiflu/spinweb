module Helpers exposing (nest)


import Html exposing (Html, text, div, h1, h2, img, br, span)
import Html.Attributes exposing (src, class)






nest : List String -> Html msg -> Html msg
nest names content  =
    List.foldr ( \class_name inner -> span [ class class_name ] [ inner ] )
        content names

