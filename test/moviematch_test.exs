defmodule MOVIEMATCHTest do
  use ExUnit.Case
  doctest MOVIEMATCH

  test "convert json string to map" do
    input = "{\"name\":\"Devin Torres\",\"age\":27}"
    expected = %{"age" => 27, "name" => "Devin Torres"}
    assert MOVIEMATCH.movie_map(input) == expected
  end

  test "movie_titles with all keys" do
    input = %{"titles" => %{"tq"=> %{"primary"=> %{"title"=> "climax"}}}}
    expected = ["climax"]
    assert MOVIEMATCH.movie_titles(input) == expected
  end

end
