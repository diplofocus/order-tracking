module Main exposing (..)

import Html exposing (text, Html, beginnerProgram, div, button, input)
import Html.Events exposing (onInput, onClick)
import Html.Attributes exposing (..)
import List exposing (map)
import String exposing (toInt, filter)


-- Program


main : Program Never Model Msg
main =
    beginnerProgram
        { model = model
        , update = update
        , view = view
        }



-- Models


type alias Model =
    { orders : List Order
    , orderInput : OrderInput
    , error : Maybe String
    }


type alias OrderInput =
    String


type alias Order =
    { id : Int
    , done : Bool
    }


model : Model
model =
    Model [] "" Nothing



-- Update


type Msg
    = AddOrder
    | RemoveOrder Int
    | OrderNumber String


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddOrder ->
            case toInt model.orderInput of
                Err msg ->
                    { model
                        | error = Just msg
                        , orderInput = ""
                    }

                Ok val ->
                    { model
                        | orders = Order val False :: model.orders
                        , orderInput = ""
                        , error = Nothing
                    }

        RemoveOrder id ->
            { model | orders = List.filter (\o -> o.id /= id) model.orders }

        OrderNumber num ->
            { model | orderInput = num }



-- View


view : Model -> Html Msg
view model =
    div [ class "main" ]
        [ renderErrors model.error
        , div [ class "orders" ] (renderOrders model.orders)
        , input [ type_ "text", onInput OrderNumber, placeholder "Broj porudzbine", value model.orderInput ] []
        , button [ onClick AddOrder ] [ text "Dodaj porudzbinu" ]
        ]


renderOrders : List Order -> List (Html Msg)
renderOrders orders =
    List.map renderOrder orders


renderOrder : Order -> Html Msg
renderOrder order =
    div [ class "order" ]
        [ order.id
            |> toString
            |> text
        , button [ class "remove-order", onClick (RemoveOrder order.id) ] [ text "X" ]
        ]


renderErrors : Maybe String -> Html Msg
renderErrors error =
    case error of
        Just _ ->
            div [ class "error" ] [ text "Broj porudzbine mora biti broj." ]

        Nothing ->
            div [] []
